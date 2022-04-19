package jin.mes.form.perform.prodStaMgt.facilProdMgt;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/perform/prodStaMgt/facilProdMgt")
public class FacilProdMgtController extends BaseController {
	@Resource
	FacilProdMgtService facilProdMgtService;
	
	@RequestMapping("/getEqmtProd")
	public ModelMap getEqmtProd(@ModelAttribute("facilProdMgtDto") FacilProdMgtDto facilProdMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(facilProdMgtDto.getPage())));
		pageRequestVo.setRows(facilProdMgtDto.getRows());

		setModelWithkendoList(model, facilProdMgtService.getEqmtProd(facilProdMgtDto, pageRequestVo));

		return model;
	}
}
