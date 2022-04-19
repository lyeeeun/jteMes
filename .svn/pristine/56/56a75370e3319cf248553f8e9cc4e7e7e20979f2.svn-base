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
	public ModelMap getRtlEqmtList(@ModelAttribute("newItemToolMgtDto") NewItemToolMgtDto newItemToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newItemToolMgtDto.getPage())));
		pageRequestVo.setRows(newItemToolMgtDto.getRows());

		setModelWithkendoList(model, newItemToolMgtService.getRtlEqmtList(newItemToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getRtlToolList")
	public ModelMap getRtlToolList(@ModelAttribute("newItemToolMgtDto") NewItemToolMgtDto newItemToolMgtDto, ModelMap model) {
		model.addAttribute("result", newItemToolMgtService.getRtlToolList(newItemToolMgtDto));

		return model;
	}
	
	@RequestMapping("/updateRtlTool")
	@ResponseBody
	public void updateRtlTool(@RequestBody NewItemToolMgtDto newItemToolMgtDto) {
		newItemToolMgtService.updateRtlTool(newItemToolMgtDto); 
	}
}
