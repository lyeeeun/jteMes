package jin.mes.cform.basMgt.operMgt.processInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/basMgt/operMgt/processInfo")
public class NewProcessInfoController extends BaseController {

	@Resource
	protected NewProcessInfoService newProcessInfoService;
	
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getProcessInfo")
	public ModelMap getProcessInfo(@ModelAttribute("ProcessInfoDto") NewProcessInfoDto processInfoDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(processInfoDto.getPage())));
		pageRequestVo.setRows(processInfoDto.getRows());

		setModelWithkendoList(model, newProcessInfoService.getProcessInfo(processInfoDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getRtlEqmtList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("ProcessInfoDto") NewProcessInfoDto processInfoDto, ModelMap model) {
		model.addAttribute("rows", newProcessInfoService.getRtlEqmtList(processInfoDto));

		return model;
	}
	
	@RequestMapping("/setProcessInfo")
	@ResponseBody
	public void setProcessInfo(@RequestBody NewProcessInfoDto processInfoDto) {
		newProcessInfoService.setProcessInfo(processInfoDto);
	}
	
	@RequestMapping("/updateProcessInfo")
	@ResponseBody
	public void updateProcessInfo(@RequestBody NewProcessInfoDto processInfoDto) {
		newProcessInfoService.updateProcessInfo(processInfoDto); 
	}
	
	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(@RequestBody NewProcessInfoDto processInfoDto) {
		newProcessInfoService.updateIsUse(processInfoDto); 
	}
}
