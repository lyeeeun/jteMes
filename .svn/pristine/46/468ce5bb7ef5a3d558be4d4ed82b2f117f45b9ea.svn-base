package jin.mes.form.qualMgt.qualPec.finalQualMgt;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.qualMgt.qualPec.inputQualMgt.InputQualMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/qualMgt/qualPec/finalQualMgt")
public class FinalQualMgtController extends BaseController {

	@Autowired
	FinalQualMgtService finalQualMgtService;
	
	//입고검사 조회
	@RequestMapping("getFinalQualList")
	public ModelMap getFinalQualList(ModelMap model, @ModelAttribute("finalQualMgtDto") FinalQualMgtDto finalQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(finalQualMgtDto.getPage())));
		pageRequestVo.setRows(finalQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, finalQualMgtService.getFinalQualList(finalQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
