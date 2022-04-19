package jin.mes.cform.qualMgt.badTotalMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/qualMgt/badTotalMgt")
public class NewBadTotalMgtController extends BaseController {

	@Autowired
	NewBadTotalMgtService newBadTotalMgtService;
	
	@RequestMapping("getBadTotalSelectBoxList")
	public ModelMap getBadTotalSelectBoxList(ModelMap model, @ModelAttribute("badTotalDto") NewInfergodsMgtDto badTotalDto) {
		try {
			model.addAttribute("rows", newBadTotalMgtService.getBadTotalSelectBoxList(badTotalDto));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getBadTotalList")
	public ModelMap getBadTotalList(ModelMap model, @ModelAttribute("badTotalDto") NewInfergodsMgtDto badTotalDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(badTotalDto.getPage())));
		pageRequestVo.setRows(badTotalDto.getRows());
		pageRequestVo.setPagingYN(badTotalDto.getPagingYN());
		try {
			setModelWithkendoList(model, newBadTotalMgtService.getBadTotalList(badTotalDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getBadTotalDetailList")
	public ModelMap getBadTotalDetailList(ModelMap model, @ModelAttribute("badTotalDto") NewInfergodsMgtDto badTotalDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(badTotalDto.getPage())));
		pageRequestVo.setRows(badTotalDto.getRows());
		pageRequestVo.setPagingYN(badTotalDto.getPagingYN());
		try {
			setModelWithkendoList(model, newBadTotalMgtService.getBadTotalDetailList(badTotalDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
