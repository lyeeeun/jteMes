package jin.mes.form.techMgt.ncProgramMgt;

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
@RequestMapping("/form/techMgt/ncProgramMgt")
public class NcProgramMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NcProgramMgtController.class);

	@Resource
	protected NcProgramMgtService ncProgramMgtService;
	
	@RequestMapping("/selectRoutingInfo")
	public ModelMap selectRoutingInfo(@ModelAttribute("ncProgramMgtDto") NcProgramMgtDto ncProgramMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ncProgramMgtDto.getPage())));
		pageRequestVo.setRows(ncProgramMgtDto.getRows());

		setModelWithkendoList(model, ncProgramMgtService.selectRoutingInfo(ncProgramMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectNcPgmInfo")
	public ModelMap selectNcPgmInfo(@ModelAttribute("ncProgramMgtDto") NcProgramMgtDto ncProgramMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ncProgramMgtDto.getPage())));
		pageRequestVo.setRows(ncProgramMgtDto.getRows());

		setModelWithkendoList(model, ncProgramMgtService.selectNcPgmInfo(ncProgramMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/saveNcPgmInfo")
	@ResponseBody
	public void saveNcPgmInfo(ModelMap model, @RequestBody NcProgramMgtDto ncProgramMgtDto) {
		ncProgramMgtService.saveNcPgmInfo(ncProgramMgtDto);
	}

	@RequestMapping("/updateIsUse")
	@ResponseBody
	public void updateIsUse(ModelMap model, @RequestBody NcProgramMgtDto ncProgramMgtDto) {
		ncProgramMgtService.updateIsUse(ncProgramMgtDto);
	}
	
	@RequestMapping("/selectDupleKeyCheck")
	@ResponseBody
	public int selectDupleKeyCheck(ModelMap model, @RequestBody NcProgramMgtDto ncProgramMgtDto) {
		return ncProgramMgtService.selectDupleKeyCheck(ncProgramMgtDto);
	}
	

}
