package jin.mes.cform.ship.shipPlanMgt;

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

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/ship/shipPlanMgt")
public class NewShipPlanMgtController extends BaseController {
	

	private static final Logger logger = LoggerFactory.getLogger(NewShipPlanMgtController.class);

	@Resource
	protected NewShipPlanMgtService newShipPlanMgtService;

	@RequestMapping("/getShipPlanList")
	public ModelMap getShipPlanList(@ModelAttribute("shipPlanMgtDto") NewShipPlanMgtDto shipPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(shipPlanMgtDto.getPage())));
		pageRequestVo.setRows(shipPlanMgtDto.getRows());

		setModelWithkendoList(model, newShipPlanMgtService.getShipPlanList(shipPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getShipCompList")
	public ModelMap getShipCompList(@ModelAttribute("shipPlanMgtDto") NewShipPlanMgtDto shipPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(shipPlanMgtDto.getPage())));
		pageRequestVo.setRows(shipPlanMgtDto.getRows());

		setModelWithkendoList(model, newShipPlanMgtService.getShipCompList(shipPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getShipCompleteQty")
	@ResponseBody
	public int getShipCompleteQty(@RequestBody NewShipPlanMgtDto shipPlanMgtDto) {
		return newShipPlanMgtService.getShipCompleteQty(shipPlanMgtDto);
	}
	
	@RequestMapping("/setShipPlan")
	@ResponseBody
	public String setShipPlan(@RequestBody NewShipPlanMgtDto shipPlanMgtDto) {
		return newShipPlanMgtService.setShipPlan(shipPlanMgtDto);
	}
	
	@RequestMapping("/updateShipPlan")
	@ResponseBody
	public String updateShipPlan(@RequestBody NewShipPlanMgtDto shipPlanMgtDto) {
		return newShipPlanMgtService.updateShipPlan(shipPlanMgtDto);
	}
	
	@RequestMapping("/deleteShipPlan")
	@ResponseBody
	public int deleteShipPlan(@RequestBody List<NewShipPlanMgtDto> shipPlanList) {
		return newShipPlanMgtService.deleteShipPlan(shipPlanList);
	}
	
//	@RequestMapping("/getRtlBundleList")
//	public ModelMap getPerformTotalOrderChart(@ModelAttribute("shipPlanMgtDto") ShipPlanMgtDto shipPlanMgtDto, ModelMap model) {
//		model.addAttribute("rows", newShipPlanMgtService.getRtlBundleList(shipPlanMgtDto));
//
//		return model;
//	}
	
	
}
