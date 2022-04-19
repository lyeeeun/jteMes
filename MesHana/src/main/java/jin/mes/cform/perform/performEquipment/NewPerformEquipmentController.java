package jin.mes.cform.perform.performEquipment;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import jin.mes.cform.basMgt.operMgt.rlehoMgt.NewRlehoMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/perform/performEquipment")
public class NewPerformEquipmentController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewPerformEquipmentController.class);

	@Resource
	protected NewPerformEquipmentService newPerformEquipmentService;

	@RequestMapping("/getPerfromEquipInfo")
	public ModelMap getPerfromEquipInfo(@ModelAttribute("newPerformEquipmentDto") NewPerformEquipmentDto newPerformEquipmentDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newPerformEquipmentDto.getPage())));
		pageRequestVo.setRows(newPerformEquipmentDto.getRows());

		setModelWithkendoList(model, newPerformEquipmentService.getPerfromEquipInfo(newPerformEquipmentDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectPlaceAll")
	public ModelMap getPerformOrderChart(@ModelAttribute("newRlehoMgtDto") NewRlehoMgtDto newRlehoMgtDto, ModelMap model) {
		model.addAttribute("rows", newPerformEquipmentService.selectPlaceAll());

		return model;
	}
}
