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

import jin.mes.cform.ship.shipPlanMgt.KwangjinShipPlanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/ship/shipPlanMgt")
public class KwangjinShipPlanMgtController extends BaseController {
	

	private static final Logger logger = LoggerFactory.getLogger(KwangjinShipPlanMgtController.class);

	@Resource
	protected KwangjinShipPlanMgtService kwangjinShipPlanMgtService;

	@RequestMapping("/getShipPlanList")
	public ModelMap getShipPlanList(@ModelAttribute("kwangjinShipPlanMgtDto") KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinShipPlanMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinShipPlanMgtDto.getRows());

		setModelWithkendoList(model, kwangjinShipPlanMgtService.getShipPlanList(kwangjinShipPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getLotStockList")
	public ModelMap getLotStockList(@ModelAttribute("kwangjinShipPlanMgtDto") KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinShipPlanMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinShipPlanMgtDto.getRows());

		setModelWithkendoList(model, kwangjinShipPlanMgtService.getLotStockList(kwangjinShipPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/setShipPlanSave")
	@ResponseBody
	public String setShipPlanSave(@RequestBody KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto) {
		return kwangjinShipPlanMgtService.setShipPlanSave(kwangjinShipPlanMgtDto);
	}


	@RequestMapping("/setShipPlanDelete")
	@ResponseBody
	public String setShipPlanDelete(ModelMap model, @RequestBody List<KwangjinShipPlanMgtDto> shipPlanList) {
		return kwangjinShipPlanMgtService.setShipPlanDelete(shipPlanList);
	}

	
}
