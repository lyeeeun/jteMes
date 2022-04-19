package jin.mes.cform.mfgMgt.productPlan;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.form.mfgMgt.mfgplanMgt.mfgplan.MfgplanDto;
import jin.mes.form.mfgMgt.mfgplanMgt.mfgplan.ProductPlanDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//defalut
@Service
public class KwangjinProductPlanService{
	
	@Resource
	KwangjinProductPlanMapper kwangjinProductPlanMapper;
	
	@Autowired AlarmMgtService alarmMgtService; 
	
	
	public PageInfo<MfgplanDto> getProductPlanList(MfgplanDto planDto, PageRequestVo pageRequestVo){
		List<MfgplanDto> planList = null;
		int rowCount = 0;

		// Page Setting
		planDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		planDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinProductPlanMapper.selectProductPlanCount(planDto);
			if (rowCount > 0) {
				//List
				planList = kwangjinProductPlanMapper.selectProductPlanList(planDto);
			}
		} catch (Exception e) {
			throw new BusinessException("월간 계획 조회 에러 : " + e.getMessage());
		}
		if (planList == null) {
			planList = new ArrayList<MfgplanDto>();
		}
		return new PageInfo<MfgplanDto>(planList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<ProductPlanDto> getProductPlanDetail(ProductPlanDto productPlanDto, PageRequestVo pageRequestVo){
		List<ProductPlanDto> planDetailList = null;
		int rowCount = 0;

		// Page Setting
		productPlanDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		productPlanDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			planDetailList = kwangjinProductPlanMapper.selectProductPlanDetail(productPlanDto);
		} catch (Exception e) {
			throw new BusinessException("상세 계획 조회 에러  : " + e.getMessage());
		}
		if (planDetailList == null) {
			planDetailList = new ArrayList<ProductPlanDto>();
		}
		return new PageInfo<ProductPlanDto>(planDetailList, pageRequestVo, rowCount);
	}
	
	
	public String setProductPlan(ProductPlanDto productPlanDto){
		String returnKey = "";
		try {
			productPlanDto.setCreatorId(JteUtils.getUserId());
			productPlanDto.setUpdatorId(JteUtils.getUserId());
			
			if(productPlanDto.getAction().equals("C")) { 
				kwangjinProductPlanMapper.insertProductPlan(productPlanDto);
				returnKey = productPlanDto.getProdPlanId();
			}else if(productPlanDto.getAction().equals("U")){ 
				kwangjinProductPlanMapper.updateProductPlan(productPlanDto);
				returnKey = productPlanDto.getProdPlanId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("계획 입력 에러  : " + e.getMessage());
		}
		
		return returnKey;
	}
}
