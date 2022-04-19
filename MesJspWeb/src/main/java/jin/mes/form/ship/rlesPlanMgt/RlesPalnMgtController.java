package jin.mes.form.ship.rlesPlanMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/ship/rlesPlanMgt")
public class RlesPalnMgtController extends BaseController {
	@Resource
	protected RlesPlanMgtService rlesPlanMgtService;

	@RequestMapping("/getPackagePlanList")
	public ModelMap getPackagePlanList(@ModelAttribute("rlesPlanMgtDto") RlesPlanMgtDto rlesPlanMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesPlanMgtDto.getPage())));
		pageRequestVo.setRows(rlesPlanMgtDto.getRows());

		setModelWithkendoList(model, rlesPlanMgtService.getPackagePlanList(rlesPlanMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getPackageAgg")
	@ResponseBody
	public ModelMap getPackageAgg(@RequestBody RlesPlanMgtDto rlesPlanMgtDto, ModelMap model) {
		model.addAttribute("rows", rlesPlanMgtService.getPackageAgg(rlesPlanMgtDto));

		return model;
	}
	
	@RequestMapping("/setPackagePlanList")
	@ResponseBody
	public void setPackagePlanList(@RequestBody RlesPlanMgtDto rlesPlanMgtDto) {
		rlesPlanMgtService.setPackagePlanList(rlesPlanMgtDto);
	}
	
	@RequestMapping("/updatePackagePlan")
	@ResponseBody
	public void updatePackagePlan(@RequestBody RlesPlanMgtDto rlesPlanMgtDto) {
		rlesPlanMgtService.updatePackagePlan(rlesPlanMgtDto);
	}

	@RequestMapping("/deletePackagePlan")
	@ResponseBody
	public void deletePackagePlan(@RequestBody List<RlesPlanMgtDto> rlesPlanList) {
		rlesPlanMgtService.deletePackagePlan(rlesPlanList);
	}
	
}