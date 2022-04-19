package jin.mes.form.facilMgt.prevMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/facilMgt/prevMgt")
public class PrevMgtController extends BaseController {
	@Autowired
	PrevMgtService prevMgtService;
	
	@RequestMapping("/selectPdmData")
	public ModelMap selectPdmData(ModelMap model, @ModelAttribute("prevMgtDto") PrevMgtDto prevMgtDto) {
		try {
			model.addAttribute("rows", prevMgtService.selectPdmData(prevMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectPdmData 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
}
