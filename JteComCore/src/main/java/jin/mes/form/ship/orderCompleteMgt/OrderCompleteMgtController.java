package jin.mes.form.ship.orderCompleteMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.ship.shipMgt.ShipMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/ship/orderCompleteMgt")
public class OrderCompleteMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(OrderCompleteMgtController.class);

	@Resource
	protected OrderCompleteMgtService orderCompleteMgtService; 
	
	@RequestMapping("/selectOrderList")
	public ModelMap selectOrderList(@ModelAttribute("orderCompleteMgtDto") OrderCompleteMgtDto orderCompleteMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderCompleteMgtDto.getPage())));
		pageRequestVo.setRows(orderCompleteMgtDto.getRows());

		setModelWithkendoList(model, orderCompleteMgtService.selectOrderList(orderCompleteMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/lotStateUpdate")
	@ResponseBody
	public void lotStateUpdate(@RequestBody ShipMgtDto shipMgtDto) {
		orderCompleteMgtService.lotStateUpdate(shipMgtDto);
	}
	
	@RequestMapping("/orderStateUpdate")
	@ResponseBody
	public void orderStateUpdate(@RequestBody ShipMgtDto shipMgtDto) {
		orderCompleteMgtService.orderStateUpdate(shipMgtDto);
	}
	
	@RequestMapping("/selectProcShiftTable")
	public ModelMap selectProcShiftTable(@ModelAttribute("orderCompleteMgtDto") OrderCompleteMgtDto orderCompleteMgtDto, ModelMap model) {
		model.addAttribute("rows", orderCompleteMgtService.selectProcShiftTable(orderCompleteMgtDto));

		return model;
	}
	
	@RequestMapping("/selectReturnSurplusMtrl")
	public ModelMap selectReturnSurplusMtrl(@ModelAttribute("orderCompleteMgtDto") OrderCompleteMgtDto orderCompleteMgtDto, ModelMap model) {
		model.addAttribute("rows", orderCompleteMgtService.selectReturnSurplusMtrl(orderCompleteMgtDto));

		return model;
	}
}
