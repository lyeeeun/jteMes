package jin.mes.cform.item.itemToolMgt;

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
@RequestMapping("/cform/item/itemToolMgt")
public class NewItemToolMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewItemToolMgtController.class);

	@Resource
	protected NewItemToolMgtService newItemToolMgtService;
	
	@RequestMapping("/selectRtlToolInfo")
	public ModelMap selectRtlToolInfo(@ModelAttribute("itemToolMgtDto") NewItemToolMgtDto itemToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemToolMgtDto.getPage())));
		pageRequestVo.setRows(itemToolMgtDto.getRows());

		setModelWithkendoList(model, newItemToolMgtService.selectRtlToolInfo(itemToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectAllRtlToolInfo")
	public ModelMap selectAllRtlToolInfo(@ModelAttribute("itemToolMgtDto") NewItemToolMgtDto itemToolMgtDto, ModelMap model) {
		model.addAttribute("rows", newItemToolMgtService.selectAllRtlToolInfo(itemToolMgtDto));

		return model;
	}
	
	@RequestMapping("/saveRtlToolInfo")
	@ResponseBody
	public void saveRtlToolInfo(ModelMap model, @RequestBody NewItemToolMgtDto itemToolMgtDto) {
		newItemToolMgtService.saveRtlToolInfo(itemToolMgtDto);
	}
	
	@RequestMapping("/deleteRtlToolInfo")
	@ResponseBody
	public void deleteRtlToolInfo(ModelMap model, @RequestBody List<NewItemToolMgtDto> itemToolList) {
		newItemToolMgtService.deleteRtlToolInfo(itemToolList);
	}
	
	@RequestMapping("/selectDupleKeyCheck")
	@ResponseBody 
	public int selectDupleKeyCheck(ModelMap model, @RequestBody NewItemToolMgtDto itemToolMgtDto) { 
		return newItemToolMgtService.selectDupleKeyCheck(itemToolMgtDto); 
	}
	 
	
}
