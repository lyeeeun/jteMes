package jin.mes.form.techMgt.mqsToolMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap; 
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.techMgt.techDocMgt.TechDocMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/techMgt/mqsToolMgt")
public class MqsToolMgtController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(MqsToolMgtController.class);

	@Resource
	protected MqsToolMgtService mqsToolMgtService;
	
	@RequestMapping("/selectMqsRoutingInfo")
	public ModelMap getTechDocInfo(@ModelAttribute("mqsToolMgtDto") MqsToolMgtDto mqsToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mqsToolMgtDto.getPage())));
		pageRequestVo.setRows(mqsToolMgtDto.getRows());

		setModelWithkendoList(model, mqsToolMgtService.selectMqsRoutingInfo(mqsToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectMqsToolInfo")
	public ModelMap selectMqsToolInfo(@ModelAttribute("mqsToolMgtDto") MqsToolMgtDto mqsToolMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mqsToolMgtDto.getPage())));
		pageRequestVo.setRows(mqsToolMgtDto.getRows());

		setModelWithkendoList(model, mqsToolMgtService.selectMqsToolInfo(mqsToolMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/saveMqsToolInfo")
	@ResponseBody
	public void saveMqsToolInfo(ModelMap model, @RequestBody MqsToolMgtDto mqsToolMgtDto) {
		mqsToolMgtService.saveMqsToolInfo(mqsToolMgtDto);
	}
	
	/*
	 * @RequestMapping("/selectDupleKeyCheck")
	 * 
	 * @ResponseBody public int selectDupleKeyCheck(ModelMap model, @RequestBody MqsToolMgtDto mqsToolMgtDto) { return mqsToolMgtService.selectDupleKeyCheck(mqsToolMgtDto); }
	 * 
	 */
	
}
 