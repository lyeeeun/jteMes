package jin.mes.cform.qualMgt.toolQualMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.qualMgt.toolQualMgt.KwangjinToolQualMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Controller
@RequestMapping("/cform/qualMgt/toolQualMgt")
public class KwangjinToolQualMgtController extends BaseController {

	@Autowired
	KwangjinToolQualMgtService kwangjinToolQualMgtService;

	@RequestMapping("getToolMgtList")
	public ModelMap getToolMgtList(ModelMap model, @ModelAttribute("kwangjinToolQualMgtDto") KwangjinToolQualMgtDto kwangjinToolQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinToolQualMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinToolQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinToolQualMgtService.getToolMgtList(kwangjinToolQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getToolInfoList")
	public ModelMap getToolInfoList(ModelMap model, @ModelAttribute("kwangjinToolQualMgtDto") KwangjinToolQualMgtDto kwangjinToolQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinToolQualMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinToolQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinToolQualMgtService.getToolInfoList(kwangjinToolQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getToolQualList")
	public ModelMap getToolQualList(ModelMap model, @ModelAttribute("kwangjinToolQualMgtDto") KwangjinToolQualMgtDto kwangjinToolQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinToolQualMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinToolQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinToolQualMgtService.getToolQualList(kwangjinToolQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("검사정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setToolQualSave")
	@ResponseBody
	public String setToolQualSave(@RequestBody KwangjinToolQualMgtDto kwangjinToolQualMgtDto) {
		return kwangjinToolQualMgtService.setToolQualSave(kwangjinToolQualMgtDto);
	}
	
	@RequestMapping("/setToolQualDelete")
	@ResponseBody
	public int setToolQualDelete(ModelMap model, @RequestBody List<KwangjinToolQualMgtDto> ToolQualList) {
		return kwangjinToolQualMgtService.setToolQualDelete(ToolQualList);
	}
	
}
