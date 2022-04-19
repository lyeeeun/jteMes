package jin.mes.cform.mfgMgt.mfgplanMgt.productPlan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.NewMfgplanDto;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.NewProductPlanDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/mfgplanMgt/productPlan")
public class NewProductPlanController extends BaseController {
	
	@Autowired
	NewProductPlanService newProductPlanService;
	
	@RequestMapping("getMonthPlanList")
	public ModelMap getMonthPlanList(ModelMap model, @ModelAttribute("newPlanDto") NewMfgplanDto newPlanDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newPlanDto.getPage())));
		pageRequestVo.setRows(newPlanDto.getRows());
		
		try {
			setModelWithkendoList(model, newProductPlanService.getProductPlanList(newPlanDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("연간 계획 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getProductPlanDetail")
	public ModelMap getProductPlanDetail(ModelMap model, @RequestBody NewProductPlanDto newProductPlanDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newProductPlanDto.getPage())));
		pageRequestVo.setRows(newProductPlanDto.getRows());
		
		try {
			setModelWithkendoList(model, newProductPlanService.getProductPlanDetail(newProductPlanDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("계획 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//생산계획 등록
	@RequestMapping("setProductPlan")
	@ResponseBody
	public String setProductPlan(ModelMap model, @RequestBody NewProductPlanDto newProductPlanDto) {		
		return newProductPlanService.setProductPlan(newProductPlanDto);
	}
}