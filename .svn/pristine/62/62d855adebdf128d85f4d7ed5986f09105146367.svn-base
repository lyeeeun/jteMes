package jin.mes.cform.qualMgt.qualPec.autoQualMgt;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/qualPec/autoQualMgt")
public class NewAutoQualMgtController extends BaseController {

	@Autowired
	NewAutoQualMgtService newAutoQualMgtService;
	

	@RequestMapping("/selectAutoInspInfo")
	public ModelMap selectAutoInspInfo(@ModelAttribute("autoQualMgtDto") NewAutoQualMgtDto autoQualMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(autoQualMgtDto.getPage())));
		pageRequestVo.setRows(autoQualMgtDto.getRows());

		setModelWithkendoList(model, newAutoQualMgtService.selectAutoInspInfo(autoQualMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectInspItemList")
	public ModelMap selectInspItemList(@ModelAttribute("autoQualMgtDto") NewAutoQualMgtDto autoQualMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", newAutoQualMgtService.selectInspItemList(autoQualMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectInspItemList " + ex.getMessage());
		}
		return model;
	}
	
}
