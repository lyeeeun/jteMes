package jin.mes.cform.qualMgt.qualCheckList;


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
@RequestMapping("/cform/qualMgt/qualCheckList")
public class KwangjinQualCheckListController extends BaseController {
	
	@Autowired
	KwangjinQualCheckListService kwangjinQualCheckListService;
	
	@RequestMapping("/selectCheckListHistory")
	public ModelMap selectCheckListHistory(@ModelAttribute("kwangjinQualCheckListDto") KwangjinQualCheckListDto kwangjinQualCheckListDto, ModelMap model) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinQualCheckListDto.getPage())));
		pageRequestVo.setRows(kwangjinQualCheckListDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinQualCheckListService.selectCheckListHistory(kwangjinQualCheckListDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("selectCheckListHistory : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/selectCheckList")
	public ModelMap selectCheckList(@ModelAttribute("kwangjinQualCheckListDto") KwangjinQualCheckListDto kwangjinQualCheckListDto, ModelMap model) {
		try {
			model.addAttribute("rows", kwangjinQualCheckListService.selectCheckList(kwangjinQualCheckListDto));
		}catch(Exception ex) {
			throw new BusinessException("selectCheckList " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/insertCheckList")
	@ResponseBody
	public void insertCheckList(@RequestBody KwangjinQualCheckListDto kwangjinQualCheckListDto) {
		kwangjinQualCheckListService.insertCheckList(kwangjinQualCheckListDto);
	}
	
	@RequestMapping("/updateCheckList")
	@ResponseBody
	public void updateCheckList(@RequestBody KwangjinQualCheckListDto kwangjinQualCheckListDto) {
		kwangjinQualCheckListService.updateCheckList(kwangjinQualCheckListDto);
	}
}
