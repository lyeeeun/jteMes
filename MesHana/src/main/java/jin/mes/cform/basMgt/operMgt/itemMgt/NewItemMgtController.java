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
	public ModelMap getItemList(@ModelAttribute("NewItemMgtDto") NewItemMgtDto newItemMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newItemMgtDto.getPage())));
		pageRequestVo.setRows(newItemMgtDto.getRows());

		setModelWithkendoList(model, newItemMgtService.getItemList(newItemMgtDto, pageRequestVo));

		return model;
	}

	@RequestMapping("/getRtlCompList")
	public ModelMap getRtlCompList(@ModelAttribute("NewItemMgtDto") NewItemMgtDto newItemMgtDto, ModelMap model) {
		model.addAttribute("result", newItemMgtService.getRtlCompList(newItemMgtDto));

		return model;
	}
	
	@RequestMapping("/setItem")
	@ResponseBody
	public void setItem(@RequestBody NewItemMgtDto newItemMgtDto) {
		newItemMgtService.setItem(newItemMgtDto); 
	}
	
	@RequestMapping("/updateItem")
	@ResponseBody
	public void updateItem(@RequestBody NewItemMgtDto newItemMgtDto) {
		newItemMgtService.updateItem(newItemMgtDto); 
	}
	
	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(@RequestBody NewItemMgtDto newItemMgtDto) {
		newItemMgtService.updateIsUse(newItemMgtDto); 
	}
	
	@RequestMapping("/selectKpi")
	public ModelMap selectKpi(@ModelAttribute("NewItemMgtDto") NewItemMgtDto newItemMgtDto, ModelMap model) {
		model.addAttribute("rows", newItemMgtService.selectKpi(newItemMgtDto));

		return model;
	}
	

}