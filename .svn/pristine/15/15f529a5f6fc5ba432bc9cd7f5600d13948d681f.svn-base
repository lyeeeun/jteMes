package jin.mes.form.ship.rlesMgt;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.orderMgt.claimMgt.ClaimMgtDto;
import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/ship/rlesMgt")
public class RlesMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(RlesMgtController.class);

	@Resource
	protected RlesMgtService rlesMgtService;

	@RequestMapping("/getPackageList")
	public ModelMap getPackageList(@ModelAttribute("rlesMgtDto") RlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, rlesMgtService.getPackageList(rlesMgtDto, pageRequestVo));

		return model;
	}
	

	@RequestMapping("/getPackageWorkList")
	public ModelMap getPackageWorkList(@ModelAttribute("rlesMgtDto") RlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, rlesMgtService.getPackageWorkList(rlesMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getPackagePlanList")
	public ModelMap getPackagePlanList(@ModelAttribute("rlesMgtDto") RlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, rlesMgtService.getPackagePlanList(rlesMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getRtlBundleList")
	public ModelMap getPerformTotalOrderChart(@ModelAttribute("rlesMgtDto") RlesMgtDto rlesMgtDto, ModelMap model) {
		model.addAttribute("rows", rlesMgtService.getRtlBundleList(rlesMgtDto));

		return model;
	}
	
	
	@RequestMapping("/setPackageWorkList")
	@ResponseBody
	public String setPackageWorkList(@RequestBody RlesMgtDto rlesMgtDto) {
		return rlesMgtService.setPackageWorkList(rlesMgtDto);
	}
	
	@RequestMapping("/delPackageWorkList")
	@ResponseBody
	public int delPackageWorkList(@RequestBody List<RlesMgtDto> rlesMgtDtoList) {
		return rlesMgtService.delPackageWorkList(rlesMgtDtoList);
	}
	
	@RequestMapping("/updatePkgPlanState")
	@ResponseBody
	public void updatePkgPlanState(@RequestBody RlesMgtDto rlesMgtDto) {
		rlesMgtService.updatePkgPlanState(rlesMgtDto);
	}
}
