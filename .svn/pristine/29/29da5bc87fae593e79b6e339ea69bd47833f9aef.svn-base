package jin.mes.cform.mfgMgt.analsMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/analsMgt")
public class NewAnalsMgtController extends BaseController {
	@Autowired
	NewAnalsMgtService newAnalsMgtService;
	
	@RequestMapping("/selectRoutingSheet")
	public ModelMap selectRoutingSheet(ModelMap model, @ModelAttribute("newAnalsMgtDto") NewAnalsMgtDto newAnalsMgtDto) {
		try {
			model.addAttribute("rows", newAnalsMgtService.selectRoutingSheet(newAnalsMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectRoutingSheet 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
}
