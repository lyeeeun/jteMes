package jin.mes.cform.techMgt.ncProgramMgt;

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
@RequestMapping("/cform/techMgt/ncProgramMgt")
public class NewNcProgramMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NewNcProgramMgtController.class);

	@Resource
	protected NewNcProgramMgtService newNcProgramMgtService;
	
	@RequestMapping("/selectRoutingInfo")
	public ModelMap selectRoutingInfo(@ModelAttribute("ncProgramMgtDto") NewNcProgramMgtDto ncProgramMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ncProgramMgtDto.getPage())));
		pageRequestVo.setRows(ncProgramMgtDto.getRows());

		setModelWithkendoList(model, newNcProgramMgtService.selectRoutingInfo(ncProgramMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectNcPgmInfo")
	public ModelMap selectNcPgmInfo(@ModelAttribute("ncProgramMgtDto") NewNcProgramMgtDto ncProgramMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ncProgramMgtDto.getPage())));
		pageRequestVo.setRows(ncProgramMgtDto.getRows());

		setModelWithkendoList(model, newNcProgramMgtService.selectNcPgmInfo(ncProgramMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/saveNcPgmInfo")
	@ResponseBody
	public void saveNcPgmInfo(ModelMap model, @RequestBody NewNcProgramMgtDto ncProgramMgtDto) {
		newNcProgramMgtService.saveNcPgmInfo(ncProgramMgtDto);
	}

	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(ModelMap model, @RequestBody NewNcProgramMgtDto ncProgramMgtDto) {
		newNcProgramMgtService.updateIsUse(ncProgramMgtDto);
	}
	
	@RequestMapping("/selectDupleKeyCheck")
	@ResponseBody
	public int selectDupleKeyCheck(ModelMap model, @RequestBody NewNcProgramMgtDto ncProgramMgtDto) {
		return newNcProgramMgtService.selectDupleKeyCheck(ncProgramMgtDto);
	}
	

}
