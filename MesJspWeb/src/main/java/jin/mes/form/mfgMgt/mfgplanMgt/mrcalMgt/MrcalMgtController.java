package jin.mes.form.mfgMgt.mfgplanMgt.mrcalMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mfgMgt/mfgplanMgt/mrcalMgt")
public class MrcalMgtController extends BaseController {

	@Autowired
	MrcalMgtService mtrlUseCalService;
	
	@RequestMapping("/getMtrlUseCalList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("mtrlUseCalDto") MrcalMgtDto mtrlUseCalDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlUseCalDto.getPage())));
		pageRequestVo.setRows(mtrlUseCalDto.getRows());
		
		try {
			setModelWithkendoList(model, mtrlUseCalService.getMtrlUseCalList(mtrlUseCalDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재소요량  조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}