package jin.mes.cform.mfgMgt.mfgplanMgt.productPlan;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.ZinixMfgplanDto;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.ZinixProductPlanDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//defalut
@Service
public class ZinixProductPlanService{
	
	@Resource
	ZinixProductPlanMapper zinixProductPlanMapper;
	
	@Autowired AlarmMgtService alarmMgtService; 
	
	
	public PageInfo<ZinixMfgplanDto> getProductPlanList(ZinixMfgplanDto planDto, PageRequestVo pageRequestVo){
		List<ZinixMfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		planDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		planDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixProductPlanMapper.selectProductPlanCount(planDto);
			if (rowCount > 0) {
				//List
				planList = zinixProductPlanMapper.selectProductPlanList(planDto);
			}
		} catch (Exception e) {
			throw new BusinessException("월간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<ZinixMfgplanDto>();
		}
		return new PageInfo<ZinixMfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<ZinixProductPlanDto> getProductPlanDetail(ZinixProductPlanDto productPlanDto, PageRequestVo pageRequestVo){
		List<ZinixProductPlanDto> planDetailList = null;
		int rowCount = 0;

		// Page Setting
		productPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		productPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			planDetailList = zinixProductPlanMapper.selectProductPlanDetail(productPlanDto);
		} catch (Exception e) {
			throw new BusinessException("상세 계획 조회 에러  : " + e.getMessage());
		}
		if (planDetailList == null) {
			planDetailList = new ArrayList<ZinixProductPlanDto>();
		}
		return new PageInfo<ZinixProductPlanDto>(planDetailList, pageRequestVo, rowCount);
	}
	
	
	public String setProductPlan(ZinixProductPlanDto productPlanDto){
		String returnKey = "";
		try {
			productPlanDto.setCreatorId(JteUtils.getUserId());
			productPlanDto.setUpdatorId(JteUtils.getUserId());
			
			if(productPlanDto.getAction().equals("C")) { 
				zinixProductPlanMapper.insertProductPlan(productPlanDto);
				returnKey = productPlanDto.getProdPlanId();
			}else if(productPlanDto.getAction().equals("U")){ 
				zinixProductPlanMapper.updateProductPlan(productPlanDto);
				returnKey = productPlanDto.getProdPlanId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("계획 입력 에러  : " + e.getMessage());
		}
		
		return returnKey;
	}
}
