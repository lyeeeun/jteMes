package jin.mes.cform.ship.shipPlanMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.alarm.AlarmMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ZinixShipPlanMgtService {

	@Autowired AlarmMgtService alarmMgtService; 
	
	@Resource
    protected ZinixShipPlanMgtMapper zinixPlanMapper;
	
	public PageInfo<ZinixShipPlanMgtDto> getShipPlanList(ZinixShipPlanMgtDto planDto, PageRequestVo pageRequestVo){
		List<ZinixShipPlanMgtDto> planList = null;
		int rowCount = 0;

		// Page Setting
		planDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		planDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixPlanMapper.selectShipPlanCount(planDto);
			if (rowCount > 0) {
				//List
				planList = zinixPlanMapper.selectShipPlanList(planDto);
			}
		} catch (Exception e) {
			throw new BusinessException("월간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<ZinixShipPlanMgtDto>();
		}
		return new PageInfo<ZinixShipPlanMgtDto>(planList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<ZinixShipPlanMgtDto> getShipPlanDetail(ZinixShipPlanMgtDto shipPlanDto, PageRequestVo pageRequestVo){
		List<ZinixShipPlanMgtDto> planDetailList = null;
		int rowCount = 0;

		// Page Setting
		shipPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		shipPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			planDetailList = zinixPlanMapper.selectShipPlanDetail(shipPlanDto);
		} catch (Exception e) {
			throw new BusinessException("상세 계획 조회 에러  : " + e.getMessage());
		}
		if (planDetailList == null) {
			planDetailList = new ArrayList<ZinixShipPlanMgtDto>();
		}
		return new PageInfo<ZinixShipPlanMgtDto>(planDetailList, pageRequestVo, rowCount);
	}
	
	public String setShipPlan(ZinixShipPlanMgtDto shipPlanDto){
		String returnKey = "";
		try {
			shipPlanDto.setCreatorId(JteUtils.getUserId());
			shipPlanDto.setUpdatorId(JteUtils.getUserId());
			
			if(shipPlanDto.getAction().equals("C")) { 
				zinixPlanMapper.insertShipPlan(shipPlanDto);
				returnKey = shipPlanDto.getShipPlanId();
			}else if(shipPlanDto.getAction().equals("U")){ 
				zinixPlanMapper.updateShipPlan(shipPlanDto);
				returnKey = shipPlanDto.getShipPlanId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("계획 입력 에러  : " + e.getMessage());
		}
		
		return returnKey;
	}
	
    public PageInfo<ZinixShipPlanMgtDto> getShipCompList(ZinixShipPlanMgtDto planDto, PageRequestVo pageRequestVo){
    	List<ZinixShipPlanMgtDto> shipCompList = null;
		int rowCount = 0;

		planDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		planDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = zinixPlanMapper.selectShipCompCount(planDto);
			if (rowCount > 0) {
				shipCompList = zinixPlanMapper.selectShipCompList(planDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (shipCompList == null) {
			shipCompList = new ArrayList<ZinixShipPlanMgtDto>();
		}
		return new PageInfo<ZinixShipPlanMgtDto>(shipCompList, pageRequestVo, rowCount);
	}
}
