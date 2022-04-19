package jin.mes.form.basMgt.routing.routingMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.processInfo.ProcessInfoDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/basMgt/routing/routingMgt")
public class RoutingMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(RoutingMgtController.class);

	@Resource
	protected RoutingMgtService routingMgtService;
	
	@RequestMapping("/getRoutingInfo")
	public ModelMap getRoutingInfo(@ModelAttribute("routingMgtDto") RoutingMgtDto routingMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", routingMgtService.getRoutingInfo(routingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setRoutingInfo")
	@ResponseBody
	public void setRoutingInfo(@RequestBody RoutingMgtDto routingMgtDto) {
		routingMgtService.setRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/updateRoutingInfo")
	@ResponseBody
	public void updateRoutingInfo(@RequestBody RoutingMgtDto routingMgtDto) {
		routingMgtService.updateRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/deleteRoutingInfo")
	@ResponseBody
	public void deleteRoutingInfo(@RequestBody RoutingMgtDto routingMgtDto) {
		routingMgtService.deleteRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/settingDefaultTool")
	@ResponseBody
	public void settingDefaultTool(@RequestBody RoutingMgtDto routingMgtDto) {
		routingMgtService.settingDefaultTool(routingMgtDto); 
	}
	
	@RequestMapping("/getRtlBomList")
	@ResponseBody
	public ModelMap getRtlBomList(@RequestBody RoutingMgtDto routingMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", routingMgtService.getRtlBomList(routingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getRtlEqmtList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("routingMgtDto") RoutingMgtDto routingMgtDto, ModelMap model) {
		model.addAttribute("rows", routingMgtService.getRtlEqmtList(routingMgtDto));

		return model;
	}
	
	@RequestMapping("/getRtlToolList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("routingRtlToolDto") RoutingRtlToolDto routingRtlToolDto, ModelMap model) {
		model.addAttribute("rows", routingMgtService.getRtlToolList(routingRtlToolDto));
		return model;
	}
	
}
