package jin.mes.form.techMgt.offsetMgt;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.techMgt.techDocMgt.TechDocMgtController;
import jin.mes.form.techMgt.techDocMgt.TechDocMgtDto;
import jin.mes.form.techMgt.techDocMgt.TechDocMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/techMgt/offsetMgt")
public class OffsetMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(TechDocMgtController.class);

	@Resource
	protected OffsetMgtService offsetMgtService;
	
	@RequestMapping("/selectOffsetData")
	public ModelMap selectOffsetData(@ModelAttribute("offsetMgtDto") OffsetMgtDto offsetMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(offsetMgtDto.getPage())));
		pageRequestVo.setRows(offsetMgtDto.getRows());

		setModelWithkendoList(model, offsetMgtService.selectOffsetData(offsetMgtDto, pageRequestVo));

		return model;
	}
	
}
