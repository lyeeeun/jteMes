package jin.mes.form.prcesMgt.gantChtMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/form/prcesMgt/gantChtMgt")
public class GantChtMgtController extends BaseController {
	
	@Autowired
	GantChtMgtService gantChtMgtService;
	
	@RequestMapping("/getGanttChart")
	@ResponseBody
	public ModelMap getRtlDefectList(@RequestBody GantChtMgtDto gantChtMgtDto, ModelMap model) {
		model.addAttribute("rows", gantChtMgtService.getGanttChart(gantChtMgtDto));

		return model;
	}
	
}
