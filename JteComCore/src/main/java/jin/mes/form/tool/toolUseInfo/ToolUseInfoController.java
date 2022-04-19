package jin.mes.form.tool.toolUseInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/tool/toolUseInfo")
public class ToolUseInfoController extends BaseController {
	@Autowired
	ToolUseInfoService toolUseInfoService;
	
	//공구상세 조회
	@RequestMapping("getToolUseList")
	public ModelMap getToolUseList(ModelMap model, @ModelAttribute("toolUseInfoDto") ToolUseInfoDto toolUseInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolUseInfoDto.getPage())));
		pageRequestVo.setRows(toolUseInfoDto.getRows());
		try {
			setModelWithkendoList(model, toolUseInfoService.getToolUseList(toolUseInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 사용정보 조회
	@RequestMapping("getToolUseInfoList")
	public ModelMap getToolUseInfoList(ModelMap model, @ModelAttribute("toolUseInfoDto") ToolUseInfoDto toolUseInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolUseInfoDto.getPage())));
		pageRequestVo.setRows(toolUseInfoDto.getRows());
		pageRequestVo.setPagingYN(toolUseInfoDto.getPagingYN());
		
		try {
			setModelWithkendoList(model, toolUseInfoService.getToolUseInfoList(toolUseInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구  사용정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
