package jin.mes.cform.qualMgt.specProcMgt;

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
@RequestMapping("/cform/qualMgt/specProcMgt")
public class NewSpecProcMgtController extends BaseController {

	@Autowired
	NewSpecProcMgtService newSpecProcMgtService;
	
	@RequestMapping("getSpcList")
	public ModelMap getSpcList (ModelMap model, @ModelAttribute("specProcMgtDto") NewSpecProcMgtDto specProcMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(specProcMgtDto.getPage())));
		pageRequestVo.setRows(specProcMgtDto.getRows());
		try {
			setModelWithkendoList(model, newSpecProcMgtService.getSpcList(specProcMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	
	@RequestMapping("/setSpcSave")
	@ResponseBody
	public String setSpcSave(@RequestBody NewSpecProcMgtDto specProcMgtDto) {
		return newSpecProcMgtService.setSpcSave(specProcMgtDto);
	}
	
	@RequestMapping("/setSpcDelete")
	@ResponseBody
	public int setSpcDelete (ModelMap model, @RequestBody List<NewSpecProcMgtDto> spcList) {
		return newSpecProcMgtService.setSpcDelete(spcList);
	}
	
	@RequestMapping("getSpcUserList")
	public ModelMap getSpcUserList(ModelMap model, @ModelAttribute("specProcMgtDto") NewSpecProcUserDto specProcUserDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(specProcUserDto.getPage())));
		pageRequestVo.setRows(specProcUserDto.getRows());
		try {
			setModelWithkendoList(model, newSpecProcMgtService.getSpcUserList(specProcUserDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("팀원 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("/setSpcUserSave")
	@ResponseBody
	public String setSpcUserSave(@RequestBody NewSpecProcUserDto specProcUserDto) {
		return newSpecProcMgtService.setSpcUserSave(specProcUserDto);
	}
	
	@RequestMapping("/setSpcUserDelete")
	@ResponseBody
	public int setSpcUserDelete (ModelMap model, @RequestBody List<NewSpecProcUserDto> spcUserList) {
		return newSpecProcMgtService.setSpcUserDelete(spcUserList);
	}
	
	public ModelMap getAllSpcList(@ModelAttribute NewSpecProcMgtDto specProcMgtDto, ModelMap model) {
		try {
			model.addAttribute("result", newSpecProcMgtService.getAllSpcList(specProcMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("전체 목록 조회 에러  : " + ex.getMessage());
		}
		return model;
	}


}
