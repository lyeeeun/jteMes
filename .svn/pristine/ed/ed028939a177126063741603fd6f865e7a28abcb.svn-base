package jin.mes.cform.mfgMgt.mfgplanMgt.mrcalMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/mfgplanMgt/mrcalMgt")
public class NewMrcalMgtController extends BaseController {

	@Autowired
	NewMrcalMgtService newMrcalMgtService;
	
	@RequestMapping("/getMtrlUseCalList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("mtrlUseCalDto") NewMrcalMgtDto mtrlUseCalDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlUseCalDto.getPage())));
		pageRequestVo.setRows(mtrlUseCalDto.getRows());
		
		try {
			setModelWithkendoList(model, newMrcalMgtService.getMtrlUseCalList(mtrlUseCalDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재소요량  조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
