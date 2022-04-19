package jin.mes.cform.perform.prodBadSta;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/perform/prodBadSta")
public class KwangjinProdBadStaController extends BaseController {

	@Resource
	protected KwangjinProdBadStaService kwangjinProdBadStaService;

	@RequestMapping("/getProdBad")
	public ModelMap getProdBad(@ModelAttribute("kwangjinProdBadStaDto") KwangjinProdBadStaDto kwangjinProdBadStaDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinProdBadStaDto.getPage())));
		pageRequestVo.setRows(kwangjinProdBadStaDto.getRows());

		setModelWithkendoList(model, kwangjinProdBadStaService.getProdBad(kwangjinProdBadStaDto, pageRequestVo));

		return model;
	}
}
