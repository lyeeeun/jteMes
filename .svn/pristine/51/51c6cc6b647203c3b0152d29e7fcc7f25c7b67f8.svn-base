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
public class NewItemMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(NewItemMgtController.class);

	@Resource
	protected NewItemMgtService newItemMgtService;
	
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getItemList")
	public ModelMap getItemList(@ModelAttribute("ItemMgtDto") NewItemMgtDto itemMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemMgtDto.getPage())));
		pageRequestVo.setRows(itemMgtDto.getRows());

		setModelWithkendoList(model, newItemMgtService.getItemList(itemMgtDto, pageRequestVo));

		return model;
	}

	@RequestMapping("/getRtlCompList")
	public ModelMap getRtlCompList(@ModelAttribute("ItemMgtDto") NewItemMgtDto itemMgtDto, ModelMap model) {
		model.addAttribute("result", newItemMgtService.getRtlCompList(itemMgtDto));

		return model;
	}
	
	@RequestMapping("/setItem")
	@ResponseBody
	public void setItem(@RequestBody NewItemMgtDto itemMgtDto) {
		newItemMgtService.setItem(itemMgtDto); 
	}
	
	@RequestMapping("/updateItem")
	@ResponseBody
	public void updateItem(@RequestBody NewItemMgtDto itemMgtDto) {
		newItemMgtService.updateItem(itemMgtDto); 
	}
	
	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(@RequestBody NewItemMgtDto itemMgtDto) {
		newItemMgtService.updateIsUse(itemMgtDto); 
	}
	
	@RequestMapping("/selectKpi")
	public ModelMap selectKpi(@ModelAttribute("ItemMgtDto") NewItemMgtDto itemMgtDto, ModelMap model) {
		model.addAttribute("rows", newItemMgtService.selectKpi(itemMgtDto));

		return model;
	}
	

}
