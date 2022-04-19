package jin.mes.form.perform.processProgress;

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
@RequestMapping("/form/perform/processProgress")
public class ProcessProgressController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ProcessProgressController.class);

	@Resource
	protected ProcessProgressService processProgressService;
	
	@RequestMapping("/getPerformItem")
	public ModelMap getPerformOrderInfo(@ModelAttribute("performItemDto") ProcessProgressDto processProgressDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(processProgressDto.getPage())));
		pageRequestVo.setRows(processProgressDto.getRows());

		setModelWithkendoList(model, processProgressService.getPerformItem(processProgressDto, pageRequestVo));

		return model;
	}
	
	
	@RequestMapping("/selectKpiDefect")
	public ModelMap selectKpi(@ModelAttribute("performItemDto") ProcessProgressDto processProgressDto, ModelMap model) {
		model.addAttribute("rows", processProgressService.selectKpiDefect(processProgressDto));

		return model;
	}
}
