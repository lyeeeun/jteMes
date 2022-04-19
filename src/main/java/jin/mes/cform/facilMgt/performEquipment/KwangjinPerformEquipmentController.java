package jin.mes.cform.facilMgt.performEquipment;

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
@RequestMapping("/cform/facilMgt/performEquipment")
public class KwangjinPerformEquipmentController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(KwangjinPerformEquipmentController.class);

	@Resource
	protected KwangjinPerformEquipmentService kwangjinPerformEquipmentService;

	@RequestMapping("/getPerfromEquipInfo")
	public ModelMap getPerfromEquipInfo(@ModelAttribute("kwangjinPerformEquipmentDto") KwangjinPerformEquipmentDto kwangjinPerformEquipmentDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinPerformEquipmentDto.getPage())));
		pageRequestVo.setRows(kwangjinPerformEquipmentDto.getRows());

		setModelWithkendoList(model, kwangjinPerformEquipmentService.getPerfromEquipInfo(kwangjinPerformEquipmentDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectPlaceAll")
	public ModelMap getPerformOrderChart(@ModelAttribute("rlehoMgtDto") RlehoMgtDto rlehoMgtDto, ModelMap model) {
		model.addAttribute("rows", kwangjinPerformEquipmentService.selectPlaceAll());

		return model;
	}
}
