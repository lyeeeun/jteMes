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
	InfergodsMgtService inferGodsMgtService;
	
	@RequestMapping("getMtrlBadList")
	public ModelMap getMtrlBadList(ModelMap model, @ModelAttribute("mtrlBadDto") InfergodsMgtDto mtrlBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlBadDto.getPage())));
		pageRequestVo.setRows(mtrlBadDto.getRows());
		try {
			setModelWithkendoList(model, inferGodsMgtService.getMtrlBadList(mtrlBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody InfergodsMgtDto mtrlBadDto) {
		return inferGodsMgtService.setMtrlBadSave(mtrlBadDto);
	}
	
	@RequestMapping("/setMtrlBadDelete")
	@ResponseBody
	public int setEqmtMgtDelete(ModelMap model, @RequestBody List<InfergodsMgtDto> mtrlBadList) {
		return inferGodsMgtService.setMtrlBadDelete(mtrlBadList);
	}
	
	@RequestMapping("/getItemBadList")
	public ModelMap getItemBadList(ModelMap model, @ModelAttribute("itemBadDto") InfergodsMgtDto itemBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemBadDto.getPage())));
		pageRequestVo.setRows(itemBadDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(itemBadDto.getPagingYN());
		try {
			setModelWithkendoList(model, inferGodsMgtService.getItemBadList(itemBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemBadSave")
	@ResponseBody
	public String setItemBadSave(@RequestBody InfergodsMgtDto itemBadDto) {
		return inferGodsMgtService.setItemBadSave(itemBadDto);
	}
	@RequestMapping("/setItemBadQualSave")
	@ResponseBody
	public String setItemBadQualSave(@RequestBody InfergodsMgtDto itemBadDto) {
		return inferGodsMgtService.setItemBadQualSave(itemBadDto);
	}

	@RequestMapping("/setItemBadDelete")
	@ResponseBody
	public int setItemBadDelete(@RequestBody List<InfergodsMgtDto> itemBadDto) {
		return inferGodsMgtService.setItemBadDelete(itemBadDto);
	}

	/***불량품 관리 로직 변경***/
	@RequestMapping("/getBadRate")
	public ModelMap getBadRate(ModelMap model, @ModelAttribute("infergodsMgtDto") InfergodsMgtDto infergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(infergodsMgtDto.getPage())));
		pageRequestVo.setRows(infergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, inferGodsMgtService.getBadRate(infergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getBadHistory")
	public ModelMap getBadHistory(ModelMap model, @ModelAttribute("infergodsMgtDto") InfergodsMgtDto infergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(infergodsMgtDto.getPage())));
		pageRequestVo.setRows(infergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, inferGodsMgtService.getBadHistory(infergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//타모듈에서 품목 불량 등록
	@RequestMapping("/setItemBadPgSave")
	@ResponseBody
	public String setItemBadPgSave(@RequestBody InfergodsMgtDto itemBadDto) {
		return inferGodsMgtService.setItemBadPgSave(itemBadDto);
	}
}
