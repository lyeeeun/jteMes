package jin.mes.form.facilMgt.facilOperMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/facilMgt/facilOperMgt")
public class FacilOperMgtController extends BaseController {

	@Autowired
	FacilOperMgtService facilOperMgtService;
	
	//설비 정비이력 조회
	@RequestMapping("getEqmtOperList")
	public ModelMap getEqmtOperList(ModelMap model, @ModelAttribute("facilOperMgtDto") FacilOperMgtDto facilOperMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(facilOperMgtDto.getPage())));
		pageRequestVo.setRows(facilOperMgtDto.getRows());
		try {
			setModelWithkendoList(model, facilOperMgtService.getEqmtOperList(facilOperMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("설비 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
