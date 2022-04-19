package jin.mes.cform.mtrl.mtrltoolMgt;

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
@RequestMapping("/cform/mtrl/mtrltoolMgt")
public class NewMtrltoolMgtController extends BaseController {

	@Autowired
	NewMtrltoolMgtService newMtrltoolMgtService;
	
	//공구상세 조회
	@RequestMapping("getToolMgtList")
	public ModelMap getToolMgtList(ModelMap model, @ModelAttribute("newToolMgtDto") NewMtrltoolMgtDto newToolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newToolMgtDto.getPage())));
		pageRequestVo.setRows(newToolMgtDto.getRows());
		try {
			setModelWithkendoList(model, newMtrltoolMgtService.getToolMgtList(newToolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구상세 입력/수정
	@RequestMapping("/setToolMgtSave")
	@ResponseBody
	public String setToolMgtSave(@RequestBody NewMtrltoolMgtDto newToolMgtDto) {
		return newMtrltoolMgtService.setToolMgtSave(newToolMgtDto);
	}
	
	//공구상세 삭제
	@RequestMapping("/setToolMgtDelete")
	@ResponseBody
	public int setToolMgtDelete(ModelMap model, @RequestBody List<NewMtrltoolMgtDto> toolMgtList) {
		return newMtrltoolMgtService.setToolMgtDelete(toolMgtList);
	}
	
	
	//공구 정비이력 조회
	@RequestMapping("getToolMtncList")
	public ModelMap getToolMtncList(ModelMap model, @ModelAttribute("newToolMgtDto") NewMtrltoolMgtDto newToolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newToolMgtDto.getPage())));
		pageRequestVo.setRows(newToolMgtDto.getRows());
		try {
			setModelWithkendoList(model, newMtrltoolMgtService.getToolMtncList(newToolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 정비이력 입력/수정
	@RequestMapping("/setToolMtncSave")
	@ResponseBody
	public String setToolMtncSave(@RequestBody NewMtrltoolMgtDto newToolMgtDto) {
		return newMtrltoolMgtService.setToolMtncSave(newToolMgtDto);
	}
	
	//공구 정비이력 삭제
	@RequestMapping("/setToolMtncDelete")
	@ResponseBody
	public int setToolMtncDelete(ModelMap model, @RequestBody List<NewMtrltoolMgtDto> toolMtncList) {
		return newMtrltoolMgtService.setToolMtncDelete(toolMtncList);
	}
	
	
	//공구 사용정보 조회
	@RequestMapping("getToolUseList")
	public ModelMap getToolUseList(ModelMap model, @ModelAttribute("newToolMgtDto") NewMtrltoolMgtDto newToolMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newToolMgtDto.getPage())));
		pageRequestVo.setRows(newToolMgtDto.getRows());
		pageRequestVo.setPagingYN(newToolMgtDto.getPagingYN());
		
		try {
			setModelWithkendoList(model, newMtrltoolMgtService.getToolUseList(newToolMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구  사용정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
