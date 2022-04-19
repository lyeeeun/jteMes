package jin.mes.form.basMgt.operMgt.itemMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/basMgt/operMgt/itemMgt")
public class ItemMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemMgtController.class);

	@Resource
	protected ItemMgtService itemMgtService;
	
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getItemList")
	public ModelMap getItemList(@ModelAttribute("ItemMgtDto") ItemMgtDto itemMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemMgtDto.getPage())));
		pageRequestVo.setRows(itemMgtDto.getRows());

		setModelWithkendoList(model, itemMgtService.getItemList(itemMgtDto, pageRequestVo));

		return model;
	}

	@RequestMapping("/getRtlCompList")
	public ModelMap getRtlCompList(@ModelAttribute("ItemMgtDto") ItemMgtDto itemMgtDto, ModelMap model) {
		model.addAttribute("result", itemMgtService.getRtlCompList(itemMgtDto));

		return model;
	}
	
	@RequestMapping("/setItem")
	@ResponseBody
	public void setItem(@RequestBody ItemMgtDto itemMgtDto) {
		itemMgtService.setItem(itemMgtDto); 
	}
	
	@RequestMapping("/updateItem")
	@ResponseBody
	public void updateItem(@RequestBody ItemMgtDto itemMgtDto) {
		itemMgtService.updateItem(itemMgtDto); 
	}
	
	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(@RequestBody ItemMgtDto itemMgtDto) {
		itemMgtService.updateIsUse(itemMgtDto); 
	}
	
	@RequestMapping("/selectKpi")
	public ModelMap selectKpi(@ModelAttribute("ItemMgtDto") ItemMgtDto itemMgtDto, ModelMap model) {
		model.addAttribute("rows", itemMgtService.selectKpi(itemMgtDto));

		return model;
	}
	

}
