package jin.mes.cform.qualMgt.qualPec.finalQualMgt;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/qualPec/finalQualMgt")
public class NewFinalQualMgtController extends BaseController {

	@Autowired
	NewFinalQualMgtService newFinalQualMgtService;
	
	//입고검사 조회
	@RequestMapping("getFinalQualList")
	public ModelMap getFinalQualList(ModelMap model, @ModelAttribute("newFinalQualMgtDto") NewFinalQualMgtDto newFinalQualMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newFinalQualMgtDto.getPage())));
		pageRequestVo.setRows(newFinalQualMgtDto.getRows());
		try {
			setModelWithkendoList(model, newFinalQualMgtService.getFinalQualList(newFinalQualMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("공구 상세 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
