package jin.mes.cform.basMgt.operMgt.toolMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/operMgt/toolMgt")
public class ZinixToolMgtController extends BaseController {

	@Autowired
	ZinixToolMgtService zinixToolMgtService;
	
	
	//수주 상세조회(order-child)
	@RequestMapping("getOrderPop")
	public ModelMap getOrderPop(ModelMap model, @ModelAttribute("toolMgtDto") ZinixToolMgtDto toolMgtDto) {

		try {
			model.addAttribute("rows",zinixToolMgtService.getOrderPop(toolMgtDto)); 
		}catch(Exception ex) {
			throw new BusinessException("수주 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("getToolInfoList")
	public ModelMap getToolInfoList(ModelMap model, @ModelAttribute("toolMgtDto") ZinixToolMgtDto toolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMgtDto.getPage())));
		pageRequestVo.setRows(toolMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixToolMgtService.getToolInfoList(toolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setToolInfoSave")
	@ResponseBody
	public String setToolInfoSave(@RequestBody ZinixToolMgtDto toolMgtDto) {
		return zinixToolMgtService.setToolInfoSave(toolMgtDto);
	}
	
	@RequestMapping("/setToolInfoDelete")
	@ResponseBody
	public int setToolInfoDelete(ModelMap model, @RequestBody List<ZinixToolMgtDto> facilMgtList) {
		return zinixToolMgtService.setToolInfoDelete(facilMgtList);
	}
	
	@RequestMapping("/getMtrlRtlCompList")
	public ModelMap getMtrlRtlCompList(ModelMap model, @ModelAttribute("compMgtDto") ZinixCompMgtDto compMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(compMgtDto.getPage())));
		pageRequestVo.setRows(compMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixToolMgtService.getToolRtlCompList(compMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구구매 업체 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlRtlCompSave")
	@ResponseBody
	public String setMtrlRtlCompSave(@RequestBody ZinixToolMgtDto toolMgtDto) {
		return zinixToolMgtService.setToolRtlCompSave(toolMgtDto);
	}
	
	@RequestMapping("/setMtrlRtlCompDelete")
	@ResponseBody
	public int setMtrlRtlCompDelete(ModelMap model, @RequestBody List<ZinixCompMgtDto> compList) {
		return zinixToolMgtService.setToolRtlCompDelete(compList);
	}
	
	@RequestMapping("/getAllToolInfoList")
	public ModelMap getAllToolInfoList(ModelMap model, @ModelAttribute("toolMgtDto") ZinixToolMgtDto toolMgtDto) {
		try {
			model.addAttribute("result", zinixToolMgtService.getAllToolInfoList(toolMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("공구 전체 목록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
