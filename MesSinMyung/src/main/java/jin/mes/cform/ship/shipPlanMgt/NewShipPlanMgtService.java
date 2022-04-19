package jin.mes.cform.ship.shipPlanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewShipPlanMgtService {

	@Resource
    protected NewShipPlanMgtMapper newShipPlanMgtMapper;
	
    public PageInfo<NewShipPlanMgtDto> getShipPlanList(NewShipPlanMgtDto shipPlanMgtDto, PageRequestVo pageRequestVo){
    	List<NewShipPlanMgtDto> shipPlanList = null;
		int rowCount = 0;

		shipPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newShipPlanMgtMapper.rowCount(shipPlanMgtDto);
			if (rowCount > 0) {
				shipPlanList = newShipPlanMgtMapper.selectShipPlanList(shipPlanMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (shipPlanList == null) {
			shipPlanList = new ArrayList<NewShipPlanMgtDto>();
		}
		return new PageInfo<NewShipPlanMgtDto>(shipPlanList, pageRequestVo, rowCount);
	}
    
    public PageInfo<NewShipPlanMgtDto> getShipCompList(NewShipPlanMgtDto shipPlanMgtDto, PageRequestVo pageRequestVo){
    	List<NewShipPlanMgtDto> shipCompList = null;
		int rowCount = 0;

		shipPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newShipPlanMgtMapper.selectShipCompCount(shipPlanMgtDto);
			if (rowCount > 0) {
				shipCompList = newShipPlanMgtMapper.selectShipCompList(shipPlanMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (shipCompList == null) {
			shipCompList = new ArrayList<NewShipPlanMgtDto>();
		}
		return new PageInfo<NewShipPlanMgtDto>(shipCompList, pageRequestVo, rowCount);
	}
    
    public int getShipCompleteQty(NewShipPlanMgtDto shipPlanMgtDto){
		int shipCompleteQty = 0;
		try {
			shipCompleteQty = newShipPlanMgtMapper.selectShipCompleteQty(shipPlanMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getShipCompleteQty Error " + e.getMessage());
		}
		return shipCompleteQty;
	}
    
    @Transactional
	public String setShipPlan(NewShipPlanMgtDto shipPlanMgtDto){
		String returnKey = "";
		try {
			newShipPlanMgtMapper.insertShipPlan(shipPlanMgtDto);
			
//			if(shipPlanMgtDto.getBundleInsertList() != null) {
//				shipPlanMgtDto.getBundleInsertList().forEach(x -> {
//					newShipPlanMgtMapper.insertBundleList(shipPlanMgtDto.getShipId(), x.getBundleQty(), x.getBundleUnit());
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
   	public String updateShipPlan(NewShipPlanMgtDto shipPlanMgtDto){
   		String returnKey = "";
   		try {
   			newShipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);
   			
//   			if(shipPlanMgtDto.getBundleInsertList() != null) {
//				shipPlanMgtDto.getBundleInsertList().forEach(x -> {
//					newShipPlanMgtMapper.insertBundleList(shipPlanMgtDto.getShipId(), x.getBundleQty(), x.getBundleUnit());
//				});
//			}
//   			
//   			if(shipPlanMgtDto.getBundleUpdateList() != null) {
//				shipPlanMgtDto.getBundleUpdateList().forEach(x -> {
//					newShipPlanMgtMapper.updateBundleList(shipPlanMgtDto.getShipId(), x.getBundleQty(), x.getBundleUnit());
//				});
//			}
//   			
//   			if(shipPlanMgtDto.getBundleDeleteList() != null) {
//				shipPlanMgtDto.getBundleDeleteList().forEach(x -> {
//					newShipPlanMgtMapper.deleteBundleList(shipPlanMgtDto.getShipId(), x.getBundleQty(), x.getBundleUnit());
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
	public int deleteShipPlan(List<NewShipPlanMgtDto> shipPlanList){
		int resultInt = -1;
		try {
			for(NewShipPlanMgtDto shipPlanMgtDto : shipPlanList){
				resultInt = newShipPlanMgtMapper.deleteShipPlan(shipPlanMgtDto);
				newShipPlanMgtMapper.deleteAllBundleList(shipPlanMgtDto.getShipId());
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
//			shipRtlBundleList = newShipPlanMgtMapper.selectRtlBundleList(shipPlanMgtDto);
//		} catch (Exception e) {
//			throw new BusinessException("Service: getRtlBundleList Error " + e.getMessage());
//		}
//		return shipRtlBundleList;
//	}
    
    
    
}
