package jin.mes.cform.ship.rlesPlanMgt;

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
@RequestMapping("/cform/ship/rlesPlanMgt")
public class NewRlesPalnMgtController extends BaseController {
	@Resource
	protected NewRlesPlanMgtService newRlesPlanMgtService;

	@RequestMapping("/getPackagePlanList")
	public ModelMap getPackagePlanList(@ModelAttribute("rlesPlanMgtDto") NewRlesPlanMgtDto rlesPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesPlanMgtDto.getPage())));
		pageRequestVo.setRows(rlesPlanMgtDto.getRows());

		setModelWithkendoList(model, newRlesPlanMgtService.getPackagePlanList(rlesPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getPackageAgg")
	@ResponseBody
	public ModelMap getPackageAgg(@RequestBody NewRlesPlanMgtDto rlesPlanMgtDto, ModelMap model) {
		model.addAttribute("rows", newRlesPlanMgtService.getPackageAgg(rlesPlanMgtDto));

		return model;
	}
	
	@RequestMapping("/setPackagePlanList")
	@ResponseBody
	public void setPackagePlanList(@RequestBody NewRlesPlanMgtDto rlesPlanMgtDto) {
		newRlesPlanMgtService.setPackagePlanList(rlesPlanMgtDto);
	}
	
	@RequestMapping("/updatePackagePlan")
	@ResponseBody
	public void updatePackagePlan(@RequestBody NewRlesPlanMgtDto rlesPlanMgtDto) {
		newRlesPlanMgtService.updatePackagePlan(rlesPlanMgtDto);
	}

	@RequestMapping("/deletePackagePlan")
	@ResponseBody
	public void deletePackagePlan(@RequestBody List<NewRlesPlanMgtDto> rlesPlanList) {
		newRlesPlanMgtService.deletePackagePlan(rlesPlanList);
	}
	
}
