package jin.mes.form.basMgt.devtol.userConn;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/basMgt/devtol/userConn")
public class UserConnController extends BaseController {
	@Autowired
	UserConnService userConnService;
	
	@RequestMapping("getUserConnList")
	public ModelMap getUserConnList(ModelMap model, @ModelAttribute("userConnDto") UserConnDto userConnDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(userConnDto.getPage())));
		pageRequestVo.setRows(userConnDto.getRows());
		try {
			setModelWithkendoList(model, userConnService.getUserConnList(userConnDto, pageRequestVo));
		} catch (Exception ex) {
			throw new BusinessException("유저 접속기록 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("setUserConn")
	public ModelMap setUserConn(ModelMap model, @RequestBody UserConnDto userConnDto) {
		try {
			userConnService.setUserConn(userConnDto);
		} catch (Exception ex) {
			throw new BusinessException("유저 접속기록 저장 : " + ex.getMessage());
		}
		return model;
	}
}
