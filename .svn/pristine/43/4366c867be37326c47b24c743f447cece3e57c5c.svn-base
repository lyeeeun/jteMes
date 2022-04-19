package jin.mes.form.perform.performOrderGrid;

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
@RequestMapping("/form/perform/performOrderGrid")
public class PerformOrderGridController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(PerformOrderGridController.class);

	@Resource
	protected PerformOrderGridService performOrderGridService;

	@RequestMapping("/getPerformOrder")
	public ModelMap getPerformOrderInfo(@ModelAttribute("performOrderGridDto") PerformOrderGridDto performOrderGridDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(performOrderGridDto.getPage())));
		pageRequestVo.setRows(performOrderGridDto.getRows());

		setModelWithkendoList(model, performOrderGridService.getPerformOrder(performOrderGridDto, pageRequestVo));

		return model;
	}

	@RequestMapping("/getLotDetail")
	public ModelMap getLotDetail(@ModelAttribute("performOrderGridDto") PerformOrderGridDto performOrderGridDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(performOrderGridDto.getPage())));
		pageRequestVo.setRows(performOrderGridDto.getRows());

		setModelWithkendoList(model, performOrderGridService.getLotDetail(performOrderGridDto, pageRequestVo));

		return model;
	}
}
