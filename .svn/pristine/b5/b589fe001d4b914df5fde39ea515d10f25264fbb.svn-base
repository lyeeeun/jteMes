package jin.mes.cform.ship.shipMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.ship.pickMgt.ZinixPickMgtDto;
import jin.mes.cform.ship.pickMgt.ZinixPickMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ZinixShipMgtService {
	
	@Resource
    protected ZinixShipMgtMapper zinixShipMgtMapper;
	
	@Resource
    protected ZinixPickMgtMapper zinixPickMgtMapper;
	
	
	public PageInfo<ZinixShipMgtDto> selectShipInfo(ZinixShipMgtDto shipMgtDto, PageRequestVo pageRequestVo){
		List<ZinixShipMgtDto> shipInfoList = null;
		int rowCount = 0;

		shipMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = zinixShipMgtMapper.selectShipInfoCount(shipMgtDto);
			if (rowCount > 0) {
				shipInfoList = zinixShipMgtMapper.selectShipInfo(shipMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (shipInfoList == null) {
			shipInfoList = new ArrayList<ZinixShipMgtDto>();
			if(!shipMgtDto.getCurrentMenuId().equals(null) && shipMgtDto.getCurrentMenuId().equals("asHisMgt")) {
				shipInfoList.add(new ZinixShipMgtDto());
			}else if(!shipMgtDto.getCurrentMenuId().equals(null) && shipMgtDto.getCurrentMenuId().equals("barcodeHistory")) {
				shipInfoList.add(new ZinixShipMgtDto());
			}
		}
		return new PageInfo<ZinixShipMgtDto>(shipInfoList, pageRequestVo, rowCount);
	}

	public ZinixShipMgtDto selectShipRtlBarcode(ZinixShipMgtDto shipMgtDto){
		try {
			shipMgtDto.setShipRtlBarcodeList(zinixShipMgtMapper.selectShipRtlBarcode(shipMgtDto));
		} catch (Exception e) {
			log.error(e.toString());
		}
		return shipMgtDto;
	}
	
	public PageInfo<ZinixShipMgtDto> selectBarcodeInfo(ZinixShipMgtDto shipMgtDto, PageRequestVo pageRequestVo){
		List<ZinixShipMgtDto> barcodeInfoList = null;
		int rowCount = 0;

		shipMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = zinixShipMgtMapper.selectBarcodeInfoCount(shipMgtDto);
			if (rowCount > 0) {
				barcodeInfoList = zinixShipMgtMapper.selectBarcodeInfo(shipMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (barcodeInfoList == null) {
			barcodeInfoList = new ArrayList<ZinixShipMgtDto>();
		}
		return new PageInfo<ZinixShipMgtDto>(barcodeInfoList, pageRequestVo, rowCount);
	}
	
	
	@Transactional
	public void setShipInfo(ZinixShipMgtDto shipMgtDto){
		try {
			
			if(shipMgtDto.getAction().equals("C")) {
				// shipMgtDto.setShipQty(shipMgtDto.getShipRtlBarcodeList().size());
				//상태 - 납기 진행
				shipMgtDto.setShipState("ship_dvry02");
				zinixShipMgtMapper.insertShipInfo(shipMgtDto);
				shipMgtDto.setLotState("ord_sta03");
				zinixShipMgtMapper.updateLotState(shipMgtDto);
				
				setShipRtlBarcode(shipMgtDto);
				updatePackageStock(shipMgtDto);
			} else if (shipMgtDto.getAction().equals("U")) {
				if(shipMgtDto.getShipCompleteDate() == "") {
					shipMgtDto.setShipCompleteDate(null);
				}
				zinixShipMgtMapper.updateShipInfo(shipMgtDto);
				
				if(shipMgtDto.getLotState() != null) {
					if(!shipMgtDto.getLotState().equals("ord_sta03")) {
						shipMgtDto.setLotState("ord_sta04");
						zinixShipMgtMapper.updateLotState(shipMgtDto);
					}
				}
				
				if(shipMgtDto.getShipRtlBarcodeList() != null) {
					setShipRtlBarcode(shipMgtDto);
					
					shipMgtDto.setShipQty(shipMgtDto.getUpdateShipQty());
					updatePackageStock(shipMgtDto);
				}
			}
			
			
		} catch (Exception e) {
			throw new BusinessException("setShipInfo : " + e.getMessage());
		}
	}
	
	@Transactional
	public void setShipRtlBarcode(ZinixShipMgtDto shipMgtDto) {
		String shipId = shipMgtDto.getShipId();
		for(ZinixShipMgtDto shipInfo : shipMgtDto.getShipRtlBarcodeList()) {
			shipInfo.setShipId(shipId);
			if(shipInfo.getAction().equals("C")) {
				zinixShipMgtMapper.insertShipRtlBarcode(shipInfo);
			} else if(shipInfo.getAction().equals("D")) {
				zinixShipMgtMapper.deleteShipRtlBarcode(shipInfo);
			}
		}
	}
	
	@Transactional
	public void deleteShipInfo(List<ZinixShipMgtDto> shipMgtDto){
		try {
			for(ZinixShipMgtDto shipInfo : shipMgtDto) {
				zinixShipMgtMapper.deleteShipInfo(shipInfo);
				zinixShipMgtMapper.deleteShipRtlBarcode(shipInfo);
				
				shipInfo.setShipQty(-shipInfo.getShipQty());
				updatePackageStock(shipInfo);
			}
		} catch (Exception e) {
			throw new BusinessException("deleteShipInfo : " + e.getMessage());
		}
	}
	
	public void updatePackageStock(ZinixShipMgtDto shipMgtDto) {
		try {
			// 상태 변경 시 동작
			ZinixPickMgtDto pickMgtDto = new ZinixPickMgtDto();
			pickMgtDto.setItemMgtId(shipMgtDto.getItemMgtId());
			pickMgtDto.setPickQty(-shipMgtDto.getShipQty());
			zinixPickMgtMapper.updatePackageStock(pickMgtDto);
			
		} catch (Exception e) {
			throw new BusinessException("updatePackageStock : " + e.getMessage());
		}
	}
	
	public ZinixShipMgtDto selectLotState(ZinixShipMgtDto shipMgtDto){
		try {
			shipMgtDto.setLotState(zinixShipMgtMapper.selectLotState(shipMgtDto));
		} catch (Exception e) {
			log.error(e.toString());
		}
		return shipMgtDto;
	}
	
	public void allShipComplete(ZinixShipMgtDto shipMgtDto) {
		try {
			shipMgtDto.setLotState("ord_sta04");
			zinixShipMgtMapper.updateLotState(shipMgtDto);
			shipMgtDto.setShipState("ship_dvry03");
			zinixShipMgtMapper.updateShipInfo(shipMgtDto);
		} catch (Exception e) {
			throw new BusinessException("allShipComplete : " + e.getMessage());
		}
	}

}
