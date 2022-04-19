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
public class KwangjinItemMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(KwangjinItemMgtController.class);

	@Resource
	protected KwangjinItemMgtService kwangjinItemMgtService;
	
//	@PreAuthorize(("hasAuthority('auth.basMgt.codeMgt.bas')"))
	@RequestMapping("/getItemList")
	public ModelMap getItemList(@ModelAttribute("kwangjinItemMgtDto") KwangjinItemMgtDto kwangjinItemMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinItemMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinItemMgtDto.getRows());

		setModelWithkendoList(model, kwangjinItemMgtService.getItemList(kwangjinItemMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getItemPop")
	public ModelMap getItemPop(@ModelAttribute("kwangjinItemMgtDto") KwangjinItemMgtDto kwangjinItemMgtDto, ModelMap model) {

		model.addAttribute("rows", kwangjinItemMgtService.getItemPop(kwangjinItemMgtDto));

		return model;
	}
	

	@RequestMapping("/getRtlCompList")
	public ModelMap getRtlCompList(@ModelAttribute("kwangjinItemMgtDto") KwangjinItemMgtDto kwangjinItemMgtDto, ModelMap model) {
		model.addAttribute("result", kwangjinItemMgtService.getRtlCompList(kwangjinItemMgtDto));

		return model;
	}
	
	@RequestMapping("/setItem")
	@ResponseBody
	public String setItem(@RequestBody KwangjinItemMgtDto kwangjinItemMgtDto) {
		return kwangjinItemMgtService.setItem(kwangjinItemMgtDto); 
	}
	
	@RequestMapping("/updateItem")
	@ResponseBody
	public void updateItem(@RequestBody KwangjinItemMgtDto kwangjinItemMgtDto) {
		kwangjinItemMgtService.updateItem(kwangjinItemMgtDto); 
	}
	
	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(@RequestBody KwangjinItemMgtDto kwangjinItemMgtDto) {
		kwangjinItemMgtService.updateIsUse(kwangjinItemMgtDto); 
	}
	
	@RequestMapping("/selectKpi")
	public ModelMap selectKpi(@ModelAttribute("kwangjinItemMgtDto") KwangjinItemMgtDto kwangjinItemMgtDto, ModelMap model) {
		model.addAttribute("rows", kwangjinItemMgtService.selectKpi(kwangjinItemMgtDto));

		return model;
	}
	

}
