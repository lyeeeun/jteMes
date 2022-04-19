package jin.mes.form.qualMgt.infergodsMgt;

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
@RequestMapping("/form/qualMgt/infergodsMgt")
public class InfergodsMgtController extends BaseController {


	@Autowired
	InfergodsMgtService infergodsMgtService;
	
	@RequestMapping("getMtrlBadList")
	public ModelMap getMtrlBadList(ModelMap model, @ModelAttribute("mtrlBadDto") InfergodsMgtDto mtrlBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlBadDto.getPage())));
		pageRequestVo.setRows(mtrlBadDto.getRows());
		try {
			setModelWithkendoList(model, infergodsMgtService.getMtrlBadList(mtrlBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody InfergodsMgtDto mtrlBadDto) {
		return infergodsMgtService.setMtrlBadSave(mtrlBadDto);
	}
	
	@RequestMapping("/setMtrlBadDelete")
	@ResponseBody
	public int setEqmtMgtDelete(ModelMap model, @RequestBody List<InfergodsMgtDto> mtrlBadList) {
		return infergodsMgtService.setMtrlBadDelete(mtrlBadList);
	}
	
	@RequestMapping("/getItemBadList")
	public ModelMap getItemBadList(ModelMap model, @ModelAttribute("itemBadDto") InfergodsMgtDto itemBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemBadDto.getPage())));
		pageRequestVo.setRows(itemBadDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(itemBadDto.getPagingYN());
		try {
			setModelWithkendoList(model, infergodsMgtService.getItemBadList(itemBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemBadSave")
	@ResponseBody
	public String setItemBadSave(@RequestBody InfergodsMgtDto itemBadDto) {
		return infergodsMgtService.setItemBadSave(itemBadDto);
	}
	@RequestMapping("/setItemBadQualSave")
	@ResponseBody
	public String setItemBadQualSave(@RequestBody InfergodsMgtDto itemBadDto) {
		return infergodsMgtService.setItemBadQualSave(itemBadDto);
	}

	@RequestMapping("/setItemBadDelete")
	@ResponseBody
	public int setItemBadDelete(@RequestBody List<InfergodsMgtDto> itemBadDto) {
		return infergodsMgtService.setItemBadDelete(itemBadDto);
	}

	/***불량품 관리 로직 변경***/
	@RequestMapping("/getBadRate")
	public ModelMap getBadRate(ModelMap model, @ModelAttribute("InfergodsMgtDto") InfergodsMgtDto InfergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(InfergodsMgtDto.getPage())));
		pageRequestVo.setRows(InfergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, infergodsMgtService.getBadRate(InfergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getBadHistory")
	public ModelMap getBadHistory(ModelMap model, @ModelAttribute("InfergodsMgtDto") InfergodsMgtDto InfergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(InfergodsMgtDto.getPage())));
		pageRequestVo.setRows(InfergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, infergodsMgtService.getBadHistory(InfergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//타모듈에서 품목 불량 등록
	@RequestMapping("/setItemBadPgSave")
	@ResponseBody
	public String setItemBadPgSave(@RequestBody InfergodsMgtDto itemBadDto) {
		return infergodsMgtService.setItemBadPgSave(itemBadDto);
	}
}
