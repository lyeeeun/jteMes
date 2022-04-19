package jin.mes.cform.techMgt.offsetMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.techMgt.techDocMgt.TechDocMgtController;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/techMgt/offsetMgt")
public class NewOffsetMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(TechDocMgtController.class);

	@Resource
	protected NewOffsetMgtService newOffsetMgtService;
	
	@RequestMapping("/selectOffsetData")
	public ModelMap selectOffsetData(@ModelAttribute("offsetMgtDto") NewOffsetMgtDto offsetMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(offsetMgtDto.getPage())));
		pageRequestVo.setRows(offsetMgtDto.getRows());

		setModelWithkendoList(model, newOffsetMgtService.selectOffsetData(offsetMgtDto, pageRequestVo));

		return model;
	}
	
}
