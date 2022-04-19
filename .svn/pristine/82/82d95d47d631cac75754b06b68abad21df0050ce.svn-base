package jin.mes.cform.ship.pickMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ZinixPickMgtService {

	@Resource
    protected ZinixPickMgtMapper zinixPickMgtMapper;
	
	@Autowired
	ZinixItemStockMgtService itemStockService; 

	public PageInfo<ZinixPickMgtDto> selectPickInfo(ZinixPickMgtDto pickMgtDto, PageRequestVo pageRequestVo){
		List<ZinixPickMgtDto> pickInfoList = null;
		int rowCount = 0;

		pickMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		pickMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = zinixPickMgtMapper.selectPickInfoCount(pickMgtDto);
			if (rowCount > 0) {
				pickInfoList = zinixPickMgtMapper.selectPickInfo(pickMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (pickInfoList == null) {
			pickInfoList = new ArrayList<ZinixPickMgtDto>();
		}
		return new PageInfo<ZinixPickMgtDto>(pickInfoList, pageRequestVo, rowCount);
	}
	
	public PageInfo<ZinixPickMgtDto> selectBarcodeInfo(ZinixPickMgtDto pickMgtDto, PageRequestVo pageRequestVo){
		List<ZinixPickMgtDto> barcodeInfoList = null;
		int rowCount = 0;

		pickMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		pickMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = zinixPickMgtMapper.selectBarcodeInfoCount(pickMgtDto);
			if (rowCount > 0) {
				barcodeInfoList = zinixPickMgtMapper.selectBarcodeInfo(pickMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (barcodeInfoList == null) {
			barcodeInfoList = new ArrayList<ZinixPickMgtDto>();
		}
		return new PageInfo<ZinixPickMgtDto>(barcodeInfoList, pageRequestVo, rowCount);
	}

	public List<ZinixPickMgtDto> selectBarcodeInfoAll(ZinixPickMgtDto pickMgtDto) {
		List<ZinixPickMgtDto> barcodeInfoList = null;
		try {
			barcodeInfoList = zinixPickMgtMapper.selectBarcodeInfoAll(pickMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectBarcodeInfoAll : " + e.getMessage());
		}
		return barcodeInfoList;
	}
	
	
	@Transactional
	public String setPickInfo(ZinixPickMgtDto pickMgtDto){
		String returnKey = "";
		try {
			
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = dateFormat.format(dateTime);
			
			
			if(pickMgtDto.getAction().equals("C")) {
				pickMgtDto.setCreatorId(JteUtils.getUserId());
				
				zinixPickMgtMapper.insertPickInfo(pickMgtDto);
				
				for(ZinixPickMgtDto barcode : pickMgtDto.getBarcodeList()) {
					barcode.setItemMgtId(pickMgtDto.getItemMgtId());
					barcode.setPickId(pickMgtDto.getPickId());
					zinixPickMgtMapper.insertBarcode(barcode);
				}
				
				ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto(pickMgtDto.getItemId(), pickMgtDto.getItemMgtId(), -pickMgtDto.getPickQty(),
							"prod_tagt02", pickMgtDto.getPickId(), nowDateTime, pickMgtDto.getCreatorId());
				itemStockMgtDto.setAction("C");
				itemStockService.setItemStockPgSave(itemStockMgtDto);
				
			} else if(pickMgtDto.getAction().equals("U")) {
				zinixPickMgtMapper.updatePickInfo(pickMgtDto);
				
				for(ZinixPickMgtDto barcode : pickMgtDto.getBarcodeList()) {
					
					barcode.setItemMgtId(pickMgtDto.getItemMgtId());
					barcode.setPickId(pickMgtDto.getPickId());

					if(barcode.getAction().equals("C")) {
						zinixPickMgtMapper.insertBarcode(barcode);
					} else if(barcode.getAction().equals("D")) {
						zinixPickMgtMapper.deleteBarcode(barcode);
					}
				}
				
				ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto(pickMgtDto.getItemId(), pickMgtDto.getItemMgtId(), -pickMgtDto.getPickQty(),
						"prod_tagt02", pickMgtDto.getPickId(), nowDateTime, pickMgtDto.getCreatorId());
				itemStockMgtDto.setAction("U");
				itemStockService.setItemStockPgSave(itemStockMgtDto);	
				
				// Update 시, 포장 재고량은 기존 포장 수량 - 변경 된 포장 수량
				pickMgtDto.setPickQty(pickMgtDto.getUpdatePickQty());
			}
		
			zinixPickMgtMapper.updatePackageStock(pickMgtDto);
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("setPickInfo : " + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public int deletePickInfo(List<ZinixPickMgtDto> pickMgtDtoList){
		int resultInt = -1;
		try {
			
			for(ZinixPickMgtDto pickMgtDto : pickMgtDtoList){
				zinixPickMgtMapper.deletePickInfo(pickMgtDto);
				zinixPickMgtMapper.deleteBarcode(pickMgtDto);
				
				pickMgtDto.setPickQty(-pickMgtDto.getPickQty());
				
				ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto(pickMgtDto.getItemId(), pickMgtDto.getItemMgtId(), -pickMgtDto.getPickQty(),
						"prod_tagt02", pickMgtDto.getPickId(), "", pickMgtDto.getCreatorId());
				itemStockMgtDto.setAction("D");
				
				itemStockService.setItemStockPgSave(itemStockMgtDto);	
				
				zinixPickMgtMapper.updatePackageStock(pickMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("deletePickInfo : " + e.getMessage());
		}
		return resultInt;
	}
	
}
