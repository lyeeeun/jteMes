package jin.mes.form.item.itemToolMgt;

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
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/item/itemToolMgt")
public class ItemToolMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ItemToolMgtController.class);

	@Resource
	protected ItemToolMgtService itemToolMgtService;
	
	@RequestMapping("/getRtlEqmtList")
	public ModelMap getRtlEqmtList(@ModelAttribute("itemToolMgtDto") ItemToolMgtDto itemToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(itemToolMgtDto.getPage())));
		pageRequestVo.setRows(itemToolMgtDto.getRows());

		setModelWithkendoList(model, itemToolMgtService.getRtlEqmtList(itemToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getRtlToolList")
	public ModelMap getRtlToolList(@ModelAttribute("itemToolMgtDto") ItemToolMgtDto itemToolMgtDto, ModelMap model) {
		model.addAttribute("result", itemToolMgtService.getRtlToolList(itemToolMgtDto));

		return model;
	}
	
	@RequestMapping("/updateRtlTool")
	@ResponseBody
	public void updateRtlTool(@RequestBody ItemToolMgtDto itemToolMgtDto) {
		itemToolMgtService.updateRtlTool(itemToolMgtDto); 
	}
}
