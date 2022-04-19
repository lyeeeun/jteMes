package jin.mes.cform.perform.performItem;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/perform/performItem")
public class NewPerformItemController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewPerformItemController.class);

	@Resource
	protected NewPerformItemService newPerformItemService;
	
	@RequestMapping("/getPerformItem")
	public ModelMap getPerformOrderInfo(@ModelAttribute("performItemDto") NewPerformItemDto performItemDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(performItemDto.getPage())));
		pageRequestVo.setRows(performItemDto.getRows());

		setModelWithkendoList(model, newPerformItemService.getPerformItem(performItemDto, pageRequestVo));

		return model;
	}
	
	
	@RequestMapping("/selectKpiDefect")
	public ModelMap selectKpi(@ModelAttribute("performItemDto") NewPerformItemDto performItemDto, ModelMap model) {
		model.addAttribute("rows", newPerformItemService.selectKpiDefect(performItemDto));

		return model;
	}
}
