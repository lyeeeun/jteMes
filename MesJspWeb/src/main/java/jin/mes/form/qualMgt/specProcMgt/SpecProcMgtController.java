package jin.mes.form.qualMgt.specProcMgt;

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
@RequestMapping("/form/qualMgt/specProcMgt")
public class SpecProcMgtController extends BaseController {

	@Autowired
	SpecProcMgtService specProcMgtService;
	
	@RequestMapping("getSpcList")
	public ModelMap getSpcList (ModelMap model, @ModelAttribute("specProcMgtDto") SpecProcMgtDto specProcMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(specProcMgtDto.getPage())));
		pageRequestVo.setRows(specProcMgtDto.getRows());
		try {
			setModelWithkendoList(model, specProcMgtService.getSpcList(specProcMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	
	@RequestMapping("/setSpcSave")
	@ResponseBody
	public String setSpcSave(@RequestBody SpecProcMgtDto specProcMgtDto) {
		return specProcMgtService.setSpcSave(specProcMgtDto);
	}
	
	@RequestMapping("/setSpcDelete")
	@ResponseBody
	public int setSpcDelete (ModelMap model, @RequestBody List<SpecProcMgtDto> spcList) {
		return specProcMgtService.setSpcDelete(spcList);
	}
	
	@RequestMapping("getSpcUserList")
	public ModelMap getSpcUserList(ModelMap model, @ModelAttribute("specProcMgtDto") SpecProcUserDto specProcUserDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(specProcUserDto.getPage())));
		pageRequestVo.setRows(specProcUserDto.getRows());
		try {
			setModelWithkendoList(model, specProcMgtService.getSpcUserList(specProcUserDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("팀원 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("/setSpcUserSave")
	@ResponseBody
	public String setSpcUserSave(@RequestBody SpecProcUserDto specProcUserDto) {
		return specProcMgtService.setSpcUserSave(specProcUserDto);
	}
	
	@RequestMapping("/setSpcUserDelete")
	@ResponseBody
	public int setSpcUserDelete (ModelMap model, @RequestBody List<SpecProcUserDto> spcUserList) {
		return specProcMgtService.setSpcUserDelete(spcUserList);
	}
	
	public ModelMap getAllSpcList(@ModelAttribute SpecProcMgtDto specProcMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", specProcMgtService.getAllSpcList(specProcMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("전체 목록 조회 에러  : " + ex.getMessage());
		}
		return model;
	}


}
