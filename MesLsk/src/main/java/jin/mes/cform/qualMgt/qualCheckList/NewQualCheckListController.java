package jin.mes.cform.qualMgt.qualCheckList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.routing.routingMgt.NewRoutingMgtDto;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.qualMgt.qualPec.inputQualMgt.NewInputQualMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/qualCheckList")
public class NewQualCheckListController extends BaseController {
	
	@Autowired
	NewQualCheckListService newQualCheckListService;
	
	@RequestMapping("/selectCheckListHistory")
	public ModelMap selectCheckListHistory(@ModelAttribute("newQualCheckListDto") NewQualCheckListDto newQualCheckListDto, ModelMap model) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newQualCheckListDto.getPage())));
		pageRequestVo.setRows(newQualCheckListDto.getRows());
		try {
			setModelWithkendoList(model, newQualCheckListService.selectCheckListHistory(newQualCheckListDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("selectCheckListHistory : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/selectCheckList")
	public ModelMap selectCheckList(@ModelAttribute("newQualCheckListDto") NewQualCheckListDto newQualCheckListDto, ModelMap model) {
		try {
			model.addAttribute("rows", newQualCheckListService.selectCheckList(newQualCheckListDto));
		}catch(Exception ex) {
			throw new BusinessException("selectCheckList " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/insertCheckList")
	@ResponseBody
	public void insertCheckList(@RequestBody NewQualCheckListDto newQualCheckListDto) {
		newQualCheckListService.insertCheckList(newQualCheckListDto);
	}
	
	@RequestMapping("/updateCheckList")
	@ResponseBody
	public void updateCheckList(@RequestBody NewQualCheckListDto newQualCheckListDto) {
		newQualCheckListService.updateCheckList(newQualCheckListDto);
	}
}
