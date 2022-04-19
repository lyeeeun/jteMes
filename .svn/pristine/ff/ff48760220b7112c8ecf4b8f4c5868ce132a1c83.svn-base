package jin.mes.cform.perform.performOrderChart;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/cform/perform/performOrderChart")
public class NewPerformOrderChartController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewPerformOrderChartController.class);

	@Resource
	protected NewPerformOrderChartService newPerformOrderChartService;

	@RequestMapping("/getPerformOrderChart")
	public ModelMap getPerformOrderChart(@ModelAttribute("newPerformOrderChartDto") NewPerformOrderChartDto newPerformOrderChartDto, ModelMap model) {
		model.addAttribute("rows", newPerformOrderChartService.getPerformOrderChart(newPerformOrderChartDto));

		return model;
	}
	
	@RequestMapping("/getPerformTotalOrderChart")
	public ModelMap getPerformTotalOrderChart(@ModelAttribute("newPerformOrderChartDto") NewPerformOrderChartDto newPerformOrderChartDto, ModelMap model) {
		model.addAttribute("rows", newPerformOrderChartService.getPerformTotalOrderChart(newPerformOrderChartDto));

		return model;
	}
	
}
