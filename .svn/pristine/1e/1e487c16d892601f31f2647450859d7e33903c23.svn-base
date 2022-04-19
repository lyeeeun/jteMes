package jin.mes.form.ship.shipPlanMgt;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.perform.performOrderChart.PerformOrderChartDto;
import jin.mes.form.ship.rlesMgt.RlesMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/ship/shipPlanMgt")
public class ShipPlanMgtController extends BaseController {
	

	private static final Logger logger = LoggerFactory.getLogger(ShipPlanMgtController.class);

	@Resource
	protected ShipPlanMgtService shipPlanMgtService;

	@RequestMapping("/getShipPlanList")
	public ModelMap getShipPlanList(@ModelAttribute("shipPlanMgtDto") ShipPlanMgtDto shipPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(shipPlanMgtDto.getPage())));
		pageRequestVo.setRows(shipPlanMgtDto.getRows());

		setModelWithkendoList(model, shipPlanMgtService.getShipPlanList(shipPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getShipCompList")
	public ModelMap getShipCompList(@ModelAttribute("shipPlanMgtDto") ShipPlanMgtDto shipPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(shipPlanMgtDto.getPage())));
		pageRequestVo.setRows(shipPlanMgtDto.getRows());

		setModelWithkendoList(model, shipPlanMgtService.getShipCompList(shipPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getShipCompleteQty")
	@ResponseBody
	public int getShipCompleteQty(@RequestBody ShipPlanMgtDto shipPlanMgtDto) {
		return shipPlanMgtService.getShipCompleteQty(shipPlanMgtDto);
	}
	
	@RequestMapping("/setShipPlan")
	@ResponseBody
	public String setShipPlan(@RequestBody ShipPlanMgtDto shipPlanMgtDto) {
		return shipPlanMgtService.setShipPlan(shipPlanMgtDto);
	}
	
	@RequestMapping("/updateShipPlan")
	@ResponseBody
	public String updateShipPlan(@RequestBody ShipPlanMgtDto shipPlanMgtDto) {
		return shipPlanMgtService.updateShipPlan(shipPlanMgtDto);
	}
	
	@RequestMapping("/deleteShipPlan")
	@ResponseBody
	public int deleteShipPlan(@RequestBody List<ShipPlanMgtDto> shipPlanList) {
		return shipPlanMgtService.deleteShipPlan(shipPlanList);
	}
	
//	@RequestMapping("/getRtlBundleList")
//	public ModelMap getPerformTotalOrderChart(@ModelAttribute("shipPlanMgtDto") ShipPlanMgtDto shipPlanMgtDto, ModelMap model) {
//		model.addAttribute("rows", shipPlanMgtService.getRtlBundleList(shipPlanMgtDto));
//
//		return model;
//	}
	
	
}
