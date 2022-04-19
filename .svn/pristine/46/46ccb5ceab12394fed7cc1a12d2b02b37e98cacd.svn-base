package jin.mes.cform.qualMgt.qualPec.toolQualMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.item.itemToolMgt.NewItemToolMgtDto;
import jin.mes.cform.qualMgt.qualCheckList.NewQualCheckListDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/qualPec/toolQualMgt")
public class NewToolQualMgtController extends BaseController {

	@Autowired
	NewToolQualMgtService newToolQualMgtService;
	

	@RequestMapping("/selectToolInspInfo")
	public ModelMap selectToolInspInfo(@ModelAttribute("toolQualMgtDto") NewToolQualMgtDto toolQualMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(toolQualMgtDto.getPage())));
		pageRequestVo.setRows(toolQualMgtDto.getRows());

		setModelWithkendoList(model, newToolQualMgtService.selectToolInspInfo(toolQualMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectRtlPlaceInfo")
	public ModelMap selectRtlPlaceInfo(@ModelAttribute("toolQualMgtDto") NewToolQualMgtDto toolQualMgtDto, ModelMap model) {
		model.addAttribute("rows", newToolQualMgtService.selectRtlPlaceInfo(toolQualMgtDto));

		return model;
	}

	@RequestMapping("/selectInspHistory")
	public ModelMap selectInspHistory(@ModelAttribute("toolQualMgtDto") NewToolQualMgtDto toolQualMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", newToolQualMgtService.selectInspHistory(toolQualMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectInspHistory " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/insertToolInspInfo")
	@ResponseBody
	public void insertToolInspInfo(@RequestBody NewToolQualMgtDto toolQualMgtDto) {
		newToolQualMgtService.insertToolInspInfo(toolQualMgtDto);
	}
	
	@RequestMapping("/updateToolInspInfo")
	@ResponseBody
	public void updateToolInspInfo(@RequestBody NewToolQualMgtDto toolQualMgtDto) {
		newToolQualMgtService.updateToolInspInfo(toolQualMgtDto);
	}
	
//	
//	@RequestMapping("/saveRtlToolInfo")
//	@ResponseBody
//	public void saveRtlToolInfo(ModelMap model, @RequestBody NewItemToolMgtDto itemToolMgtDto) {
//		newItemToolMgtService.saveRtlToolInfo(itemToolMgtDto);
//	}
//	
//	@RequestMapping("/deleteRtlToolInfo")
//	@ResponseBody
//	public void deleteRtlToolInfo(ModelMap model, @RequestBody List<NewItemToolMgtDto> itemToolList) {
//		newItemToolMgtService.deleteRtlToolInfo(itemToolList);
//	}
//	
}
