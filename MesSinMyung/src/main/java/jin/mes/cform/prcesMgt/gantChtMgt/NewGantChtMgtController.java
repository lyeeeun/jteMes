package jin.mes.cform.prcesMgt.gantChtMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/cform/prcesMgt/gantChtMgt")
public class NewGantChtMgtController extends BaseController {
	
	@Autowired
	NewGantChtMgtService newGantChtMgtService;
	
	@RequestMapping("/getGanttChart")
	public ModelMap getRtlDefectList(@ModelAttribute("gantChtMgtDto") NewGantChtMgtDto gantChtMgtDto, ModelMap model) {
		model.addAttribute("rows", newGantChtMgtService.getGanttChart(gantChtMgtDto));

		return model;
	}
}
