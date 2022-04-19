package jin.mes.cform.basMgt.operMgt.itemMgt;

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
@RequestMapping("/cform/basMgt/operMgt/itemMgt")
public class ZinixItemMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(ZinixItemMgtController.class);

	@Resource
	protected ZinixItemMgtService zinixItemMgtService;
	
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getItemList")
	public ModelMap getItemList(@ModelAttribute("ZinixItemMgtDto") ZinixItemMgtDto itemMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemMgtDto.getPage())));
		pageRequestVo.setRows(itemMgtDto.getRows());

		setModelWithkendoList(model, zinixItemMgtService.getItemList(itemMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getItemPop")
	public ModelMap getItemPop(@ModelAttribute("ZinixItemMgtDto") ZinixItemMgtDto itemMgtDto, ModelMap model) {

		model.addAttribute("rows", zinixItemMgtService.getItemPop(itemMgtDto));

		return model;
	}
	

	@RequestMapping("/getRtlCompList")
	public ModelMap getRtlCompList(@ModelAttribute("ZinixItemMgtDto") ZinixItemMgtDto itemMgtDto, ModelMap model) {
		model.addAttribute("result", zinixItemMgtService.getRtlCompList(itemMgtDto));

		return model;
	}
	
	@RequestMapping("/setItem")
	@ResponseBody
	public String setItem(@RequestBody ZinixItemMgtDto itemMgtDto) {
		return zinixItemMgtService.setItem(itemMgtDto); 
	}
	
	@RequestMapping("/updateItem")
	@ResponseBody
	public void updateItem(@RequestBody ZinixItemMgtDto itemMgtDto) {
		zinixItemMgtService.updateItem(itemMgtDto); 
	}
	
	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(@RequestBody ZinixItemMgtDto itemMgtDto) {
		zinixItemMgtService.updateIsUse(itemMgtDto); 
	}
	
	@RequestMapping("/selectKpi")
	public ModelMap selectKpi(@ModelAttribute("ZinixItemMgtDto") ZinixItemMgtDto itemMgtDto, ModelMap model) {
		model.addAttribute("rows", zinixItemMgtService.selectKpi(itemMgtDto));

		return model;
	}
	

}
