package jin.mes.cform.mfgMgt.mfgplanMgt.productPlan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.ZinixMfgplanDto;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.ZinixProductPlanDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/mfgplanMgt/productPlan")
public class ZinixProductPlanController extends BaseController {
	
	@Autowired
	ZinixProductPlanService productPlanService;
	
	@RequestMapping("getMonthPlanList")
	public ModelMap getMonthPlanList(ModelMap model, @ModelAttribute("planDto") ZinixMfgplanDto planDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(planDto.getPage())));
		pageRequestVo.setRows(planDto.getRows());
		
		try {
			setModelWithkendoList(model, productPlanService.getProductPlanList(planDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("연간 계획 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getProductPlanDetail")
	public ModelMap getProductPlanDetail(ModelMap model, @RequestBody ZinixProductPlanDto productPlanDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(productPlanDto.getPage())));
		pageRequestVo.setRows(productPlanDto.getRows());
		
		try {
			setModelWithkendoList(model, productPlanService.getProductPlanDetail(productPlanDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("계획 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//생산계획 등록
	@RequestMapping("setProductPlan")
	@ResponseBody
	public String setProductPlan(ModelMap model, @RequestBody ZinixProductPlanDto productPlanDto) {		
		return productPlanService.setProductPlan(productPlanDto);
	}
}