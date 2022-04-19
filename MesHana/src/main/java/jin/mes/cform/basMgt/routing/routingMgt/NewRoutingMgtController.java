package jin.mes.cform.basMgt.routing.routingMgt;

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
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/routing/routingMgt")
public class NewRoutingMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NewRoutingMgtController.class);

	@Resource
	protected NewRoutingMgtService newRoutingMgtService;
	
	@RequestMapping("/getRoutingInfo")
	public ModelMap getRoutingInfo(@ModelAttribute("newRoutingMgtDto") NewRoutingMgtDto newRoutingMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", newRoutingMgtService.getRoutingInfo(newRoutingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setRoutingInfo")
	@ResponseBody
	public void setRoutingInfo(@RequestBody NewRoutingMgtDto newRoutingMgtDto) {
		newRoutingMgtService.setRoutingInfo(newRoutingMgtDto); 
	}
	
	@RequestMapping("/updateRoutingInfo")
	@ResponseBody
	public void updateRoutingInfo(@RequestBody NewRoutingMgtDto newRoutingMgtDto) {
		newRoutingMgtService.updateRoutingInfo(newRoutingMgtDto); 
	}
	
	@RequestMapping("/deleteRoutingInfo")
	@ResponseBody
	public void deleteRoutingInfo(@RequestBody NewRoutingMgtDto newRoutingMgtDto) {
		newRoutingMgtService.deleteRoutingInfo(newRoutingMgtDto); 
	}
	
	@RequestMapping("/settingDefaultTool")
	@ResponseBody
	public void settingDefaultTool(@RequestBody NewRoutingMgtDto newRoutingMgtDto) {
		newRoutingMgtService.settingDefaultTool(newRoutingMgtDto); 
	}
	
	@RequestMapping("/getRtlBomList")
	@ResponseBody
	public ModelMap getRtlBomList(@RequestBody NewRoutingMgtDto newRoutingMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", newRoutingMgtService.getRtlBomList(newRoutingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getRtlEqmtList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("newRoutingMgtDto") NewRoutingMgtDto newRoutingMgtDto, ModelMap model) {
		model.addAttribute("rows", newRoutingMgtService.getRtlEqmtList(newRoutingMgtDto));

		return model;
	}
	
	@RequestMapping("/getRtlToolList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("routingRtlToolDto") NewRoutingRtlToolDto routingRtlToolDto, ModelMap model) {
		model.addAttribute("rows", newRoutingMgtService.getRtlToolList(routingRtlToolDto));
		return model;
	}
	
}
