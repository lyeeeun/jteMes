package jin.mes.form.ship.shipPlanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.mapper.ship.shipPlanMgt.ShipPlanMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ShipPlanMgtService {

	@Resource
    protected ShipPlanMgtMapper shipPlanMgtMapper;
	
    public PageInfo<ShipPlanMgtDto> getShipPlanList(ShipPlanMgtDto shipPlanMgtDto, PageRequestVo pageRequestVo){
    	List<ShipPlanMgtDto> shipPlanList = null;
		int rowCount = 0;

		shipPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = shipPlanMgtMapper.rowCount(shipPlanMgtDto);
			if (rowCount > 0) {
				shipPlanList = shipPlanMgtMapper.selectShipPlanList(shipPlanMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (shipPlanList == null) {
			shipPlanList = new ArrayList<ShipPlanMgtDto>();
		}
		return new PageInfo<ShipPlanMgtDto>(shipPlanList, pageRequestVo, rowCount);
	}
    
    public PageInfo<ShipPlanMgtDto> getShipCompList(ShipPlanMgtDto shipPlanMgtDto, PageRequestVo pageRequestVo){
    	List<ShipPlanMgtDto> shipCompList = null;
		int rowCount = 0;

		shipPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = shipPlanMgtMapper.selectShipCompCount(shipPlanMgtDto);
			if (rowCount > 0) {
				shipCompList = shipPlanMgtMapper.selectShipCompList(shipPlanMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (shipCompList == null) {
			shipCompList = new ArrayList<ShipPlanMgtDto>();
		}
		return new PageInfo<ShipPlanMgtDto>(shipCompList, pageRequestVo, rowCount);
	}
    
    public int getShipCompleteQty(ShipPlanMgtDto shipPlanMgtDto){
		int shipCompleteQty = 0;
		try {
			shipCompleteQty = shipPlanMgtMapper.selectShipCompleteQty(shipPlanMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getShipCompleteQty Error " + e.getMessage());
		}
		return shipCompleteQty;
	}
    
    @Transactional
	public String setShipPlan(ShipPlanMgtDto shipPlanMgtDto){
		String returnKey = "";
		try {
			shipPlanMgtMapper.insertShipPlan(shipPlanMgtDto);
			
//			if(shipPlanMgtDto.getBundleInsertList() != null) {
//				shipPlanMgtDto.getBundleInsertList().forEach(x -> {
//					shipPlanMgtMapper.insertBundleList(shipPlanMgtDto.getShipId(), x.getBundleQty(), x.getBundleUnit());
//				});
//			}
//			
			returnKey = shipPlanMgtDto.getShipId();
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("Claim정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
    
    @Transactional
   	public String updateShipPlan(ShipPlanMgtDto shipPlanMgtDto){
   		String returnKey = "";
   		try {
   			shipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);
   			
//   			if(shipPlanMgtDto.getBundleInsertList() != null) {
//				shipPlanMgtDto.getBundleInsertList().forEach(x -> {
//					shipPlanMgtMapper.insertBundleList(shipPlanMgtDto.getShipId(), x.getBundleQty(), x.getBundleUnit());
//				});
//			}
//   			
//   			if(shipPlanMgtDto.getBundleUpdateList() != null) {
//				shipPlanMgtDto.getBundleUpdateList().forEach(x -> {
//					shipPlanMgtMapper.updateBundleList(shipPlanMgtDto.getShipId(), x.getBundleQty(), x.getBundleUnit());
//				});
//			}
//   			
//   			if(shipPlanMgtDto.getBundleDeleteList() != null) {
//				shipPlanMgtDto.getBundleDeleteList().forEach(x -> {
//					shipPlanMgtMapper.deleteBundleList(shipPlanMgtDto.getShipId(), x.getBundleQty(), x.getBundleUnit());
//				});
//			}
   			
   			returnKey = shipPlanMgtDto.getShipId();
   		} catch (Exception e) {
   			returnKey = "";
   			throw new BusinessException("Claim정보 저장 에러 : " + e.getMessage());
   		}
   		return returnKey;
   	}
    
    @Transactional
	public int deleteShipPlan(List<ShipPlanMgtDto> shipPlanList){
		int resultInt = -1;
		try {
			for(ShipPlanMgtDto shipPlanMgtDto : shipPlanList){
				resultInt = shipPlanMgtMapper.deleteShipPlan(shipPlanMgtDto);
				shipPlanMgtMapper.deleteAllBundleList(shipPlanMgtDto.getShipId());
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Claim정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
    
//    public List<ShipPlanMgtDto> getRtlBundleList(ShipPlanMgtDto shipPlanMgtDto){
//		List<ShipPlanMgtDto> shipRtlBundleList = null;
//		try {
//			shipRtlBundleList = shipPlanMgtMapper.selectRtlBundleList(shipPlanMgtDto);
//		} catch (Exception e) {
//			throw new BusinessException("Service: getRtlBundleList Error " + e.getMessage());
//		}
//		return shipRtlBundleList;
//	}
    
    
    
}
