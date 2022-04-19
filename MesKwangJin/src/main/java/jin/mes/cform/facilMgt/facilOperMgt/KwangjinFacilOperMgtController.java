package jin.mes.cform.facilMgt.facilOperMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/facilMgt/facilOperMgt")
public class KwangjinFacilOperMgtController extends BaseController {

	@Autowired
	KwangjinFacilOperMgtService kwangjinFacilOperMgtService;
	
	//설비 정비이력 조회
	@RequestMapping("getEqmtOperList")
	public ModelMap getEqmtOperList(ModelMap model, @ModelAttribute("kwangjinFacilOperMgtDto") KwangjinFacilOperMgtDto kwangjinFacilOperMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinFacilOperMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinFacilOperMgtDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinFacilOperMgtService.getEqmtOperList(kwangjinFacilOperMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("설비 정비이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/selectEqmtWorkList")
	public ModelMap selectEqmtWorkList(@ModelAttribute("kwangjinFacilOperMgtDto") KwangjinFacilOperMgtDto kwangjinFacilOperMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", kwangjinFacilOperMgtService.selectEqmtWorkList(kwangjinFacilOperMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectEqmtWorkList " + ex.getMessage());
		}
		return model;
	}
}
