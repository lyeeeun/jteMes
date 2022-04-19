package jin.mes.form.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/qualMgt/qualPec/inputQualMgt")
public class InputQualMgtController extends BaseController {

	@Autowired
	InputQualMgtService inputQualMgtService;
	
	@RequestMapping("getMtrlOrderInputList")
	public ModelMap getMtrlOrderInputList(ModelMap model, @ModelAttribute("inputQualMgtDto") InputQualMgtDto inputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(inputQualMgtDto.getPage())));
		pageRequestVo.setRows(inputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, inputQualMgtService.getMtrlOrderInputList(inputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMtrlOrderPlanInputList")
	public ModelMap getMtrlOrderList(ModelMap model, @ModelAttribute("inputQualMgtDto") InputQualMgtDto inputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(inputQualMgtDto.getPage())));
		pageRequestVo.setRows(inputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, inputQualMgtService.getMtrlOrderPlanInputList(inputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlOrderPlanInputSave")
	@ResponseBody
	public String setMtrlOrderPlanInputSave(@RequestBody InputQualMgtDto inputQualMgtDto) {
		return inputQualMgtService.setMtrlOrderPlanInputSave(inputQualMgtDto);
	}
}
