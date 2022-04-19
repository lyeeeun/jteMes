package jin.mes.form.facilMgt.currentMountTool;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/facilMgt/currentMountTool")
public class CurrentMountToolController extends BaseController {
	
	@Autowired
	CurrentMountToolService currentMountToolService;
	

	@RequestMapping("/getEqmtToolRtlList")
	public ModelMap getEqmtToolRtlList(@ModelAttribute("currentMountToolDto") CurrentMountToolDto currentMountToolDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(currentMountToolDto.getPage())));
		pageRequestVo.setRows(currentMountToolDto.getRows());

		setModelWithkendoList(model, currentMountToolService.getEqmtToolRtlList(currentMountToolDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getEqmtToolPop")
	public ModelMap getEqmtToolPop(@ModelAttribute("currentMountToolDto") CurrentMountToolDto currentMountToolDto, ModelMap model) {
		model.addAttribute("rows", currentMountToolService.getEqmtToolPop(currentMountToolDto));

		return model;
	}
	

	@RequestMapping("/getRtlToolList")
	public ModelMap getRtlToolList(@ModelAttribute("currentMountToolDto") CurrentMountToolDto currentMountToolDto, ModelMap model) {
		model.addAttribute("result", currentMountToolService.getRtlToolList(currentMountToolDto));

		return model;
	}
	
	//LoT정보 등록/수정
	@RequestMapping("/setEqmtTool")
	@ResponseBody
	public String setEqmtTool(@RequestBody CurrentMountToolDto currentMountToolDto) {
		return currentMountToolService.setEqmtTool(currentMountToolDto);
	}
}
