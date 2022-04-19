package jin.mes.form.qualMgt.qualPec.prcesQualMgt;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.qualMgt.qualPec.inputQualMgt.InputQualMgtDto;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/qualMgt/qualPec/prcesQualMgt")
public class PrcesQualMgtController extends BaseController {

	@Autowired
	PrcesQualMgtService prcesQualMgtService;
	
	@RequestMapping("/getPrcesQualList")
	public ModelMap getPrcesQualList(ModelMap model, @ModelAttribute("lotInfoDto") LotInfoDto lotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotInfoDto.getPage())));
		pageRequestVo.setRows(lotInfoDto.getRows());
		//페이징 없음 추가
		pageRequestVo.setPagingYN(lotInfoDto.getPagingYN());
		try {
			
			setModelWithkendoList(model, prcesQualMgtService.getPrcesQualList(lotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업정보 - Lot조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getPrcesQualListAdd")
	public ModelMap getPrcesQualListAdd(ModelMap model, @ModelAttribute("wrkinTeamMgtDto") WrkinTeamMgtDto wrkinTeamMgtDto) {
		try {
			model.addAttribute("rows", prcesQualMgtService.getPrcesQualListAdd(wrkinTeamMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("자재투입현황 조회 에러입니다. : " + ex.getMessage());
		}
		return model;
	}
}
