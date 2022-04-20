package jin.mes.cform.mfgMgt.strdperfMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/strdperfMgt")
public class NewStrdperfMgtController extends BaseController {

	@Autowired
	NewStrdperfMgtService newStrdperfMgtService;
	
	//표준/실적 조회
	@RequestMapping("getStrdperfList")
	public ModelMap getStrdperfList(ModelMap model, @ModelAttribute("newStrdperfMgtDto") NewStrdperfMgtDto newStrdperfMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newStrdperfMgtDto.getPage())));
		pageRequestVo.setRows(newStrdperfMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, newStrdperfMgtService.getStrdperfList(newStrdperfMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("표준/실적 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//표준/실적 상세조회
	@RequestMapping("getStrdperfDetailList")
	public ModelMap getStrdperfDetailList(ModelMap model, @ModelAttribute("newStrdperfMgtDto") NewStrdperfMgtDto newStrdperfMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newStrdperfMgtDto.getPage())));
		pageRequestVo.setRows(newStrdperfMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, newStrdperfMgtService.getStrdperfDetailList(newStrdperfMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("표준/실적 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}