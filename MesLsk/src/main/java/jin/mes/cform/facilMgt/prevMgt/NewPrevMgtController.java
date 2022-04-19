package jin.mes.cform.facilMgt.prevMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/facilMgt/prevMgt")
public class NewPrevMgtController extends BaseController {
	@Autowired
	NewPrevMgtService newPrevMgtService;
	
	@RequestMapping("/selectPdmData")
	public ModelMap selectPdmData(ModelMap model, @ModelAttribute("newPrevMgtDto") NewPrevMgtDto newPrevMgtDto) {
		try {
			model.addAttribute("rows", newPrevMgtService.selectPdmData(newPrevMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectPdmData 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
}
