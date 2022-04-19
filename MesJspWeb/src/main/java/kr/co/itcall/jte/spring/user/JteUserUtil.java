package kr.co.itcall.jte.spring.user;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import jin.mes.form.basMgt.authMgt.authInfo.AuthInfoModel;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JteUserUtil extends JteUtils {

	public static String getUserNm(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")){
			UserSessionInfoVo user = (UserSessionInfoVo)authentication.getPrincipal();
			
			return user.getUserInfo().getUserNm();
		}else{
			return "SYSTEM";
		}
	}
	
	public static UserSessionInfoVo getUserInfo(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")
				&& authentication.getPrincipal() instanceof UserSessionInfoVo){
			return (UserSessionInfoVo)authentication.getPrincipal();
			
		}
		return null;
	}
	
//	public static String getPartCode(){
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		
//		if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")){
//			UserSessionInfoVo user = (UserSessionInfoVo)authentication.getPrincipal();
//			return user.getUserInfo()au;
//		}else{
//			return "";
//		}
//	}
//
//	public static String getPartName(){
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		
//		if(authentication != null && !authentication.getPrincipal().equals("anonymousUser")){
//			UserSessionInfoVo user = (UserSessionInfoVo)authentication.getPrincipal();
//			return user.getUserInfo().getPartName();
//		}else{
//			return "";
//		}
//	}

	public static List<String> getMyRoleGrpIds() {
		List<String> result = new ArrayList<String>();
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			result.addAll(((UserSessionInfoVo)authentication.getPrincipal()).getRoleGrpIds());
		} catch (Exception e) {
			log.warn("Not found RoleGrpIds, errorMsg[{}] {}", e.getMessage(), e);
		}
		return result;
	}

	public static List<AuthInfoModel> getMyAuthInfos() {
		List<AuthInfoModel> result = new ArrayList<AuthInfoModel>();
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			result.addAll(((UserSessionInfoVo)authentication.getPrincipal()).getAuthInfoModels());
		} catch (Exception e) {
			log.warn("Not found Authorities, errorMsg[{}] {}", e.getMessage(), e);
		}
		return result;
	}

	
}
