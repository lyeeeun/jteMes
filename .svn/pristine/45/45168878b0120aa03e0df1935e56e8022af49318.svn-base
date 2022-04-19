package jin.mes.cform.ship.rlesMgt;

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

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/ship/rlesMgt")
public class NewRlesMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewRlesMgtController.class);

	@Resource
	protected NewRlesMgtService newRlesMgtService;

	@RequestMapping("/getPackageList")
	public ModelMap getPackageList(@ModelAttribute("rlesMgtDto") NewRlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, newRlesMgtService.getPackageList(rlesMgtDto, pageRequestVo));

		return model;
	}
	

	@RequestMapping("/getPackageWorkList")
	public ModelMap getPackageWorkList(@ModelAttribute("rlesMgtDto") NewRlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, newRlesMgtService.getPackageWorkList(rlesMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getPackagePlanList")
	public ModelMap getPackagePlanList(@ModelAttribute("rlesMgtDto") NewRlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, newRlesMgtService.getPackagePlanList(rlesMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/setPackageWorkList")
	@ResponseBody
	public String setPackageWorkList(@RequestBody NewRlesMgtDto rlesMgtDto) {
		return newRlesMgtService.setPackageWorkList(rlesMgtDto);
	}
	
	@RequestMapping("/delPackageWorkList")
	@ResponseBody
	public int delPackageWorkList(@RequestBody List<NewRlesMgtDto> rlesMgtDtoList) {
		return newRlesMgtService.delPackageWorkList(rlesMgtDtoList);
	}
	
	@RequestMapping("/updatePkgPlanState")
	@ResponseBody
	public void updatePkgPlanState(@RequestBody NewRlesMgtDto rlesMgtDto) {
		newRlesMgtService.updatePkgPlanState(rlesMgtDto);
	}
}
