package jin.mes.form.qualMgt.qualCheckList;


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
@RequestMapping("/form/qualMgt/qualCheckList")
public class QualCheckListController extends BaseController {
	
	@Autowired
	QualCheckListService qualCheckListService;
	
	@RequestMapping("/selectCheckListHistory")
	public ModelMap selectCheckListHistory(@ModelAttribute("qualCheckListDto") QualCheckListDto qualCheckListDto, ModelMap model) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(qualCheckListDto.getPage())));
		pageRequestVo.setRows(qualCheckListDto.getRows());
		try {
			setModelWithkendoList(model, qualCheckListService.selectCheckListHistory(qualCheckListDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("selectCheckListHistory : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/selectCheckList")
	public ModelMap selectCheckList(@ModelAttribute("qualCheckListDto") QualCheckListDto qualCheckListDto, ModelMap model) {
		try {
			model.addAttribute("rows", qualCheckListService.selectCheckList(qualCheckListDto));
		}catch(Exception ex) {
			throw new BusinessException("selectCheckList " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/insertCheckList")
	@ResponseBody
	public void insertCheckList(@RequestBody QualCheckListDto qualCheckListDto) {
		qualCheckListService.insertCheckList(qualCheckListDto);
	}
	
	@RequestMapping("/updateCheckList")
	@ResponseBody
	public void updateCheckList(@RequestBody QualCheckListDto qualCheckListDto) {
		qualCheckListService.updateCheckList(qualCheckListDto);
	}
}
