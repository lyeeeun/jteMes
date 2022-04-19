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

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.processInfo.ProcessInfoDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/routing/routingMgt")
public class NewRoutingMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NewRoutingMgtController.class);

	@Resource
	protected NewRoutingMgtService newRoutingMgtService;
	
	@RequestMapping("/getRoutingInfo")
	public ModelMap getRoutingInfo(@ModelAttribute("routingMgtDto") NewRoutingMgtDto routingMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", newRoutingMgtService.getRoutingInfo(routingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setRoutingInfo")
	@ResponseBody
	public void setRoutingInfo(@RequestBody NewRoutingMgtDto routingMgtDto) {
		newRoutingMgtService.setRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/updateRoutingInfo")
	@ResponseBody
	public void updateRoutingInfo(@RequestBody NewRoutingMgtDto routingMgtDto) {
		newRoutingMgtService.updateRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/deleteRoutingInfo")
	@ResponseBody
	public void deleteRoutingInfo(@RequestBody NewRoutingMgtDto routingMgtDto) {
		newRoutingMgtService.deleteRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/settingDefaultTool")
	@ResponseBody
	public void settingDefaultTool(@RequestBody NewRoutingMgtDto routingMgtDto) {
		newRoutingMgtService.settingDefaultTool(routingMgtDto); 
	}
	
	@RequestMapping("/getRtlBomList")
	@ResponseBody
	public ModelMap getRtlBomList(@RequestBody NewRoutingMgtDto routingMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", newRoutingMgtService.getRtlBomList(routingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("BomList 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("/getRtlEqmtList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("routingMgtDto") NewRoutingMgtDto routingMgtDto, ModelMap model) {
		model.addAttribute("rows", newRoutingMgtService.getRtlEqmtList(routingMgtDto));

		return model;
	}
	
	@RequestMapping("/getRtlToolList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("routingRtlToolDto") NewRoutingRtlToolDto routingRtlToolDto, ModelMap model) {
		model.addAttribute("rows", newRoutingMgtService.getRtlToolList(routingRtlToolDto));
		return model;
	}
	
}
