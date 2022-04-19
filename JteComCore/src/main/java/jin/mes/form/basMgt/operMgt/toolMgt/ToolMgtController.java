package jin.mes.form.basMgt.operMgt.toolMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/basMgt/operMgt/toolMgt")
public class ToolMgtController extends BaseController {

	@Autowired
	ToolMgtService toolMgtService;
	
	
	//수주 상세조회(order-child)
	@RequestMapping("getOrderPop")
	public ModelMap getOrderPop(ModelMap model, @ModelAttribute("toolMgtDto") ToolMgtDto toolMgtDto) {

		try {
			model.addAttribute("rows",toolMgtService.getOrderPop(toolMgtDto)); 
		}catch(Exception ex) {
			throw new BusinessException("수주 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("getToolInfoList")
	public ModelMap getToolInfoList(ModelMap model, @ModelAttribute("toolMgtDto") ToolMgtDto toolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMgtDto.getPage())));
		pageRequestVo.setRows(toolMgtDto.getRows());
		try {
			setModelWithkendoList(model, toolMgtService.getToolInfoList(toolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setToolInfoSave")
	@ResponseBody
	public String setToolInfoSave(@RequestBody ToolMgtDto toolMgtDto) {
		return toolMgtService.setToolInfoSave(toolMgtDto);
	}
	
	@RequestMapping("/setToolInfoDelete")
	@ResponseBody
	public int setToolInfoDelete(ModelMap model, @RequestBody List<ToolMgtDto> facilMgtList) {
		return toolMgtService.setToolInfoDelete(facilMgtList);
	}
	
	@RequestMapping("/getMtrlRtlCompList")
	public ModelMap getMtrlRtlCompList(ModelMap model, @ModelAttribute("compMgtDto") CompMgtDto compMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(compMgtDto.getPage())));
		pageRequestVo.setRows(compMgtDto.getRows());
		try {
			setModelWithkendoList(model, toolMgtService.getToolRtlCompList(compMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구구매 업체 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlRtlCompSave")
	@ResponseBody
	public String setMtrlRtlCompSave(@RequestBody ToolMgtDto toolMgtDto) {
		return toolMgtService.setToolRtlCompSave(toolMgtDto);
	}
	
	@RequestMapping("/setMtrlRtlCompDelete")
	@ResponseBody
	public int setMtrlRtlCompDelete(ModelMap model, @RequestBody List<CompMgtDto> compList) {
		return toolMgtService.setToolRtlCompDelete(compList);
	}
	
	@RequestMapping("/getAllToolInfoList")
	public ModelMap getAllToolInfoList(ModelMap model, @ModelAttribute("toolMgtDto") ToolMgtDto toolMgtDto) {
		try {
			model.addAttribute("result", toolMgtService.getAllToolInfoList(toolMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("공구 전체 목록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
