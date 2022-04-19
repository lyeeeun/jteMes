package jin.mes.form.mfgMgt.analsMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mfgMgt/analsMgt")
public class AnalsMgtController extends BaseController {
	@Autowired
	AnalsMgtService analsMgtService;
	
	@RequestMapping("/selectRoutingSheet")
	public ModelMap selectRoutingSheet(ModelMap model, @ModelAttribute("analsMgtDto") AnalsMgtDto analsMgtDto) {
		try {
			model.addAttribute("rows", analsMgtService.selectRoutingSheet(analsMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectRoutingSheet 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
}
