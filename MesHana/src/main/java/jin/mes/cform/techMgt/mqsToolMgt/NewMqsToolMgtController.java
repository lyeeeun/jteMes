package jin.mes.cform.techMgt.mqsToolMgt;

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
@RequestMapping("/cform/techMgt/mqsToolMgt")
public class NewMqsToolMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(NewMqsToolMgtController.class);

	@Resource
	protected NewMqsToolMgtService newMqsToolMgtService;
	
	@RequestMapping("/selectMqsRoutingInfo")
	public ModelMap getTechDocInfo(@ModelAttribute("mqsToolMgtDto") NewMqsToolMgtDto mqsToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mqsToolMgtDto.getPage())));
		pageRequestVo.setRows(mqsToolMgtDto.getRows());

		setModelWithkendoList(model, newMqsToolMgtService.selectMqsRoutingInfo(mqsToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectMqsToolInfo")
	public ModelMap selectMqsToolInfo(@ModelAttribute("mqsToolMgtDto") NewMqsToolMgtDto mqsToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mqsToolMgtDto.getPage())));
		pageRequestVo.setRows(mqsToolMgtDto.getRows());

		setModelWithkendoList(model, newMqsToolMgtService.selectMqsToolInfo(mqsToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/saveMqsToolInfo")
	@ResponseBody
	public void saveMqsToolInfo(ModelMap model, @RequestBody NewMqsToolMgtDto mqsToolMgtDto) {
		newMqsToolMgtService.saveMqsToolInfo(mqsToolMgtDto);
	}
	
	/*
	 * @RequestMapping("/selectDupleKeyCheck")
	 * 
	 * @ResponseBody public int selectDupleKeyCheck(ModelMap model, @RequestBody MqsToolMgtDto mqsToolMgtDto) { return newMqsToolMgtService.selectDupleKeyCheck(mqsToolMgtDto); }
	 * 
	 */
	
}
 