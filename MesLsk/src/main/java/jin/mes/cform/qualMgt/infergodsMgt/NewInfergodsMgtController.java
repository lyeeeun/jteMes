package jin.mes.cform.qualMgt.infergodsMgt;

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
@RequestMapping("/cform/qualMgt/infergodsMgt")
public class NewInfergodsMgtController extends BaseController {


	@Autowired
	NewInfergodsMgtService newInferGodsMgtService;
	
	@RequestMapping("getMtrlBadList")
	public ModelMap getMtrlBadList(ModelMap model, @ModelAttribute("newMtrlBadDto") NewInfergodsMgtDto newMtrlBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newMtrlBadDto.getPage())));
		pageRequestVo.setRows(newMtrlBadDto.getRows());
		try {
			setModelWithkendoList(model, newInferGodsMgtService.getMtrlBadList(newMtrlBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody NewInfergodsMgtDto newMtrlBadDto) {
		return newInferGodsMgtService.setMtrlBadSave(newMtrlBadDto);
	}
	
	@RequestMapping("/setMtrlBadDelete")
	@ResponseBody
	public int setEqmtMgtDelete(ModelMap model, @RequestBody List<NewInfergodsMgtDto> mtrlBadList) {
		return newInferGodsMgtService.setMtrlBadDelete(mtrlBadList);
	}
	
	@RequestMapping("/getItemBadList")
	public ModelMap getItemBadList(ModelMap model, @ModelAttribute("newItemBadDto") NewInfergodsMgtDto newItemBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newItemBadDto.getPage())));
		pageRequestVo.setRows(newItemBadDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(newItemBadDto.getPagingYN());
		try {
			setModelWithkendoList(model, newInferGodsMgtService.getItemBadList(newItemBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemBadSave")
	@ResponseBody
	public String setItemBadSave(@RequestBody NewInfergodsMgtDto newItemBadDto) {
		return newInferGodsMgtService.setItemBadSave(newItemBadDto);
	}
	@RequestMapping("/setItemBadQualSave")
	@ResponseBody
	public String setItemBadQualSave(@RequestBody NewInfergodsMgtDto newItemBadDto) {
		return newInferGodsMgtService.setItemBadQualSave(newItemBadDto);
	}

	@RequestMapping("/setItemBadDelete")
	@ResponseBody
	public int setItemBadDelete(@RequestBody List<NewInfergodsMgtDto> newItemBadDto) {
		return newInferGodsMgtService.setItemBadDelete(newItemBadDto);
	}

	/***불량품 관리 로직 변경***/
	@RequestMapping("/getBadRate")
	public ModelMap getBadRate(ModelMap model, @ModelAttribute("newInfergodsMgtDto") NewInfergodsMgtDto newInfergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newInfergodsMgtDto.getPage())));
		pageRequestVo.setRows(newInfergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, newInferGodsMgtService.getBadRate(newInfergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getBadHistory")
	public ModelMap getBadHistory(ModelMap model, @ModelAttribute("newInfergodsMgtDto") NewInfergodsMgtDto newInfergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newInfergodsMgtDto.getPage())));
		pageRequestVo.setRows(newInfergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, newInferGodsMgtService.getBadHistory(newInfergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//타모듈에서 품목 불량 등록
	@RequestMapping("/setItemBadPgSave")
	@ResponseBody
	public String setItemBadPgSave(@RequestBody NewInfergodsMgtDto newItemBadDto) {
		return newInferGodsMgtService.setItemBadPgSave(newItemBadDto);
	}
}
