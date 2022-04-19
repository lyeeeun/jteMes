package jin.mes.form.mtrl.sparePartsMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mtrl/sparePartsMgt")
public class SparePartsMgtController extends BaseController {
	
	@Autowired
	SparePartsMgtService sparePartsMgtService;
	
	@RequestMapping("getToolInfoList")
	public ModelMap getToolInfoList(ModelMap model, @ModelAttribute("spareMgtDto") SparePartsMgtDto spareMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(spareMgtDto.getPage())));
		pageRequestVo.setRows(spareMgtDto.getRows());
		try {
			setModelWithkendoList(model, sparePartsMgtService.getToolInfoList(spareMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
}