package jin.mes.cform.mtrl.sparePartsMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mtrl/sparePartsMgt")
public class NewSparePartsMgtController extends BaseController {
	
	@Autowired
	NewSparePartsMgtService newSparePartsMgtService;
	
	@RequestMapping("getToolInfoList")
	public ModelMap getToolInfoList(ModelMap model, @ModelAttribute("newSpareMgtDto") NewSparePartsMgtDto newSpareMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newSpareMgtDto.getPage())));
		pageRequestVo.setRows(newSpareMgtDto.getRows());
		try {
			setModelWithkendoList(model, newSparePartsMgtService.getToolInfoList(newSpareMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
}