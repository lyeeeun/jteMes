package jin.mes.cform.ship.shipMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtController;
import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/cform/ship/shipMgt")
public class NewShipMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NewShipMgtController.class);

	@Resource
	protected NewShipMgtService newShipMgtService; 
	
	
	@RequestMapping("/shipAction")
	@ResponseBody
	public void shipAction(@RequestBody NewShipMgtDto shipMgtDto) {
		newShipMgtService.shipAction(shipMgtDto);
	}
	
	@RequestMapping("/getPackageStock")
	@ResponseBody
	public int getPackageStock(@RequestBody NewShipMgtDto shipMgtDto) {
		return newShipMgtService.getPackageStock(shipMgtDto);
	}
	
}
