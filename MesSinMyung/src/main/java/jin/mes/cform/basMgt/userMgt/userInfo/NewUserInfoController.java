package jin.mes.cform.basMgt.userMgt.userInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.basMgt.userMgt.userAuth.NewUserAuthDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/basMgt/userMgt/userInfo")
public class NewUserInfoController extends BaseController {

	@Autowired
	private NewUserInfoService newUserInfoService;

	@RequestMapping("getUserList")
	public ModelMap getUserList(ModelMap model, @ModelAttribute("userInfo") NewUserInfoDto userInfo) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(userInfo.getPage())));
		pageRequestVo.setRows(userInfo.getRows());

		try {
			setModelWithkendoList(model, newUserInfoService.getUserList(userInfo, pageRequestVo));
		} catch (Exception ex) {
			throw new BusinessException("유저 조회 에러 : " + ex.getMessage());
		}
		return model;
	}

	@RequestMapping("getUserRoleList")
	public ResponseEntity<Object> getUserRoleList(ModelMap model, @ModelAttribute("userAuthDto") NewUserAuthDto userAuthDto) {
		return new ResponseEntity<Object>(newUserInfoService.getUserRoleList(userAuthDto), HttpStatus.OK);
	}

	@RequestMapping("/getPopUserList")
	public ModelMap getPopUserList(ModelMap model, @ModelAttribute KendoPageVO pageVO) {
		try {
//			final JPQLQuery<Account> query;
			setModelWithkendoList(model, newUserInfoService.getPopUserList(pageVO));
		} catch (Exception ex) {
			// throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.format.invalid", new Object[] {filename, uploadExtAllowedPattern})); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
			throw new BusinessException("조회에러입니다. : " + ex.getMessage());
		}
		return model;
	}

	@RequestMapping("/setUserSave")
	@ResponseBody
	public int setUserSave(ModelMap model, @RequestBody NewUserInfoDto userInfo) {
		int reutrnInt = 0;
		try {
			reutrnInt = newUserInfoService.setUserSave(userInfo);
		} catch (Exception e) {
			// TODO: handle exception\
			throw new BusinessException("정보수정 에러입니다. : " + e.getMessage());
		}
		return reutrnInt;
	}

}
