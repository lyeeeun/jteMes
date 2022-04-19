package jin.mes.form.ship.shipMgt;

import java.util.List;

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
@RequestMapping("/form/ship/shipMgt")
public class ShipMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ShipPlanMgtController.class);

	@Resource
	protected ShipMgtService shipMgtService; 
	
	
	@RequestMapping("/shipAction")
	@ResponseBody
	public void shipAction(@RequestBody ShipMgtDto shipMgtDto) {
		shipMgtService.shipAction(shipMgtDto);
	}
	
	@RequestMapping("/getPackageStock")
	@ResponseBody
	public int getPackageStock(@RequestBody ShipMgtDto shipMgtDto) {
		return shipMgtService.getPackageStock(shipMgtDto);
	}
	
}
