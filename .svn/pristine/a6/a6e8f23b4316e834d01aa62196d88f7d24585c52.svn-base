package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

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
@RequestMapping("/cform/qualMgt/qualPec/inputQualMgt")
public class NewInputQualMgtController extends BaseController {

	@Autowired
	NewInputQualMgtService newInputQualMgtService;
	
	
	//공구상세 조회
	@RequestMapping("getInputQualDetailList")
	public ModelMap getInputQualDetailList(ModelMap model, @ModelAttribute("inputQualMgtDto") NewInputQualMgtDto inputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(inputQualMgtDto.getPage())));
		pageRequestVo.setRows(inputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, newInputQualMgtService.getInputQualDetailList(inputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	
	//공구상세 조회
	@RequestMapping("getInputQualList")
	public ModelMap getInputQualList(ModelMap model, @ModelAttribute("inputQualMgtDto") NewInputQualMgtDto inputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(inputQualMgtDto.getPage())));
		pageRequestVo.setRows(inputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, newInputQualMgtService.getInputQualList(inputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구상세 입력/수정
	@RequestMapping("/setInputQualSave")
	@ResponseBody
	public String setInputQualSave(@RequestBody NewInputQualMgtDto inputQualMgtDto) {
		return newInputQualMgtService.setInputQualSave(inputQualMgtDto);
	}
	
	//공구상세 삭제
	@RequestMapping("/setInputQualDelete")
	@ResponseBody
	public int setInputQualDelete(ModelMap model, @RequestBody List<NewInputQualMgtDto> inputQualList) {
		return newInputQualMgtService.setInputQualDelete(inputQualList);
	}
	
	
	//공구 정비이력 조회
	@RequestMapping("getInputQualAddList")
	public ModelMap getInputQualAddList(ModelMap model, @ModelAttribute("inputQualMgtDto") NewInputQualMgtDto inputQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(inputQualMgtDto.getPage())));
		pageRequestVo.setRows(inputQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, newInputQualMgtService.getInputQualAddList(inputQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//공구 정비이력 입력/수정
	@RequestMapping("/setInputQualAddSave")
	@ResponseBody
	public String setInputQualAddSave(@RequestBody NewInputQualMgtDto inputQualMgtDto) {
		return newInputQualMgtService.setInputQualAddSave(inputQualMgtDto);
	}
	
	//공구 정비이력 삭제
	@RequestMapping("/setInputQualAddDelete")
	@ResponseBody
	public int setInputQualAddDelete(ModelMap model, @RequestBody List<NewInputQualMgtDto> inputQualAddList) {
		return newInputQualMgtService.setInputQualAddDelete(inputQualAddList);
	}
}
