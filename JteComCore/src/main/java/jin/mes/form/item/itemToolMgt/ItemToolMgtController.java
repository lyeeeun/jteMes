package jin.mes.form.item.itemToolMgt;

import java.util.List;

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

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/item/itemToolMgt")
public class ItemToolMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ItemToolMgtController.class);

	@Resource
	protected ItemToolMgtService itemToolMgtService;
		
	@RequestMapping("/getItemToolRtlList")
	public ModelMap getItemToolRtlList(@ModelAttribute("itemToolMgtDto") ItemToolMgtDto itemToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemToolMgtDto.getPage())));
		pageRequestVo.setRows(itemToolMgtDto.getRows());

		setModelWithkendoList(model, itemToolMgtService.getItemToolRtlList(itemToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getItemToolPop")
	public ModelMap getItemToolPop(@ModelAttribute("itemToolMgtDto") ItemToolMgtDto itemToolMgtDto, ModelMap model) {
		model.addAttribute("rows", itemToolMgtService.getItemToolPop(itemToolMgtDto));

		return model;
	}
	

	@RequestMapping("/getRtlToolList")
	public ModelMap getRtlToolList(@ModelAttribute("itemToolMgtDto") ItemToolMgtDto itemToolMgtDto, ModelMap model) {
		model.addAttribute("result", itemToolMgtService.getRtlToolList(itemToolMgtDto));

		return model;
	}
	
	//LoT정보 등록/수정
	@RequestMapping("/setItemTool")
	@ResponseBody
	public String setItemTool(@RequestBody ItemToolMgtDto itemToolMgtDto) {
		return itemToolMgtService.setItemTool(itemToolMgtDto);
	}
	
//	@RequestMapping("/setItemToolRtlDelete")
//	@ResponseBody
//	public int setItemToolRtlDelete(ModelMap model, @RequestBody List<ItemToolMgtDto> itemToolList) {
//		return itemToolMgtService.setItemToolRtlDelete(itemToolList);
//	}
}
