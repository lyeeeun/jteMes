package jin.mes.cform.mfgMgt.mfgplanMgt.productPlan;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.NewMfgplanDto;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.NewProductPlanDto;
import jin.mes.common.alarm.AlarmMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Service
public class NewProductPlanService {
	
	@Resource
	NewProductPlanMapper newPlanMapper;
	
	@Autowired AlarmMgtService alarmMgtService; 
	
	
	public PageInfo<NewMfgplanDto> getProductPlanList(NewMfgplanDto newPlanDto, PageRequestVo pageRequestVo){
		List<NewMfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		newPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newPlanMapper.selectProductPlanCount(newPlanDto);
			if (rowCount > 0) {
				//List
				planList = newPlanMapper.selectProductPlanList(newPlanDto);
			}
		} catch (Exception e) {
			throw new BusinessException("월간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<NewMfgplanDto>();
		}
		return new PageInfo<NewMfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<NewProductPlanDto> getProductPlanDetail(NewProductPlanDto newProductPlanDto, PageRequestVo pageRequestVo){
		List<NewProductPlanDto> planDetailList = null;
		int rowCount = 0;

		// Page Setting
		newProductPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newProductPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			planDetailList = newPlanMapper.selectProductPlanDetail(newProductPlanDto);
		} catch (Exception e) {
			throw new BusinessException("상세 계획 조회 에러  : " + e.getMessage());
		}
		if (planDetailList == null) {
			planDetailList = new ArrayList<NewProductPlanDto>();
		}
		return new PageInfo<NewProductPlanDto>(planDetailList, pageRequestVo, rowCount);
	}
	
	
	public String setProductPlan(NewProductPlanDto newProductPlanDto){
		String returnKey = "";
		try {
			newProductPlanDto.setCreatorId(JteUtils.getUserId());
			newProductPlanDto.setUpdatorId(JteUtils.getUserId());
			
			if(newProductPlanDto.getAction().equals("C")) { 
				newPlanMapper.insertProductPlan(newProductPlanDto);
				returnKey = newProductPlanDto.getProdPlanId();
			}else if(newProductPlanDto.getAction().equals("U")){ 
				newPlanMapper.updateProductPlan(newProductPlanDto);
				returnKey = newProductPlanDto.getProdPlanId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("계획 입력 에러  : " + e.getMessage());
		}
		
		return returnKey;
	}
}
