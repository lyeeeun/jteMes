package kr.co.itcall.jte.spring.config.security.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

public class JteLogoutSuccessHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

		// 접속종료 등의 히스토리성 처리와 위치이동을 처리한다.
//		String ajaxHeader = request.getHeader("X-Requested-With")==null?"":request.getHeader("X-Requested-With");
//		
//		if(authentication != null){
//			ConnectionLogDto connectionLogDto = new ConnectionLogDto();
//			UserInfo user = (UserInfo)authentication.getPrincipal();
//			connectionLogDto.setUserId(user.getUsername());
//			connectionLogDto.setConnDivCd("02");
//			connectionLogDto.setUseSysDivCd("ONM");
//			connectionLogDto.setUserIp(BizUtil.getClientIp());
//			connectionLogService.add(connectionLogDto);
//		}
//		
//		if("XMLHttpRequest".equals(ajaxHeader)){
//			response.setStatus(HttpStatus.SC_UNAUTHORIZED);
//			response.setCharacterEncoding("utf-8");
//			response.setContentType("application/json");
//			Map<String,String> jsonBean = new HashMap<String,String>();
//			ObjectMapper mapper = new ObjectMapper();
//			response.getWriter().write(mapper.writeValueAsString(jsonBean));
//		}else{
//			setDefaultTargetUrl("/login");
//
//	        super.onLogoutSuccess(request, response, authentication);       
//		}
	}

}
