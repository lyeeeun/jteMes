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

import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

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
	
	@RequestMapping("/getLotStockList")
	public ModelMap getLotStockList(@ModelAttribute("shipPlanMgtDto") ShipPlanMgtDto shipPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(shipPlanMgtDto.getPage())));
		pageRequestVo.setRows(shipPlanMgtDto.getRows());

		setModelWithkendoList(model, shipPlanMgtService.getLotStockList(shipPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/setShipPlanSave")
	@ResponseBody
	public String setShipPlanSave(@RequestBody ShipPlanMgtDto shipPlanMgtDto) {
		return shipPlanMgtService.setShipPlanSave(shipPlanMgtDto);
	}


	@RequestMapping("/setShipPlanDelete")
	@ResponseBody
	public String setShipPlanDelete(ModelMap model, @RequestBody List<ShipPlanMgtDto> shipPlanList) {
		return shipPlanMgtService.setShipPlanDelete(shipPlanList);
	}

	
}
