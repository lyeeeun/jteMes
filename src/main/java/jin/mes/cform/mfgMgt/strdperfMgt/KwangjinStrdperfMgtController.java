package jin.mes.cform.mfgMgt.strdperfMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.orderMgt.orderDetailMgt.KwangjinOrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/mfgMgt/strdperfMgt")
public class KwangjinStrdperfMgtController extends BaseController {

	@Autowired
	KwangjinStrdperfMgtService kwangjinStrdperfMgtService;
	
	//표준/실적 조회
	@RequestMapping("getStrdperfList")
	public ModelMap getStrdperfList(ModelMap model, @ModelAttribute("kwangjinStrdperfMgtDto") KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinStrdperfMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinStrdperfMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, kwangjinStrdperfMgtService.getStrdperfList(kwangjinStrdperfMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("표준/실적 조회 에러 : " + ex.getMessage());
		}
		return model;
	}

	@RequestMapping("getAssignList")
	public ModelMap getAssignList(ModelMap model, @ModelAttribute("kwangjinStrdperfMgtDto") KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinStrdperfMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinStrdperfMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, kwangjinStrdperfMgtService.getAssignList(kwangjinStrdperfMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("표준/실적 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//표준/실적 상세조회
	@RequestMapping("getStrdperfDetailList")
	public ModelMap getStrdperfDetailList(ModelMap model, @ModelAttribute("kwangjinStrdperfMgtDto") KwangjinStrdperfMgtDto kwangjinStrdperfMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinStrdperfMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinStrdperfMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, kwangjinStrdperfMgtService.getStrdperfDetailList(kwangjinStrdperfMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("표준/실적 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
