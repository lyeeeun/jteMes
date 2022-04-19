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
public class KwangjinPerformItemController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(KwangjinPerformItemController.class);

	@Resource
	protected KwangjinPerformItemService kwangjinPerformItemService;
	
	@RequestMapping("/getPerformItem")
	public ModelMap getPerformOrderInfo(@ModelAttribute("kwangjinPerformItemDto") KwangjinPerformItemDto kwangjinPerformItemDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinPerformItemDto.getPage())));
		pageRequestVo.setRows(kwangjinPerformItemDto.getRows());

		setModelWithkendoList(model, kwangjinPerformItemService.getPerformItem(kwangjinPerformItemDto, pageRequestVo));

		return model;
	}
	
	
	@RequestMapping("/selectKpiDefect")
	public ModelMap selectKpi(@ModelAttribute("kwangjinPerformItemDto") KwangjinPerformItemDto kwangjinPerformItemDto, ModelMap model) {
		model.addAttribute("rows", kwangjinPerformItemService.selectKpiDefect(kwangjinPerformItemDto));

		return model;
	}
}
