package kr.co.itcall.jte.common.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.LocaleResolver;

import kr.co.itcall.jte.util.AsyncUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JteUtils {

	private static final int MAX_STACK_TRACE_LENGTH = 5;

	/**
	 * <pre>
	 * 1. 개요 : 현재 로그인된 사용자ID를 가져온다.
	 * 2. 처리내용 : 로그인 하지 않는 사용자세션은 anonymousUser를 반환하며, 이외에는 unkownUser를 반환한다.
	 * </pre>
	 * @Method : getUserId
	 * @return
	 */
	public static String getUserId() {
		Authentication authentication = null;
		try {
			//	if (SecurityContextHolder.getContext().getAuthentication() != null) {
			//		OAuth2Authentication auth = (OAuth2Authentication) SecurityContextHolder.getContext().getAuthentication();
			//		Object principal = auth.getUserAuthentication().getPrincipal();
			//		CustomUserDetails userDetails = (CustomUserDetails) principal;
			//		return userDetails.getUsername();
			//	} else {
			//		return "Unknown";
			//	}
			authentication = SecurityContextHolder.getContext().getAuthentication();
			if(authentication!=null && authentication.getPrincipal()!=null && authentication.getPrincipal().equals("anonymousUser")){
				StackTraceElement[] stackTraceElements = Arrays.copyOf(Thread.currentThread().getStackTrace(), Thread.currentThread().getStackTrace().length>MAX_STACK_TRACE_LENGTH?MAX_STACK_TRACE_LENGTH:Thread.currentThread().getStackTrace().length); // 현재 실행 중인 스레드의 스택 트레이스
				log.warn("Someone not login with Call getUserId() ::: SessionInfo[{}], stackTraceElements : {}", authentication, stackTraceElements);
				return "anonymousUser"; // 로그인하지 않은 세션
			} else {
				// ((UserSessionInfoVo)authentication.getPrincipal()).getUserInfo().getUserId();
				return authentication.getName(); // 유효세션이라고 생각하고... 반환 에러나면 유효세션이 아님.
			}
		} catch (Exception e) {
			StackTraceElement[] stackTraceElements = Arrays.copyOf(e.getStackTrace(), e.getStackTrace().length>MAX_STACK_TRACE_LENGTH?MAX_STACK_TRACE_LENGTH:e.getStackTrace().length);
			log.warn("Someone not login or has not session with Call getUserId() ::: Message[{}], Cause[{}], LocalMessage[{}], SessionInfo[{}], stackTraceElements : {}", e.getMessage(), e.getCause(), e.getLocalizedMessage(), authentication, stackTraceElements);
			return "unkownUser";
		}
	}

	public static String getClientIp() {
		String ip = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("X-FORWARDED-FOR");
		if (ip == null) {
			ip = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("Proxy-Client-IP");
		}
		if (ip == null) {
			ip = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null) {
			ip = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null) {
			ip = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null) {
			ip = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getRemoteAddr();
		}
		return ip;
	}
	
	public static String getUserDevice() {
		String isDevice = "";
		String userAgent = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getHeader("User-Agent").toUpperCase();
		if(userAgent.indexOf("MOBILE") > -1) {
			if(userAgent.indexOf("PHONE") == -1) {
				isDevice = "MOBILE";
			}else {
				isDevice = "TABLET";
			}
		} else {
			isDevice = "PC";
		}
		return isDevice;
	}
	public static String getUserCookie(String name) {
		String cookieValue = "";
		Cookie[] cookies = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getCookies();
		if(cookies.length > 0) {
			for(Cookie ck : cookies) {
				if(ck.getName().equals(name)) {
					cookieValue = ck.getValue();
				}
			}
		}
		return cookieValue;
	}
	
	public static Locale getMyLocale() {
		try {
			LocaleResolver localeResolver = AsyncUtil.getApplicationContext().getBean(LocaleResolver.class);
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			return localeResolver.resolveLocale(request);
		} catch (Exception e) {
			log.warn("Cannot found locale from myConnection request. error[{}] : {}", e.getMessage(), e);
		}
		return Locale.getDefault();
	}
	public static HttpServletRequest getMyRequest() {
		try {
			return ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		} catch (Exception e) {
			log.warn("Cannot found request from myConnection. error[{}] : {}", e.getMessage(), e);
		}
		return null;
	}
	public static void setMyLocale(String langCd) {
		try {
			LocaleResolver localeResolver = AsyncUtil.getApplicationContext().getBean(LocaleResolver.class);
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getResponse();
			localeResolver.setLocale(request, response, new Locale(langCd));
		} catch (Exception e) {
			log.warn("Cannot set locale to myConnection request/response. error[{}] : {}", e.getMessage(), e);
		}
	}

	public static String getUserId(String userId){
		if(!StringUtils.isEmpty(userId)){
			return userId;
		}else{
			return getUserId();
		}
	}
	
	public static String nvl(String value){
		if(!StringUtils.isEmpty(value)){
			return value;
		}else{
			return "";
		}
	}
	
    public static Boolean checkTelNum(List<String> phoneNums){
    	for(int i = 0 ; i < phoneNums.size();i++){
    		for(int j = 0; j < i ;j++){
    			if(!StringUtils.isEmpty(phoneNums.get(j)) && phoneNums.get(i).equals(phoneNums.get(j))){
    				return false;
        		}
    		}
    	}
    	
    	return true;
    }

	public static List<String> getMyAuthIds() {
		List<String> result = new ArrayList<String>();
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			authentication.getAuthorities().stream().forEach(a-> result.add(a.getAuthority()));
		} catch (Exception e) {
			log.warn("Not found Authorities, errorMsg[{}] {}", e.getMessage(), e);
		}
		return result;
	}

	/**
	 * 특정 권한이 있는지 체크한다. 에러가 발생해도 무시한다.
	 * @param authRole
	 * @return
	 */
	public static boolean hasAuth(String authRole) {
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			Collection<? extends GrantedAuthority> auths = authentication.getAuthorities();
			for (GrantedAuthority grantedAuthority : auths) {
				if(grantedAuthority.getAuthority().equalsIgnoreCase(authRole)) {
					return true;
				}
			}
		} catch (Exception e) {
			log.warn("Not found Authorities from [{}], errorMsg[{}] {}", authRole, e.getMessage(), e);
		}
		return false;
	}
	
	public static String phonNumAddZero(String phonNum){
		if(StringUtils.isEmpty(phonNum)){
			return phonNum;
		}
		String[] phonNumV = phonNum.split("-");
		StringBuffer temp = new StringBuffer();
		for(String index : phonNumV){
			StringBuffer numBuff = new StringBuffer();
			int size = index.length();
			if(size < 4){
				for(int i = 0 ;i < 4-size ; i++){
					numBuff.append("0");
				}
				numBuff.append(index);
				temp.append(numBuff.toString()) ;
			}else{
				temp.append(index);
			}
		}
		return temp.toString();
	}
	
	public static String formatKosPhoneNumber(String param){
		String result = "";
		if(StringUtils.isEmpty(param)){
			return param;
		}
		
		String inputValue = param.replaceAll("-", "");
		
		String areaCode = inputValue.substring(0, 2);
		String telNum	= inputValue.substring(2);
		
		if(!"00".equals(areaCode)){
			if("02".equals(areaCode)){
				areaCode = "00" + areaCode;
			}else{
				areaCode = "0" + areaCode;
			}
		}
		
		result = areaCode + telNum;
		
		if(result.length() == 11){
			areaCode 	= result.substring(0, 4);
			telNum		= result.substring(4);
			result = areaCode + "0" + telNum;
		}
		
		return result;
	}

}
