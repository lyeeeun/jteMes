package jin.mes.form.pick.rlesPlanMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/pick/rlesPlanMgt")
public class RlesPalnMgtController extends BaseController {
	@Resource
	protected RlesPlanMgtService rlesPlanMgtService;

	@RequestMapping("/getRlesPlanList")
	public ModelMap getRlesPlanList(@ModelAttribute("rlesPlanMgtDto") RlesPlanMgtDto rlesPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesPlanMgtDto.getPage())));
		pageRequestVo.setRows(rlesPlanMgtDto.getRows());

		setModelWithkendoList(model, rlesPlanMgtService.getRlesPlanList(rlesPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getLotStockList")
	public ModelMap getLotStockList(@ModelAttribute("rlesPlanMgtDto") RlesPlanMgtDto rlesPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesPlanMgtDto.getPage())));
		pageRequestVo.setRows(rlesPlanMgtDto.getRows());

		setModelWithkendoList(model, rlesPlanMgtService.getLotStockList(rlesPlanMgtDto, pageRequestVo));

		return model;
	}

	@RequestMapping("/setRlesPlanSave")
	@ResponseBody
	public String setRlesPlanSave(@RequestBody RlesPlanMgtDto rlesPlanMgtDto) {
		return rlesPlanMgtService.setRlesPlanSave(rlesPlanMgtDto);
	}


	@RequestMapping("/setRlesPlanDelete")
	@ResponseBody
	public String setRlesPlanDelete(@RequestBody List<RlesPlanMgtDto> rlesPlanList) {
		return rlesPlanMgtService.setRlesPlanDelete(rlesPlanList);
	}
	
}
