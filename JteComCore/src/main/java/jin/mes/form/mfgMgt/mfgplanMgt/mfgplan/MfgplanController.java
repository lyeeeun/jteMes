package jin.mes.form.mfgMgt.mfgplanMgt.mfgplan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.orderMgt.claimMgt.ClaimMgtService;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mfgMgt/mfgplanMgt/mfgplan")
public class MfgplanController extends BaseController {
	
	@Autowired
	MfgplanService mfgplanService;
	
	@RequestMapping("getMonthPlanList")
	public ModelMap getMonthPlanList(ModelMap model, @ModelAttribute("planDto") MfgplanDto planDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(planDto.getPage())));
		pageRequestVo.setRows(planDto.getRows());
		
		try {
			setModelWithkendoList(model, mfgplanService.getMonthPlanList(planDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("연간 계획 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getDayPlanList")
	public ModelMap getDayPlanList(ModelMap model, @ModelAttribute("planDto") MfgplanDto planDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(planDto.getPage())));
		pageRequestVo.setRows(planDto.getRows());
		
		try {
			setModelWithkendoList(model, mfgplanService.getDayPlanList(planDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("일간 계획 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getPlanDetail")
	public ModelMap getPlanDetail(ModelMap model, @RequestBody ProductPlanDto productPlanDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(productPlanDto.getPage())));
		pageRequestVo.setRows(productPlanDto.getRows());
		
		try {
			setModelWithkendoList(model, mfgplanService.getPlanDetail(productPlanDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("계획 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//생산계획 등록
	@RequestMapping("setPlanCnt")
	@ResponseBody
	public String setPlanCnt(ModelMap model, @RequestBody ProductPlanDto productPlanDto) {		
		return mfgplanService.setPlanCnt(productPlanDto);
	}
	
	//일괄처리 가능여부 조회
	@RequestMapping("getBulkPos")
	public ModelMap getBulkPos(ModelMap model, @RequestBody ProductPlanDto productPlanDto) {
		try {
			model.addAttribute("rows", mfgplanService.getBulkPos(productPlanDto));
		}catch(Exception ex) {
			throw new BusinessException("일괄처리 가능여부 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	//일괄처리 가능여부 조회
	@RequestMapping("setBulkSave")
	public ModelMap setBulkSave(ModelMap model, @RequestBody ProductPlanDto productPlanDto) {
		try {
			model.addAttribute("result", mfgplanService.setBulkSave(productPlanDto));
		}catch(Exception ex) {
			throw new BusinessException("일괄처리 저장 에러  : " + ex.getMessage());
		}
		return model;
	}
		
		
	//일괄처리 가능여부 조회
	@RequestMapping("setBulkDelete")
	public ModelMap setBulkDelete(ModelMap model, @RequestBody ProductPlanDto productPlanDto) {
		try {
			model.addAttribute("result", mfgplanService.setBulkDelete(productPlanDto));
		}catch(Exception ex) {
			throw new BusinessException("일괄처리 삭제 에러  : " + ex.getMessage());
		}
		return model;
	}
}