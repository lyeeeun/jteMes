package jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/mfgplanMgt/mfgplan")
public class NewMfgplanController extends BaseController {
	
	@Autowired
	NewMfgplanService newMfgplanService;
	
	@RequestMapping("getMonthPlanList")
	public ModelMap getMonthPlanList(ModelMap model, @ModelAttribute("newPlanDto") NewMfgplanDto newPlanDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newPlanDto.getPage())));
		pageRequestVo.setRows(newPlanDto.getRows());
		
		try {
			setModelWithkendoList(model, newMfgplanService.getMonthPlanList(newPlanDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("연간 계획 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getDayPlanList")
	public ModelMap getDayPlanList(ModelMap model, @ModelAttribute("newPlanDto") NewMfgplanDto newPlanDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newPlanDto.getPage())));
		pageRequestVo.setRows(newPlanDto.getRows());
		
		try {
			setModelWithkendoList(model, newMfgplanService.getDayPlanList(newPlanDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("일간 계획 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getPlanDetail")
	public ModelMap getPlanDetail(ModelMap model, @RequestBody NewProductPlanDto newProductPlanDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newProductPlanDto.getPage())));
		pageRequestVo.setRows(newProductPlanDto.getRows());
		
		try {
			setModelWithkendoList(model, newMfgplanService.getPlanDetail(newProductPlanDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("계획 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//생산계획 등록
	@RequestMapping("setPlanCnt")
	@ResponseBody
	public String setPlanCnt(ModelMap model, @RequestBody NewProductPlanDto newProductPlanDto) {		
		return newMfgplanService.setPlanCnt(newProductPlanDto);
	}
	
	//일괄처리 가능여부 조회
	@RequestMapping("getBulkPos")
	public ModelMap getBulkPos(ModelMap model, @RequestBody NewProductPlanDto newProductPlanDto) {
		try {
			model.addAttribute("rows", newMfgplanService.getBulkPos(newProductPlanDto));
		}catch(Exception ex) {
			throw new BusinessException("일괄처리 가능여부 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	//일괄처리 가능여부 조회
	@RequestMapping("setBulkSave")
	public ModelMap setBulkSave(ModelMap model, @RequestBody NewProductPlanDto newProductPlanDto) {
		try {
			model.addAttribute("result", newMfgplanService.setBulkSave(newProductPlanDto));
		}catch(Exception ex) {
			throw new BusinessException("일괄처리 저장 에러  : " + ex.getMessage());
		}
		return model;
	}
		
		
	//일괄처리 가능여부 조회
	@RequestMapping("setBulkDelete")
	public ModelMap setBulkDelete(ModelMap model, @RequestBody NewProductPlanDto newProductPlanDto) {
		try {
			model.addAttribute("result", newMfgplanService.setBulkDelete(newProductPlanDto));
		}catch(Exception ex) {
			throw new BusinessException("일괄처리 삭제 에러  : " + ex.getMessage());
		}
		return model;
	}
}