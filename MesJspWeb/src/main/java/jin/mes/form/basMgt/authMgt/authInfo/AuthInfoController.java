package jin.mes.form.basMgt.authMgt.authInfo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import kr.co.itcall.jte.spring.user.model.RtlRoleAuth;
import lombok.extern.slf4j.Slf4j;

/**<pre>
 * <b>jin.mes.form.operMgt.roleBase</b>
 * <b>RoleBaseController.java</b>
 * <p>Descriptions : </p>
 * </pre>
 * 
 * @author  : rlawhdrn456@jintech2ng.co.kr
 * @Date    : 2020. 1. 7.
 * @Version : 
 */

@Controller
@Slf4j
@RequestMapping("/form/basMgt/authMgt/authInfo")
public class AuthInfoController extends BaseController{
	
	@Autowired
	AuthInfoServiceImpl authInfoService;
	
	@RequestMapping("/getAuthList")
	public ModelMap getAuthList(ModelMap model, @ModelAttribute("PageVO") KendoPageVO pageVO) {
		try {
//			final JPQLQuery<Account> query;
			setModelWithkendoList(model,authInfoService.getAuthList(pageVO));
		}catch(Exception ex) {
			//throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.format.invalid", new Object[] {filename, uploadExtAllowedPattern})); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
			throw new BusinessException("조회에러입니다.\n" + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setAuthSave")
	public ModelMap setRoleGrpSave(ModelMap model, @ModelAttribute("authInfoModel") AuthInfoModel authInfoModel) {
		try {
			authInfoService.setAuthSave(authInfoModel);
		}catch(Exception ex) {
			throw new BusinessException("저장 에러입니다.\n" + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setAuthUpdate")
	public ModelMap setAuthUpdate(ModelMap model, @ModelAttribute("authInfoModel") AuthInfoModel authInfoModel) {
		try {
			authInfoService.setAuthUpdate(authInfoModel);
		}catch(Exception ex) {
			throw new BusinessException("저장 에러입니다.: "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setAuthDelete")
	public ModelMap setRoleGrpDelete(ModelMap model, @ModelAttribute("authInfoModel") AuthInfoModel authInfoModel) {
		try {
			authInfoService.setAuthDelete(authInfoModel);
		}catch(Exception ex) {
			throw new BusinessException("삭제 에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getGrpAuthList")
	public ModelMap getGrpAuthList(ModelMap model, @ModelAttribute("PageVO") KendoPageVO pageVO) {
		try {
			setModelWithkendoList(model,authInfoService.getGrpAuthList(pageVO));
		}catch(Exception ex) {
			//throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.format.invalid", new Object[] {filename, uploadExtAllowedPattern})); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
			throw new BusinessException("조회에러입니다. : "+ex.getMessage());
		}
		return model;
	}
	

	@RequestMapping("/setGrpAuthInclude")
	public void setGrpAuthInclude(ModelMap model, @RequestBody Map<String, Object> map) {
		int resultInt;
		try {
			authInfoService.setGrpAuthInclude(map.get("roleId").toString(), map.get("authId").toString(),map.get("isInclude").toString());
		}catch(Exception ex) {
			//throw new BusinessException(messageSourceAccessor.getMessage("errors.board.file.format.invalid", new Object[] {filename, uploadExtAllowedPattern})); // 지정된 파일형식만 업로드가 가능합니다.\n업로드가능형식 : [{0}]
			throw new BusinessException("입력에러입니다.: "+ex.getMessage());
		}
		
	}
}
