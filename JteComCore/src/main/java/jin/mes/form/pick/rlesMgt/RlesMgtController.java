package jin.mes.form.pick.rlesMgt;

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
@RequestMapping("/form/pick/rlesMgt")
public class RlesMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(RlesMgtController.class);

	@Resource
	protected RlesMgtService rlesMgtService;

	@RequestMapping("/getRlesPlansList")
	public ModelMap getPackageList(@ModelAttribute("rlesMgtDto") RlesMgtDto rlesMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesMgtDto.getPage())));
		pageRequestVo.setRows(rlesMgtDto.getRows());

		setModelWithkendoList(model, rlesMgtService.getRlesPlansList(rlesMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/setRlesWorkStart")
	@ResponseBody
	public String setRlesWorkStart(@RequestBody RlesMgtDto rlesMgtDto) {
		return rlesMgtService.setRlesWorkStart(rlesMgtDto);
	}
	
	@RequestMapping("/setRlesWorkSave")
	@ResponseBody
	public String setRlesWorkSave(@RequestBody RlesMgtDto rlesMgtDto) {
		return rlesMgtService.setRlesWorkSave(rlesMgtDto);
	}

}
