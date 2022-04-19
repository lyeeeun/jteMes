package jin.mes.form.perform.prodStaMgt.workProdStaMgt;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/perform/prodStaMgt/workProdStaMgt")
public class WorkProdStaMgtController extends BaseController {
	@Resource
	WorkProdStaMgtService workProdStaMgtService;
	
	@RequestMapping("/getWorkProd")
	public ModelMap getWorkProd(@ModelAttribute("workProdStaMgtDto") WorkProdStaMgtDto workProdStaMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(workProdStaMgtDto.getPage())));
		pageRequestVo.setRows(workProdStaMgtDto.getRows());

		setModelWithkendoList(model, workProdStaMgtService.getWorkProd(workProdStaMgtDto, pageRequestVo));

		return model;
	}
}
