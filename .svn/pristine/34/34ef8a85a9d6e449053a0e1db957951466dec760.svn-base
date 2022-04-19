package jin.mes.form.tool.mtrltoolMgt;

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
@RequestMapping("/form/tool/mtrltoolMgt")
public class MtrltoolMgtController extends BaseController {

	@Autowired
	MtrltoolMgtService mtrltoolMgtService;
	
	//공구상세 조회
	@RequestMapping("getToolMgtList")
	public ModelMap getToolMgtList(ModelMap model, @ModelAttribute("toolMgtDto") MtrltoolMgtDto toolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMgtDto.getPage())));
		pageRequestVo.setRows(toolMgtDto.getRows());
		try {
			setModelWithkendoList(model, mtrltoolMgtService.getToolMgtList(toolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구상세 입력/수정
	@RequestMapping("/setToolMgtSave")
	@ResponseBody
	public String setToolMgtSave(@RequestBody MtrltoolMgtDto toolMgtDto) {
		return mtrltoolMgtService.setToolMgtSave(toolMgtDto);
	}
	
	//공구상세 삭제
	@RequestMapping("/setToolMgtDelete")
	@ResponseBody
	public int setToolMgtDelete(ModelMap model, @RequestBody List<MtrltoolMgtDto> toolMgtList) {
		return mtrltoolMgtService.setToolMgtDelete(toolMgtList);
	}
	
	
	//공구 정비이력 조회
	@RequestMapping("getToolMtncList")
	public ModelMap getToolMtncList(ModelMap model, @ModelAttribute("toolMgtDto") MtrltoolMgtDto toolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMgtDto.getPage())));
		pageRequestVo.setRows(toolMgtDto.getRows());
		try {
			setModelWithkendoList(model, mtrltoolMgtService.getToolMtncList(toolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 정비이력 입력/수정
	@RequestMapping("/setToolMtncSave")
	@ResponseBody
	public String setToolMtncSave(@RequestBody MtrltoolMgtDto toolMgtDto) {
		return mtrltoolMgtService.setToolMtncSave(toolMgtDto);
	}
	
	//공구 정비이력 삭제
	@RequestMapping("/setToolMtncDelete")
	@ResponseBody
	public int setToolMtncDelete(ModelMap model, @RequestBody List<MtrltoolMgtDto> toolMtncList) {
		return mtrltoolMgtService.setToolMtncDelete(toolMtncList);
	}
	
	
	//공구 사용정보 조회
	@RequestMapping("getToolUseList")
	public ModelMap getToolUseList(ModelMap model, @ModelAttribute("toolMgtDto") MtrltoolMgtDto toolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolMgtDto.getPage())));
		pageRequestVo.setRows(toolMgtDto.getRows());
		pageRequestVo.setPagingYN(toolMgtDto.getPagingYN());
		
		try {
			setModelWithkendoList(model, mtrltoolMgtService.getToolUseList(toolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구  사용정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
