package jin.mes.cform.basMgt.operMgt.compMgt;

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
@RequestMapping("/cform/basMgt/operMgt/compMgt")
public class NewCompMgtController extends BaseController {

	@Autowired
	NewCompMgtService newCompMgtService;
	
	
	@RequestMapping("getCompList")
	public ModelMap getCompList(ModelMap model, @ModelAttribute("newCompMgtDto") NewCompMgtDto newCompMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newCompMgtDto.getPage())));
		pageRequestVo.setRows(newCompMgtDto.getRows());
		try {
			setModelWithkendoList(model, newCompMgtService.getCompList(newCompMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("업체 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setCompSave")
	@ResponseBody
	public String setCompSave(@RequestBody NewCompMgtDto compDto) {
		return newCompMgtService.setCompSave(compDto);
	}
	
	@RequestMapping("/setCompDelete")
	@ResponseBody
	public int setCompDelete(ModelMap model, @RequestBody List<NewCompMgtDto> compList) {
		return newCompMgtService.setCompDelete(compList);
	}
	
	@RequestMapping("getCompAddrList")
	public ModelMap getCompAddrList(ModelMap model, @ModelAttribute("newCompAddrDto") NewCompAddrDto newCompAddrDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newCompAddrDto.getPage())));
		pageRequestVo.setRows(newCompAddrDto.getRows());
		try {
			setModelWithkendoList(model, newCompMgtService.getCompAddrList(newCompAddrDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("업체 조회 에러  : " + ex.getMessage());
		}
		return model;
	}

	@RequestMapping("/setCompAddrSave")
	@ResponseBody
	public String setCompAddrSave(@RequestBody NewCompAddrDto newCompAddrDto) {
		return newCompMgtService.setCompAddrSave(newCompAddrDto);
	}

	@RequestMapping("/setCompAddrDelete")
	@ResponseBody
	public int setCompAddrDelete(ModelMap model, @RequestBody List<NewCompAddrDto> compAddrList) {
		return newCompMgtService.setCompAddrDelete(compAddrList);
	}

	@RequestMapping("/getAllCompList")
	public ModelMap getAllCompList(@ModelAttribute NewCompMgtDto newCompMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", newCompMgtService.getAllCompList(newCompMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("업체 전체 목록 조회 에러  : " + ex.getMessage());
		}
		return model;
	}



}
