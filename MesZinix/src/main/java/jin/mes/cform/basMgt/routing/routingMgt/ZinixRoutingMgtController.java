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

import jin.mes.cform.basMgt.routing.routingMgt.ZinixRoutingMgtController;
import jin.mes.cform.basMgt.routing.routingMgt.ZinixRoutingMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/routing/routingMgt")
public class ZinixRoutingMgtController extends BaseController {
	@Resource
	protected ZinixRoutingMgtService zinixRoutingMgtService;
	
	@RequestMapping("/getRoutingInfo")
	public ModelMap getRoutingInfo(@ModelAttribute("routingMgtDto") ZinixRoutingMgtDto routingMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", zinixRoutingMgtService.getRoutingInfo(routingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("라우팅 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setRoutingInfo")
	@ResponseBody
	public void setRoutingInfo(@RequestBody ZinixRoutingMgtDto routingMgtDto) {
		zinixRoutingMgtService.setRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/updateRoutingInfo")
	@ResponseBody
	public void updateRoutingInfo(@RequestBody ZinixRoutingMgtDto routingMgtDto) {
		zinixRoutingMgtService.updateRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/deleteRoutingInfo")
	@ResponseBody
	public void deleteRoutingInfo(@RequestBody ZinixRoutingMgtDto routingMgtDto) {
		zinixRoutingMgtService.deleteRoutingInfo(routingMgtDto); 
	}
	
	@RequestMapping("/settingDefaultTool")
	@ResponseBody
	public void settingDefaultTool(@RequestBody ZinixRoutingMgtDto routingMgtDto) {
		zinixRoutingMgtService.settingDefaultTool(routingMgtDto); 
	}
	
	@RequestMapping("/getChildRtlList")
	@ResponseBody
	public ModelMap getChildRtlList(@RequestBody ZinixRoutingMgtDto routingMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", zinixRoutingMgtService.getChildRtlList(routingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("routing rtl 조회 에러: " + ex.getMessage());
		}
		return model;
	}

	
}
