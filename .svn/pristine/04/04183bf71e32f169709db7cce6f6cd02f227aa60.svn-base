package jin.mes.form.perform.facilStaMgt.performEquipment;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/perform/facilStaMgt/performEquipment")
public class PerformEquipmentController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(PerformEquipmentController.class);

	@Resource
	protected PerformEquipmentService performEquipmentService;

	@RequestMapping("/getPerfromEquipInfo")
	public ModelMap getPerfromEquipInfo(@ModelAttribute("performEquipmentDto") PerformEquipmentDto performEquipmentDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(performEquipmentDto.getPage())));
		pageRequestVo.setRows(performEquipmentDto.getRows());

		setModelWithkendoList(model, performEquipmentService.getPerfromEquipInfo(performEquipmentDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectPlaceAll")
	public ModelMap getPerformOrderChart(@ModelAttribute("rlehoMgtDto") RlehoMgtDto rlehoMgtDto, ModelMap model) {
		model.addAttribute("rows", performEquipmentService.selectPlaceAll());

		return model;
	}
}
