package jin.mes.form.basMgt.operMgt.compMgt;

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
@RequestMapping("/form/basMgt/operMgt/compMgt")
public class CompMgtController extends BaseController {

	@Autowired
	CompMgtService compMgtService;
	
	
	@RequestMapping("getCompList")
	public ModelMap getCompList(ModelMap model, @ModelAttribute("compMgtDto") CompMgtDto compMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(compMgtDto.getPage())));
		pageRequestVo.setRows(compMgtDto.getRows());
		try {
			setModelWithkendoList(model, compMgtService.getCompList(compMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("업체 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setCompSave")
	@ResponseBody
	public String setCompSave(@RequestBody CompMgtDto compDto) {
		return compMgtService.setCompSave(compDto);
	}
	
	@RequestMapping("/setCompDelete")
	@ResponseBody
	public int setCompDelete(ModelMap model, @RequestBody List<CompMgtDto> compList) {
		return compMgtService.setCompDelete(compList);
	}
	
	@RequestMapping("getCompAddrList")
	public ModelMap getCompAddrList(ModelMap model, @ModelAttribute("compAddrDto") CompAddrDto compAddrDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(compAddrDto.getPage())));
		pageRequestVo.setRows(compAddrDto.getRows());
		try {
			setModelWithkendoList(model, compMgtService.getCompAddrList(compAddrDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("업체 조회 에러  : " + ex.getMessage());
		}
		return model;
	}

	@RequestMapping("/setCompAddrSave")
	@ResponseBody
	public String setCompAddrSave(@RequestBody CompAddrDto compAddrDto) {
		return compMgtService.setCompAddrSave(compAddrDto);
	}

	@RequestMapping("/setCompAddrDelete")
	@ResponseBody
	public int setCompAddrDelete(ModelMap model, @RequestBody List<CompAddrDto> compAddrList) {
		return compMgtService.setCompAddrDelete(compAddrList);
	}

	@RequestMapping("/getAllCompList")
	public ModelMap getAllCompList(@ModelAttribute CompMgtDto compMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", compMgtService.getAllCompList(compMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("업체 전체 목록 조회 에러  : " + ex.getMessage());
		}
		return model;
	}



}
