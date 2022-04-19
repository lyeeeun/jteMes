package jin.mes.cform.item.itemToolMgt;

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
@RequestMapping("/cform/item/itemToolMgt")
public class NewItemToolMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewItemToolMgtController.class);

	@Resource
	protected NewItemToolMgtService newItemToolMgtService;
	
	@RequestMapping("/getRtlEqmtList")
	public ModelMap getRtlEqmtList(@ModelAttribute("itemToolMgtDto") NewItemToolMgtDto itemToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemToolMgtDto.getPage())));
		pageRequestVo.setRows(itemToolMgtDto.getRows());

		setModelWithkendoList(model, newItemToolMgtService.getRtlEqmtList(itemToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getRtlToolList")
	public ModelMap getRtlToolList(@ModelAttribute("itemToolMgtDto") NewItemToolMgtDto itemToolMgtDto, ModelMap model) {
		model.addAttribute("result", newItemToolMgtService.getRtlToolList(itemToolMgtDto));

		return model;
	}
	
	@RequestMapping("/updateRtlTool")
	@ResponseBody
	public void updateRtlTool(@RequestBody NewItemToolMgtDto itemToolMgtDto) {
		newItemToolMgtService.updateRtlTool(itemToolMgtDto); 
	}
}
