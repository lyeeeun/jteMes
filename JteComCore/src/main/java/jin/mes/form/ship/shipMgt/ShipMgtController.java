package jin.mes.form.ship.shipMgt;

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

import jin.mes.form.ship.pickMgt.PickMgtDto;
import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtController;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/ship/shipMgt")
public class ShipMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ShipPlanMgtController.class);

	@Resource
	protected ShipMgtService shipMgtService; 
	
	@RequestMapping("/getShipPlanList")
	public ModelMap selectShipPlanList(@ModelAttribute("shipMgtDto") ShipMgtDto shipMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(shipMgtDto.getPage())));
		pageRequestVo.setRows(shipMgtDto.getRows());

		setModelWithkendoList(model, shipMgtService.getShipPlanList(shipMgtDto, pageRequestVo));

		return model;
	}

	
	@RequestMapping("/setShipSave")
	@ResponseBody
	public String setShipSave(@RequestBody ShipMgtDto shipMgtDto) {
		return shipMgtService.setShipSave(shipMgtDto);
	}
}
