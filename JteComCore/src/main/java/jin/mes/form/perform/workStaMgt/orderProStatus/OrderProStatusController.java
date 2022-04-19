package jin.mes.form.perform.workStaMgt.orderProStatus;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/form/perform/workStaMgt/orderProStatus")
public class OrderProStatusController extends BaseController {
	
	@Resource
	protected OrderProStatusService orderProStatusService;

	@RequestMapping("/getOrderChart")
	public ModelMap getOrderChart(@ModelAttribute("orderProStatusDto") OrderProStatusDto orderProStatusDto, ModelMap model) {
		model.addAttribute("rows", orderProStatusService.getOrderChart(orderProStatusDto));

		return model;
	}
	
	@RequestMapping("/getTotalOrderChart")
	public ModelMap getTotalOrderChart(@ModelAttribute("orderProStatusDto") OrderProStatusDto orderProStatusDto, ModelMap model) {
		model.addAttribute("rows", orderProStatusService.getTotalOrderChart(orderProStatusDto));

		return model;
	}
}
