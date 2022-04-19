package jin.mes.cform.qualMgt.qualPec.shipPectMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.ship.rlesMgt.NewRlesMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/qualMgt/qualPec/shipPectMgt")
public class NewShipPectMgtController extends BaseController {

	@Autowired
	NewShipPectMgtService newPackageBadService;
	
	@RequestMapping("/getPackageBadList")
	public ModelMap getPackageBadList(@ModelAttribute("rlesMgtDto") NewRlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, newPackageBadService.getPackageBadList(rlesMgtDto, pageRequestVo));

		return model;
	}
}
