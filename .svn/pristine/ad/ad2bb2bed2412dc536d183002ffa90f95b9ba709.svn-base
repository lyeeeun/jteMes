package jin.mes.cform.perform.performOrderGrid;

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
@RequestMapping("/cform/perform/performOrderGrid")
public class NewPerformOrderGridController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewPerformOrderGridController.class);

	@Resource
	protected NewPerformOrderGridService newPerformOrderGridService;

	@RequestMapping("/getPerformOrder")
	public ModelMap getPerformOrderInfo(@ModelAttribute("performOrderGridDto") NewPerformOrderGridDto performOrderGridDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(performOrderGridDto.getPage())));
		pageRequestVo.setRows(performOrderGridDto.getRows());

		setModelWithkendoList(model, newPerformOrderGridService.getPerformOrder(performOrderGridDto, pageRequestVo));

		return model;
	}

	@RequestMapping("/getLotDetail")
	public ModelMap getLotDetail(@ModelAttribute("performOrderGridDto") NewPerformOrderGridDto performOrderGridDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(performOrderGridDto.getPage())));
		pageRequestVo.setRows(performOrderGridDto.getRows());

		setModelWithkendoList(model, newPerformOrderGridService.getLotDetail(performOrderGridDto, pageRequestVo));

		return model;
	}
}
