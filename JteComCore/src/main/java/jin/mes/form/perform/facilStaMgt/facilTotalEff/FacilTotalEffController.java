package jin.mes.form.perform.facilStaMgt.facilTotalEff;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/perform/facilStaMgt/facilTotalEff")
public class FacilTotalEffController extends BaseController {
	
	@Autowired
	FacilTotalEffService facilTotalEffService;
	
	//설비 정비이력 조회
	@RequestMapping("getEqmtMgtList")
	public ModelMap getEqmtMgtList(ModelMap model, @ModelAttribute("facilTotalEffDto") FacilTotalEffDto facilTotalEffDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(facilTotalEffDto.getPage())));
		pageRequestVo.setRows(facilTotalEffDto.getRows());
		try {
			setModelWithkendoList(model, facilTotalEffService.getEqmtMgtList(facilTotalEffDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("설비 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
