package jin.mes.form.qualMgt.badTotalMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/qualMgt/badTotalMgt")
public class BadTotalMgtController extends BaseController {

	@Autowired
	BadTotalMgtService badTotalMgtService;
	
	@RequestMapping("getBadTotalSelectBoxList")
	public ModelMap getBadTotalSelectBoxList(ModelMap model, @ModelAttribute("badTotalDto") InfergodsMgtDto badTotalDto) {
		try {
			model.addAttribute("rows", badTotalMgtService.getBadTotalSelectBoxList(badTotalDto));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getBadTotalList")
	public ModelMap getBadTotalList(ModelMap model, @ModelAttribute("badTotalDto") InfergodsMgtDto badTotalDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(badTotalDto.getPage())));
		pageRequestVo.setRows(badTotalDto.getRows());
		pageRequestVo.setPagingYN(badTotalDto.getPagingYN());
		try {
			setModelWithkendoList(model, badTotalMgtService.getBadTotalList(badTotalDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getBadTotalDetailList")
	public ModelMap getBadTotalDetailList(ModelMap model, @ModelAttribute("badTotalDto") InfergodsMgtDto badTotalDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(badTotalDto.getPage())));
		pageRequestVo.setRows(badTotalDto.getRows());
		pageRequestVo.setPagingYN(badTotalDto.getPagingYN());
		try {
			setModelWithkendoList(model, badTotalMgtService.getBadTotalDetailList(badTotalDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("불량관리 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
