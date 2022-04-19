package jin.mes.cform.ship.shipPlanMgt;

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
public class KwangjinShipPlanMgtService {

	
	@Resource
    protected KwangjinShipPlanMgtMapper kwangjinShipPlanMgtMapper;
	
	//출하계획 조회
		public PageInfo<KwangjinShipPlanMgtDto> getShipPlanList(KwangjinShipPlanMgtDto shipPlanMgtDto, PageRequestVo pageRequestVo){
	    	List<KwangjinShipPlanMgtDto> shipPlanList = null;
			int rowCount = 0;

			shipPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			shipPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				rowCount = kwangjinShipPlanMgtMapper.selectShipPlanCount(shipPlanMgtDto);
				if (rowCount > 0) {
					shipPlanList = kwangjinShipPlanMgtMapper.selectShipPlanList(shipPlanMgtDto);
				}
			} catch (Exception e) {
				throw new BusinessException("getShipPlanList 조회 에러입니다. : " + e.getMessage());
			}

			if (shipPlanList == null) {
				shipPlanList = new ArrayList<KwangjinShipPlanMgtDto>();
			}
			return new PageInfo<KwangjinShipPlanMgtDto>(shipPlanList, pageRequestVo, rowCount);
		}
		
		//lot별 생산재고량 조회
		public PageInfo<KwangjinShipPlanMgtDto> getLotStockList(KwangjinShipPlanMgtDto shipPlanMgtDto, PageRequestVo pageRequestVo){
	    	List<KwangjinShipPlanMgtDto> lotStockList = null;
			int rowCount = 0;

			shipPlanMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			shipPlanMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				rowCount = kwangjinShipPlanMgtMapper.selectLotStockCount(shipPlanMgtDto);
				if (rowCount > 0) {
					lotStockList = kwangjinShipPlanMgtMapper.selectLotStockList(shipPlanMgtDto);
				}
			} catch (Exception e) {
				throw new BusinessException("getLotStockList 조회 에러입니다. : " + e.getMessage());
			}

			if (lotStockList == null) {
				lotStockList = new ArrayList<KwangjinShipPlanMgtDto>();
			}
			return new PageInfo<KwangjinShipPlanMgtDto>(lotStockList, pageRequestVo, rowCount);
		}
		
		//출하계획 저장
		@Transactional
		public String setShipPlanSave(KwangjinShipPlanMgtDto shipPlanMgtDto) {
			String returnKey = "";
			try {
				shipPlanMgtDto.setCreatorId(JteUtils.getUserId());
				shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(shipPlanMgtDto.getAction().equals("C")) { //출하계획 등록
					
					shipPlanMgtDto.setShipInspect("shipInspectWait");
					//출하계획 입력
					kwangjinShipPlanMgtMapper.insertShipPlan(shipPlanMgtDto);
					
					//lot 상태 납품 진행중으로 변경
					shipPlanMgtDto.setLotState("ord_sta03");
					kwangjinShipPlanMgtMapper.updateLotState(shipPlanMgtDto);
					
					returnKey =  shipPlanMgtDto.getShipPlanId();
					
				}else if(shipPlanMgtDto.getAction().equals("U")) { //출하계획 수정
					//출하계획 수정
					kwangjinShipPlanMgtMapper.updateShipPlan(shipPlanMgtDto);
					
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
		public String setShipPlanDelete(List<KwangjinShipPlanMgtDto> shipPlanList){
			String resultStr = "success";
			try {
				for(KwangjinShipPlanMgtDto shipPlanMgtDto : shipPlanList){
					if(!shipPlanMgtDto.getShipPlanState().equals("shipSta01")) {
						resultStr = "shipping";
						throw new Exception();
					}
					kwangjinShipPlanMgtMapper.deleteShipPlan(shipPlanMgtDto);
				}
			} catch (Exception e) {
				if(!resultStr.equals("shipping")) {
					resultStr = "error";
				}
			}	
			return resultStr;
		}
	

}
