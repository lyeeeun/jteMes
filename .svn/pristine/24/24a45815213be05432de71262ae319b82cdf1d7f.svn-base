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
public class ZinixInfergodsMgtController extends BaseController {


	@Autowired
	ZinixInfergodsMgtService zinixInfergodsMgtService;
	
	@RequestMapping("getMtrlBadList")
	public ModelMap getMtrlBadList(ModelMap model, @ModelAttribute("mtrlBadDto") ZinixInfergodsMgtDto mtrlBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlBadDto.getPage())));
		pageRequestVo.setRows(mtrlBadDto.getRows());
		try {
			setModelWithkendoList(model, zinixInfergodsMgtService.getMtrlBadList(mtrlBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlBadSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody ZinixInfergodsMgtDto mtrlBadDto) {
		return zinixInfergodsMgtService.setMtrlBadSave(mtrlBadDto);
	}
	
	@RequestMapping("/setMtrlBadDelete")
	@ResponseBody
	public int setEqmtMgtDelete(ModelMap model, @RequestBody List<ZinixInfergodsMgtDto> mtrlBadList) {
		return zinixInfergodsMgtService.setMtrlBadDelete(mtrlBadList);
	}
	
	@RequestMapping("/getItemBadList")
	public ModelMap getItemBadList(ModelMap model, @ModelAttribute("itemBadDto") ZinixInfergodsMgtDto itemBadDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemBadDto.getPage())));
		pageRequestVo.setRows(itemBadDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(itemBadDto.getPagingYN());
		try {
			setModelWithkendoList(model, zinixInfergodsMgtService.getItemBadList(itemBadDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setItemBadSave")
	@ResponseBody
	public String setItemBadSave(@RequestBody ZinixInfergodsMgtDto itemBadDto) {
		return zinixInfergodsMgtService.setItemBadSave(itemBadDto);
	}
	@RequestMapping("/setItemBadQualSave")
	@ResponseBody
	public String setItemBadQualSave(@RequestBody ZinixInfergodsMgtDto itemBadDto) {
		return zinixInfergodsMgtService.setItemBadQualSave(itemBadDto);
	}

	@RequestMapping("/setItemBadDelete")
	@ResponseBody
	public int setItemBadDelete(@RequestBody List<ZinixInfergodsMgtDto> itemBadDto) {
		return zinixInfergodsMgtService.setItemBadDelete(itemBadDto);
	}

	/***불량품 관리 로직 변경***/
	@RequestMapping("/getBadRate")
	public ModelMap getBadRate(ModelMap model, @ModelAttribute("zinixInfergodsMgtDto") ZinixInfergodsMgtDto zinixInfergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixInfergodsMgtDto.getPage())));
		pageRequestVo.setRows(zinixInfergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixInfergodsMgtService.getBadRate(zinixInfergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getBadHistory")
	public ModelMap getBadHistory(ModelMap model, @ModelAttribute("zinixInfergodsMgtDto") ZinixInfergodsMgtDto zinixInfergodsMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixInfergodsMgtDto.getPage())));
		pageRequestVo.setRows(zinixInfergodsMgtDto.getRows());
		try {
			setModelWithkendoList(model, zinixInfergodsMgtService.getBadHistory(zinixInfergodsMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//타모듈에서 품목 불량 등록
	@RequestMapping("/setItemBadPgSave")
	@ResponseBody
	public String setItemBadPgSave(@RequestBody ZinixInfergodsMgtDto itemBadDto) {
		return zinixInfergodsMgtService.setItemBadPgSave(itemBadDto);
	}
}
