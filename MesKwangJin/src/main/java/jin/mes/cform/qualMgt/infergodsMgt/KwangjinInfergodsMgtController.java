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
public class KwangjinInfergodsMgtController extends BaseController {


	@Autowired
	KwangjinInfergodsMgtService kwangjinInfergodsMgtService;
	
	@RequestMapping("getMtrlBadList")
	public ModelMap getMtrlBadList(ModelMap model, @ModelAttribute("mtrlBadDto") KwangjinInfergodsMgtDto mtrlBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlBadDto.getPage())));
		pageRequestVo.setRows(mtrlBadDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinInfergodsMgtService.getMtrlBadList(mtrlBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody KwangjinInfergodsMgtDto mtrlBadDto) {
		return kwangjinInfergodsMgtService.setMtrlBadSave(mtrlBadDto);
	}
	
	@RequestMapping("/setMtrlBadDelete")
	@ResponseBody
	public int setEqmtMgtDelete(ModelMap model, @RequestBody List<KwangjinInfergodsMgtDto> mtrlBadList) {
		return kwangjinInfergodsMgtService.setMtrlBadDelete(mtrlBadList);
	}
	
	@RequestMapping("/getItemBadList")
	public ModelMap getItemBadList(ModelMap model, @ModelAttribute("itemBadDto") KwangjinInfergodsMgtDto itemBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemBadDto.getPage())));
		pageRequestVo.setRows(itemBadDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(itemBadDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinInfergodsMgtService.getItemBadList(itemBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemBadSave")
	@ResponseBody
	public String setItemBadSave(@RequestBody KwangjinInfergodsMgtDto itemBadDto) {
		return kwangjinInfergodsMgtService.setItemBadSave(itemBadDto);
	}
	@RequestMapping("/setItemBadQualSave")
	@ResponseBody
	public String setItemBadQualSave(@RequestBody KwangjinInfergodsMgtDto itemBadDto) {
		return kwangjinInfergodsMgtService.setItemBadQualSave(itemBadDto);
	}

	@RequestMapping("/setItemBadDelete")
	@ResponseBody
	public int setItemBadDelete(@RequestBody List<KwangjinInfergodsMgtDto> itemBadDto) {
		return kwangjinInfergodsMgtService.setItemBadDelete(itemBadDto);
	}

	/***불량품 관리 로직 변경***/
	@RequestMapping("/getBadRate")
	public ModelMap getBadRate(ModelMap model, @ModelAttribute("InfergodsMgtDto") KwangjinInfergodsMgtDto InfergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(InfergodsMgtDto.getPage())));
		pageRequestVo.setRows(InfergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinInfergodsMgtService.getBadRate(InfergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getBadHistory")
	public ModelMap getBadHistory(ModelMap model, @ModelAttribute("InfergodsMgtDto") KwangjinInfergodsMgtDto InfergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(InfergodsMgtDto.getPage())));
		pageRequestVo.setRows(InfergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinInfergodsMgtService.getBadHistory(InfergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//타모듈에서 품목 불량 등록
	@RequestMapping("/setItemBadPgSave")
	@ResponseBody
	public String setItemBadPgSave(@RequestBody KwangjinInfergodsMgtDto itemBadDto) {
		return kwangjinInfergodsMgtService.setItemBadPgSave(itemBadDto);
	}
}
