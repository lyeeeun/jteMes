package jin.mes.form.perform.performItem;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/perform/performItem")
public class PerformItemController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(PerformItemController.class);

	@Resource
	protected PerformItemService performItemService;
	
	@RequestMapping("/getPerformItem")
	public ModelMap getPerformOrderInfo(@ModelAttribute("performItemDto") PerformItemDto performItemDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(performItemDto.getPage())));
		pageRequestVo.setRows(performItemDto.getRows());

		setModelWithkendoList(model, performItemService.getPerformItem(performItemDto, pageRequestVo));

		return model;
	}
	
	
	@RequestMapping("/selectKpiDefect")
	public ModelMap selectKpi(@ModelAttribute("performItemDto") PerformItemDto performItemDto, ModelMap model) {
		model.addAttribute("rows", performItemService.selectKpiDefect(performItemDto));

		return model;
	}
}
