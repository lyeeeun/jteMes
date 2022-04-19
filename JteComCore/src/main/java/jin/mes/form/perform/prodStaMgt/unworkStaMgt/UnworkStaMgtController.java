package jin.mes.form.perform.prodStaMgt.unworkStaMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/perform/prodStaMgt/unworkStaMgt")
public class UnworkStaMgtController extends BaseController {
	
	@Autowired
	UnworkStaMgtService unworkStaMgtService;
	
	//미작업 현황 조회
	@RequestMapping("getUnWorkList")
	public ModelMap getUnWorkList(ModelMap model, @ModelAttribute("unworkStaMgtDto") UnworkStaMgtDto unworkStaMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(unworkStaMgtDto.getPage())));
		pageRequestVo.setRows(unworkStaMgtDto.getRows());
		try {
			setModelWithkendoList(model, unworkStaMgtService.getUnWorkList(unworkStaMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("미작업 현황 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
}
