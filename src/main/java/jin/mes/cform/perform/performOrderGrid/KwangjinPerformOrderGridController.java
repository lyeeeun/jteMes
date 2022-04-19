package jin.mes.cform.perform.performOrderGrid;

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
@RequestMapping("/cform/perform/performOrderGrid")
public class KwangjinPerformOrderGridController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(KwangjinPerformOrderGridController.class);

	@Resource
	protected KwangjinPerformOrderGridService kwangjinPerformOrderGridService;

	@RequestMapping("/getPerformOrder")
	public ModelMap getPerformOrderInfo(@ModelAttribute("kwangjinPerformOrderGridDto") KwangjinPerformOrderGridDto kwangjinPerformOrderGridDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinPerformOrderGridDto.getPage())));
		pageRequestVo.setRows(kwangjinPerformOrderGridDto.getRows());

		setModelWithkendoList(model, kwangjinPerformOrderGridService.getPerformOrder(kwangjinPerformOrderGridDto, pageRequestVo));

		return model;
	}

	@RequestMapping("/getLotDetail")
	public ModelMap getLotDetail(@ModelAttribute("kwangjinPerformOrderGridDto") KwangjinPerformOrderGridDto kwangjinPerformOrderGridDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinPerformOrderGridDto.getPage())));
		pageRequestVo.setRows(kwangjinPerformOrderGridDto.getRows());

		setModelWithkendoList(model, kwangjinPerformOrderGridService.getLotDetail(kwangjinPerformOrderGridDto, pageRequestVo));

		return model;
	}
}
