package jin.mes.form.mfgMgt.strdperfMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/mfgMgt/strdperfMgt")
public class StrdperfMgtController extends BaseController {

	@Autowired
	StrdperfMgtService strdperfMgtService;
	
	//표준/실적 조회
	@RequestMapping("getStrdperfList")
	public ModelMap getStrdperfList(ModelMap model, @ModelAttribute("strdperfMgtDto") StrdperfMgtDto strdperfMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(strdperfMgtDto.getPage())));
		pageRequestVo.setRows(strdperfMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, strdperfMgtService.getStrdperfList(strdperfMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("표준/실적 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//표준/실적 상세조회
	@RequestMapping("getStrdperfDetailList")
	public ModelMap getStrdperfDetailList(ModelMap model, @ModelAttribute("strdperfMgtDto") StrdperfMgtDto strdperfMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(strdperfMgtDto.getPage())));
		pageRequestVo.setRows(strdperfMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, strdperfMgtService.getStrdperfDetailList(strdperfMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("표준/실적 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
