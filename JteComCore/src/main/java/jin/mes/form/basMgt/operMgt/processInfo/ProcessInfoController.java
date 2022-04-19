package jin.mes.form.basMgt.operMgt.processInfo;

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
@RequestMapping("/form/basMgt/operMgt/processInfo")
public class ProcessInfoController extends BaseController {

	@Resource
	protected ProcessInfoService processInfoService;
	
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getProcessInfo")
	public ModelMap getProcessInfo(@ModelAttribute("ProcessInfoDto") ProcessInfoDto processInfoDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(processInfoDto.getPage())));
		pageRequestVo.setRows(processInfoDto.getRows());

		setModelWithkendoList(model, processInfoService.getProcessInfo(processInfoDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getRtlEqmtList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("ProcessInfoDto") ProcessInfoDto processInfoDto, ModelMap model) {
		model.addAttribute("rows", processInfoService.getRtlEqmtList(processInfoDto));

		return model;
	}
	
	@RequestMapping("/setProcessInfo")
	@ResponseBody
	public void setProcessInfo(@RequestBody ProcessInfoDto processInfoDto) {
		processInfoService.setProcessInfo(processInfoDto);
	}
	
	@RequestMapping("/updateProcessInfo")
	@ResponseBody
	public void updateProcessInfo(@RequestBody ProcessInfoDto processInfoDto) {
		processInfoService.updateProcessInfo(processInfoDto); 
	}
	
	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(@RequestBody ProcessInfoDto processInfoDto) {
		processInfoService.updateIsUse(processInfoDto); 
	}
}
