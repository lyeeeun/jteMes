package jin.mes.cform.cpk.cpkExcel;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.cpk.cpkBase.NewCpkService;
import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/cform/cpk/cpkExcel")
public class NewCpkExcelController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewCpkExcelController.class);

	@Resource
	protected NewCpkService newCpkService;
	
	@RequestMapping("/getCpkOffset")
	public ModelMap getCpkOffset(@ModelAttribute NewCpkExcelDto newCpkExcelDto, ModelMap model) {
		
		model.addAttribute("result", newCpkService.getCpkList(newCpkExcelDto));
		
		return model;
	}
	
	@RequestMapping("/getCpkAggregation")
	public ModelMap getCpkAggregation(@ModelAttribute NewCpkExcelDto newCpkExcelDto, ModelMap model) {
		
		model.addAttribute("result", newCpkService.getCpkAggregation(newCpkExcelDto));
		
		return model;
	}
}
