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
public class ZinixProcessProgressController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ZinixProcessProgressController.class);

	@Resource
	protected ZinixProcessProgressService zinixProcessProgressService;
	
	@RequestMapping("/getPerformItem")
	public ModelMap getPerformOrderInfo(@ModelAttribute("performItemDto") ZinixProcessProgressDto zinixProcessProgressDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixProcessProgressDto.getPage())));
		pageRequestVo.setRows(zinixProcessProgressDto.getRows());

		setModelWithkendoList(model, zinixProcessProgressService.getPerformItem(zinixProcessProgressDto, pageRequestVo));

		return model;
	}
	
	
	@RequestMapping("/selectKpiDefect")
	public ModelMap selectKpi(@ModelAttribute("performItemDto") ZinixProcessProgressDto zinixProcessProgressDto, ModelMap model) {
		model.addAttribute("rows", zinixProcessProgressService.selectKpiDefect(zinixProcessProgressDto));

		return model;
	}
}
