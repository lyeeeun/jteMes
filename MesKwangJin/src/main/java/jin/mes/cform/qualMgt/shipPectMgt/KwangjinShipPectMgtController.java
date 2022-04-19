package jin.mes.cform.qualMgt.shipPectMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.pick.rlesMgt.RlesMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/qualMgt/shipPectMgt")
public class KwangjinShipPectMgtController extends BaseController {

	@Autowired
	KwangjinShipPectMgtService kwangjinShipPectMgtService;
	
	@RequestMapping("/getPackageBadList")
	public ModelMap getPackageBadList(@ModelAttribute("rlesMgtDto") RlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, kwangjinShipPectMgtService.getPackageBadList(rlesMgtDto, pageRequestVo));

		return model;
	}
}
