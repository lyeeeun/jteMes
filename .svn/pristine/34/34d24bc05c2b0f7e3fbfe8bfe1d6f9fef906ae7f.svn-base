package jin.mes.form.qualMgt.qualPec.qualPectMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/qualMgt/qualPec/qualPectMgt")
public class QualPectMgtController extends BaseController {

	@Autowired
	QualPectMgtService mtrlOrderQualService;
	
	@RequestMapping("getMtrlOrderQualList")
	public ModelMap getMtrlOrderQualList(ModelMap model, @ModelAttribute("mtrlOrderDto") MtrlOdplanMgtDto mtrlOrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlOrderDto.getPage())));
		pageRequestVo.setRows(mtrlOrderDto.getRows());
		try {
			setModelWithkendoList(model, mtrlOrderQualService.getMtrlOrderQualList(mtrlOrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("품질 - 수입검사 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
}
