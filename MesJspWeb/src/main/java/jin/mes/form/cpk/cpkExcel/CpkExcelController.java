package jin.mes.form.cpk.cpkExcel;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.cpk.cpkBase.CpkService;
import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/form/cpk/cpkExcel")
public class CpkExcelController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(CpkExcelController.class);

	@Resource
	protected CpkService cpkService;
	
	@RequestMapping("/getCpkOffset")
	public ModelMap getCpkOffset(@ModelAttribute CpkExcelDto cpkExcelDto, ModelMap model) {
		
		model.addAttribute("result", cpkService.getCpkList(cpkExcelDto));
		
		return model;
	}
	
	@RequestMapping("/getCpkAggregation")
	public ModelMap getCpkAggregation(@ModelAttribute CpkExcelDto cpkExcelDto, ModelMap model) {
		
		model.addAttribute("result", cpkService.getCpkAggregation(cpkExcelDto));
		
		return model;
	}
}
