package jin.mes.cform.prcesMgt.gantChtMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/cform/prcesMgt/gantChtMgt")
public class NewGantChtMgtController extends BaseController {
	
	@Autowired
	NewGantChtMgtService newGantChtMgtService;
	
	@RequestMapping("/getGanttChart")
	@ResponseBody
	public ModelMap getRtlDefectList(@RequestBody NewGantChtMgtDto newGantChtMgtDto, ModelMap model) {
		model.addAttribute("rows", newGantChtMgtService.getGanttChart(newGantChtMgtDto));

		return model;
	}
	
}
