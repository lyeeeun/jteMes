package jin.mes.cform.ship.orderCompleteMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.ship.shipMgt.NewShipMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/ship/orderCompleteMgt")
public class NewOrderCompleteMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NewOrderCompleteMgtController.class);

	@Resource
	protected NewOrderCompleteMgtService newOrderCompleteMgtService; 
	
	@RequestMapping("/selectOrderList")
	public ModelMap selectOrderList(@ModelAttribute("orderCompleteMgtDto") NewOrderCompleteMgtDto orderCompleteMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderCompleteMgtDto.getPage())));
		pageRequestVo.setRows(orderCompleteMgtDto.getRows());

		setModelWithkendoList(model, newOrderCompleteMgtService.selectOrderList(orderCompleteMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/lotStateUpdate")
	@ResponseBody
	public void lotStateUpdate(@RequestBody NewShipMgtDto shipMgtDto) {
		newOrderCompleteMgtService.lotStateUpdate(shipMgtDto);
	}
	
	@RequestMapping("/orderStateUpdate")
	@ResponseBody
	public void orderStateUpdate(@RequestBody NewShipMgtDto shipMgtDto) {
		newOrderCompleteMgtService.orderStateUpdate(shipMgtDto);
	}
	
	@RequestMapping("/selectProcShiftTable")
	public ModelMap selectProcShiftTable(@ModelAttribute("orderCompleteMgtDto") NewOrderCompleteMgtDto orderCompleteMgtDto, ModelMap model) {
		model.addAttribute("rows", newOrderCompleteMgtService.selectProcShiftTable(orderCompleteMgtDto));

		return model;
	}
	
	@RequestMapping("/selectReturnSurplusMtrl")
	public ModelMap selectReturnSurplusMtrl(@ModelAttribute("orderCompleteMgtDto") NewOrderCompleteMgtDto orderCompleteMgtDto, ModelMap model) {
		model.addAttribute("rows", newOrderCompleteMgtService.selectReturnSurplusMtrl(orderCompleteMgtDto));

		return model;
	}
}
