package jin.mes.cform.basMgt.operMgt.toolMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.operMgt.compMgt.NewCompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/operMgt/toolMgt")
public class NewToolMgtController extends BaseController {

	@Autowired
	NewToolMgtService newToolMgtService;
	
	@RequestMapping("getToolInfoList")
	public ModelMap getToolInfoList(ModelMap model, @ModelAttribute("newToolMgtDto") NewToolMgtDto newToolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newToolMgtDto.getPage())));
		pageRequestVo.setRows(newToolMgtDto.getRows());
		try {
			setModelWithkendoList(model, newToolMgtService.getToolInfoList(newToolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setToolInfoSave")
	@ResponseBody
	public String setToolInfoSave(@RequestBody NewToolMgtDto newToolMgtDto) {
		return newToolMgtService.setToolInfoSave(newToolMgtDto);
	}
	
	@RequestMapping("/setToolInfoDelete")
	@ResponseBody
	public int setToolInfoDelete(ModelMap model, @RequestBody List<NewToolMgtDto> facilMgtList) {
		return newToolMgtService.setToolInfoDelete(facilMgtList);
	}
	
	@RequestMapping("/getMtrlRtlCompList")
	public ModelMap getMtrlRtlCompList(ModelMap model, @ModelAttribute("newCompMgtDto") NewCompMgtDto newCompMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newCompMgtDto.getPage())));
		pageRequestVo.setRows(newCompMgtDto.getRows());
		try {
			setModelWithkendoList(model, newToolMgtService.getToolRtlCompList(newCompMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구구매 업체 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlRtlCompSave")
	@ResponseBody
	public String setMtrlRtlCompSave(@RequestBody NewCompMgtDto newCompDto) {
		return newToolMgtService.setToolRtlCompSave(newCompDto);
	}
	
	@RequestMapping("/setMtrlRtlCompDelete")
	@ResponseBody
	public int setMtrlRtlCompDelete(ModelMap model, @RequestBody List<NewCompMgtDto> compList) {
		return newToolMgtService.setToolRtlCompDelete(compList);
	}
	
	@RequestMapping("/getAllToolInfoList")
	public ModelMap getAllToolInfoList(ModelMap model, @ModelAttribute("newToolMgtDto") NewToolMgtDto newToolMgtDto) {
		try {
			model.addAttribute("result", newToolMgtService.getAllToolInfoList(newToolMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("공구 전체 목록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
