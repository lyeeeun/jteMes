package jin.mes.cform.ship.shipPlanMgt;

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
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/ship/shipPlanMgt")
public class ZinixShipPlanMgtController extends BaseController {
	

	private static final Logger logger = LoggerFactory.getLogger(ZinixShipPlanMgtController.class);

	@Resource
	protected ZinixShipPlanMgtService zinixShipPlanMgtService;

	@RequestMapping("getMonthPlanList")
	public ModelMap getMonthPlanList(ModelMap model, @ModelAttribute("planDto") ZinixShipPlanMgtDto planDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(planDto.getPage())));
		pageRequestVo.setRows(planDto.getRows());
		
		try {
			setModelWithkendoList(model, zinixShipPlanMgtService.getShipPlanList(planDto, pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("연간 계획 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getShipPlanDetail")
	public ModelMap getShipPlanDetail(ModelMap model, @RequestBody ZinixShipPlanMgtDto planDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(planDto.getPage())));
		pageRequestVo.setRows(planDto.getRows());
		
		try {
			setModelWithkendoList(model, zinixShipPlanMgtService.getShipPlanDetail(planDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("계획 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//생산계획 등록
	@RequestMapping("setShipPlan")
	@ResponseBody
	public String setShipPlan(ModelMap model, @RequestBody ZinixShipPlanMgtDto planDto) {		
		return zinixShipPlanMgtService.setShipPlan(planDto);
	}
	
	@RequestMapping("/getShipCompList")
	public ModelMap getShipCompList(@ModelAttribute("planDto") ZinixShipPlanMgtDto planDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(planDto.getPage())));
		pageRequestVo.setRows(planDto.getRows());

		setModelWithkendoList(model, zinixShipPlanMgtService.getShipCompList(planDto, pageRequestVo));

		return model;
	}
}
