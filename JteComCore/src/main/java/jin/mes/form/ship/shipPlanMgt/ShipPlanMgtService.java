package jin.mes.form.ship.shipPlanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ShipPlanMgtService {

	
	@Resource
    protected ShipPlanMgtMapper shipPlanMgtMapper;
	
	//출하계획 조회
		public PageInfo<ShipPlanMgtDto> getShipPlanList(ShipPlanMgtDto shipPlanMgtDto, PageRequestVo pageRequestVo){
	    	List<ShipPlanMgtDto> shipPlanList = null;
			int rowCount = 0;

			shipPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			shipPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				rowCount = shipPlanMgtMapper.selectShipPlanCount(shipPlanMgtDto);
				if (rowCount > 0) {
					shipPlanList = shipPlanMgtMapper.selectShipPlanList(shipPlanMgtDto);
				}
			} catch (Exception e) {
				throw new BusinessException("getShipPlanList 조회 에러입니다. : " + e.getMessage());
			}

			if (shipPlanList == null) {
				shipPlanList = new ArrayList<ShipPlanMgtDto>();
			}
			return new PageInfo<ShipPlanMgtDto>(shipPlanList, pageRequestVo, rowCount);
		}
		
		//lot별 생산재고량 조회
		public PageInfo<ShipPlanMgtDto> getLotStockList(ShipPlanMgtDto shipPlanMgtDto, PageRequestVo pageRequestVo){
	    	List<ShipPlanMgtDto> lotStockList = null;
			int rowCount = 0;

			shipPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			shipPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				rowCount = shipPlanMgtMapper.selectLotStockCount(shipPlanMgtDto);
				if (rowCount > 0) {
					lotStockList = shipPlanMgtMapper.selectLotStockList(shipPlanMgtDto);
				}
			} catch (Exception e) {
				throw new BusinessException("getLotStockList 조회 에러입니다. : " + e.getMessage());
			}

			if (lotStockList == null) {
				lotStockList = new ArrayList<ShipPlanMgtDto>();
			}
			return new PageInfo<ShipPlanMgtDto>(lotStockList, pageRequestVo, rowCount);
		}
		
		//출하계획 저장
		@Transactional
		public String setShipPlanSave(ShipPlanMgtDto shipPlanMgtDto) {
			String returnKey = "";
			try {
				shipPlanMgtDto.setCreatorId(JteUtils.getUserId());
				shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(shipPlanMgtDto.getAction().equals("C")) { //출하계획 등록
					
					//출하계획 입력
					shipPlanMgtMapper.insertShipPlan(shipPlanMgtDto);
					
					returnKey =  shipPlanMgtDto.getShipPlanId();
					
				}else if(shipPlanMgtDto.getAction().equals("U")) { //출하계획 수정
					//출하계획 수정
					shipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);
					
					returnKey =  shipPlanMgtDto.getShipPlanId();
				}
				
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("출하 계획 입력 에러 : " + e.getMessage());
			}
			return returnKey;
		};
		
		//출하계획 삭제
		@Transactional(rollbackFor = {Exception.class})
		public String setShipPlanDelete(List<ShipPlanMgtDto> shipPlanList){
			String resultStr = "success";
			try {
				for(ShipPlanMgtDto shipPlanMgtDto : shipPlanList){
					if(!shipPlanMgtDto.getShipPlanState().equals("shipSta01")) {
						resultStr = "shipping";
						throw new Exception();
					}
					shipPlanMgtMapper.deleteShipPlan(shipPlanMgtDto);
				}
			} catch (Exception e) {
				if(!resultStr.equals("shipping")) {
					resultStr = "error";
				}
			}	
			return resultStr;
		}
	

}
