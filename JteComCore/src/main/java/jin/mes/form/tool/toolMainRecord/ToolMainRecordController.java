package jin.mes.form.tool.toolMainRecord;

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
@RequestMapping("/form/tool/toolMainRecord")
public class ToolMainRecordController extends BaseController {

	@Autowired
	ToolMainRecordService toolMainRecordService;
	
	//공구상세 조회
	@RequestMapping("getToolRecordList")
	public ModelMap getToolRecordList(ModelMap model, @ModelAttribute("toolMainRecordDto") ToolMainRecordDto toolMainRecordDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMainRecordDto.getPage())));
		pageRequestVo.setRows(toolMainRecordDto.getRows());
		try {
			setModelWithkendoList(model, toolMainRecordService.getToolRecordList(toolMainRecordDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}

	//공구 정비이력 조회
	@RequestMapping("getToolMainRecordList")
	public ModelMap getToolMainRecordList(ModelMap model, @ModelAttribute("toolMainRecordDto") ToolMainRecordDto toolMainRecordDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMainRecordDto.getPage())));
		pageRequestVo.setRows(toolMainRecordDto.getRows());
		try {
			setModelWithkendoList(model, toolMainRecordService.getToolMainRecordList(toolMainRecordDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 정비이력 입력/수정
	@RequestMapping("/setToolMainRecordSave")
	@ResponseBody
	public String setToolMainRecordSave(@RequestBody ToolMainRecordDto toolMainRecordDto) {
		return toolMainRecordService.setToolMainRecordSave(toolMainRecordDto);
	}
	
	//공구 정비이력 삭제
	@RequestMapping("/setToolMainRecordDelete")
	@ResponseBody
	public int setToolMainRecordDelete(ModelMap model, @RequestBody List<ToolMainRecordDto> toolMtncList) {
		return toolMainRecordService.setToolMainRecordDelete(toolMtncList);
	}
	
}
