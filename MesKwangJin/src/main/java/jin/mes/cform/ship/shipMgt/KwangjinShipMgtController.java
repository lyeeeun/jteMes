package jin.mes.cform.ship.shipMgt;

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

import jin.mes.cform.ship.shipPlanMgt.KwangjinShipPlanMgtController;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/ship/shipMgt")
public class KwangjinShipMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(KwangjinShipPlanMgtController.class);

	@Resource
	protected KwangjinShipMgtService kwangjinShipMgtService; 
	
	@RequestMapping("/getShipPlanList")
	public ModelMap selectShipPlanList(@ModelAttribute("kwangjinShipMgtDto") KwangjinShipMgtDto kwangjinShipMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinShipMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinShipMgtDto.getRows());

		setModelWithkendoList(model, kwangjinShipMgtService.getShipPlanList(kwangjinShipMgtDto, pageRequestVo));

		return model;
	}

	
	@RequestMapping("/setShipSave")
	@ResponseBody
	public String setShipSave(@RequestBody KwangjinShipMgtDto kwangjinShipMgtDto) {
		return kwangjinShipMgtService.setShipSave(kwangjinShipMgtDto);
	}
	
	/*
	 * @RequestMapping("/setOrderStdSave")
	 * 
	 * @ResponseBody public String setOrderStdSave(@RequestBody KwangjinShipMgtDto
	 * kwangjinShipMgtDto) { return
	 * kwangjinShipMgtService.setOrderStdSave(kwangjinShipMgtDto); }
	 */
}
