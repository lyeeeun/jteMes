package jin.mes.cform.basMgt.operMgt.processInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.operMgt.itemMgt.KwangjinItemMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/basMgt/operMgt/processInfo")
public class KwangjinProcessInfoController extends BaseController {

	@Resource
	protected KwangjinProcessInfoService kwangjinProcessInfoService;
	
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getProcessInfo")
	public ModelMap getProcessInfo(@ModelAttribute("kwangjinProcessInfoDto") KwangjinProcessInfoDto kwangjinProcessInfoDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinProcessInfoDto.getPage())));
		pageRequestVo.setRows(kwangjinProcessInfoDto.getRows());

		setModelWithkendoList(model, kwangjinProcessInfoService.getProcessInfo(kwangjinProcessInfoDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getRtlEqmtList")
	public ModelMap getRtlEqmtInfoList(@ModelAttribute("kwangjinProcessInfoDto") KwangjinProcessInfoDto kwangjinProcessInfoDto, ModelMap model) {
		model.addAttribute("rows", kwangjinProcessInfoService.getRtlEqmtList(kwangjinProcessInfoDto));

		return model;
	}
	
	@RequestMapping("/setProcessInfo")
	@ResponseBody
	public void setProcessInfo(@RequestBody KwangjinProcessInfoDto kwangjinProcessInfoDto) {
		kwangjinProcessInfoService.setProcessInfo(kwangjinProcessInfoDto);
	}
	
	@RequestMapping("/updateProcessInfo")
	@ResponseBody
	public void updateProcessInfo(@RequestBody KwangjinProcessInfoDto kwangjinProcessInfoDto) {
		kwangjinProcessInfoService.updateProcessInfo(kwangjinProcessInfoDto); 
	}
	
	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(@RequestBody KwangjinProcessInfoDto kwangjinProcessInfoDto) {
		kwangjinProcessInfoService.updateIsUse(kwangjinProcessInfoDto); 
	}
}
