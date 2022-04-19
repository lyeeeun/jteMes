package jin.mes.cform.perform.processProgress;

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
@RequestMapping("/cform/perform/processProgress")
public class KwangjinProcessProgressController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(KwangjinProcessProgressController.class);

	@Resource
	protected KwangjinProcessProgressService kwangjinProcessProgressService;
	
	@RequestMapping("/getPerformItem")
	public ModelMap getPerformOrderInfo(@ModelAttribute("kwangjinProcessProgressDto") KwangjinProcessProgressDto kwangjinProcessProgressDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinProcessProgressDto.getPage())));
		pageRequestVo.setRows(kwangjinProcessProgressDto.getRows());

		setModelWithkendoList(model, kwangjinProcessProgressService.getPerformItem(kwangjinProcessProgressDto, pageRequestVo));

		return model;
	}
	
	
	@RequestMapping("/selectKpiDefect")
	public ModelMap selectKpi(@ModelAttribute("kwangjinProcessProgressDto") KwangjinProcessProgressDto kwangjinProcessProgressDto, ModelMap model) {
		model.addAttribute("rows", kwangjinProcessProgressService.selectKpiDefect(kwangjinProcessProgressDto));

		return model;
	}
}
