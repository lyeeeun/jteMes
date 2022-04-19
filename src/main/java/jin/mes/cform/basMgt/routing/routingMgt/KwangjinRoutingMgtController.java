package jin.mes.cform.basMgt.routing.routingMgt;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.routing.routingMgt.KwangjinRoutingMgtController;
import jin.mes.cform.basMgt.routing.routingMgt.KwangjinRoutingMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/routing/routingMgt")
public class KwangjinRoutingMgtController extends BaseController {
	@Resource
	protected KwangjinRoutingMgtService kwangjinRoutingMgtService;
	
	@RequestMapping("/getRoutingInfo")
	public ModelMap getRoutingInfo(@ModelAttribute("kwangjinRoutingMgtDto") KwangjinRoutingMgtDto kwangjinRoutingMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", kwangjinRoutingMgtService.getRoutingInfo(kwangjinRoutingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("라우팅 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setRoutingInfo")
	@ResponseBody
	public void setRoutingInfo(@RequestBody KwangjinRoutingMgtDto kwangjinRoutingMgtDto) {
		kwangjinRoutingMgtService.setRoutingInfo(kwangjinRoutingMgtDto); 
	}
	
	@RequestMapping("/updateRoutingInfo")
	@ResponseBody
	public void updateRoutingInfo(@RequestBody KwangjinRoutingMgtDto kwangjinRoutingMgtDto) {
		kwangjinRoutingMgtService.updateRoutingInfo(kwangjinRoutingMgtDto); 
	}
	
	@RequestMapping("/deleteRoutingInfo")
	@ResponseBody
	public void deleteRoutingInfo(@RequestBody KwangjinRoutingMgtDto kwangjinRoutingMgtDto) {
		kwangjinRoutingMgtService.deleteRoutingInfo(kwangjinRoutingMgtDto); 
	}
	
	@RequestMapping("/settingDefaultTool")
	@ResponseBody
	public void settingDefaultTool(@RequestBody KwangjinRoutingMgtDto kwangjinRoutingMgtDto) {
		kwangjinRoutingMgtService.settingDefaultTool(kwangjinRoutingMgtDto); 
	}
	
	@RequestMapping("/getChildRtlList")
	@ResponseBody
	public ModelMap getChildRtlList(@RequestBody KwangjinRoutingMgtDto kwangjinRoutingMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", kwangjinRoutingMgtService.getChildRtlList(kwangjinRoutingMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("routing rtl 조회 에러: " + ex.getMessage());
		}
		return model;
	}

	
}
