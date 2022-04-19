package jin.mes.form.perform.performOrderChart;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/perform/performOrderChart")
public class PerformOrderChartController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(PerformOrderChartController.class);

	@Resource
	protected PerformOrderChartService performOrderChartService;

	@RequestMapping("/getPerformOrderChart")
	public ModelMap getPerformOrderChart(@ModelAttribute("performOrderChartDto") PerformOrderChartDto performOrderChartDto, ModelMap model) {
		model.addAttribute("rows", performOrderChartService.getPerformOrderChart(performOrderChartDto));

		return model;
	}
	
	@RequestMapping("/getPerformTotalOrderChart")
	public ModelMap getPerformTotalOrderChart(@ModelAttribute("performOrderChartDto") PerformOrderChartDto performOrderChartDto, ModelMap model) {
		model.addAttribute("rows", performOrderChartService.getPerformTotalOrderChart(performOrderChartDto));

		return model;
	}
	
}
