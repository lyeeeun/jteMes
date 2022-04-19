package jin.mes.form.mtrl.mtrlOdMgt.mtrlOdcursitMgt;

import java.util.List;

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
@RequestMapping("/form/mtrl/mtrlOdMgt/mtrlOdcursitMgt")
public class MtrlOdcursitMgtController extends BaseController {

	@Autowired
	MtrlOdcursitMgtService mtrlOrderFormService;
	
	@RequestMapping("getMtrlOrderFormList")
	public ModelMap getMtrlOrderFormList(ModelMap model, @ModelAttribute("mtrlOrderFormDto") MtrlOdcursitMgtDto mtrlOrderFormDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlOrderFormDto.getPage())));
		pageRequestVo.setRows(mtrlOrderFormDto.getRows());
		try {
			setModelWithkendoList(model, mtrlOrderFormService.getMtrlOrderFormList(mtrlOrderFormDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlOrderFormSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody MtrlOdcursitMgtDto mtrlOrderFormDto) {
		return mtrlOrderFormService.setMtrlOrderFormSave(mtrlOrderFormDto);
	}
	
	@RequestMapping("/setMtrlOrderFormDelete")
	@ResponseBody
	public int setEqmtMgtDelete(ModelMap model, @RequestBody List<MtrlOdcursitMgtDto> mtrlOrderList) {
		return mtrlOrderFormService.setMtrlOrderFormDelete(mtrlOrderList);
	}
}
