package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.ZinixMtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/qualPec/inputQualMgt")
public class ZinixInputQualMgtController extends BaseController {

	@Autowired
	ZinixInputQualMgtService zinixInputQualMgtService;
	
	@RequestMapping("getMtrlOrderInputList")
	public ModelMap getMtrlOrderInputList(ModelMap model, @ModelAttribute("zinixInputQualMgtDto") ZinixInputQualMgtDto zinixInputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixInputQualMgtDto.getPage())));
		pageRequestVo.setRows(zinixInputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixInputQualMgtService.getMtrlOrderInputList(zinixInputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMtrlOrderPlanInputList")
	public ModelMap getMtrlOrderList(ModelMap model, @ModelAttribute("zinixInputQualMgtDto") ZinixInputQualMgtDto zinixInputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixInputQualMgtDto.getPage())));
		pageRequestVo.setRows(zinixInputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixInputQualMgtService.getMtrlOrderPlanInputList(zinixInputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlOrderPlanInputSave")
	@ResponseBody
	public String setMtrlOrderPlanInputSave(@RequestBody ZinixInputQualMgtDto zinixInputQualMgtDto) {
		return zinixInputQualMgtService.setMtrlOrderPlanInputSave(zinixInputQualMgtDto);
	}
}
