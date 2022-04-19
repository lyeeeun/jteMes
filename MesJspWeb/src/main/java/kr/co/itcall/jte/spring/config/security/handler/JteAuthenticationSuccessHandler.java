package kr.co.itcall.jte.spring.config.security.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import kr.co.itcall.jte.util.SecureRsaCripto;

public class JteAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		// 로그인 성공에 대한 히스토리 및 페이지 이동처리를 한다.

		
//		SavedRequest savedRequest = (SavedRequest) request.getSession().getAttribute("SPRING_SECURITY_SAVED_REQUEST");
//		response.setCharacterEncoding("utf-8");
//		response.setContentType("application/json");
//		Map<String,String> jsonBean = new HashMap<String,String>();
//		jsonBean.put("code", "0");
//		jsonBean.put("message", "SUCCESS");
//		if(savedRequest == null) {
//			jsonBean.put("redirectUrl", request.getContextPath() + super.determineTargetUrl(request, response));
//	
//		} else{
//			jsonBean.put("redirectUrl", savedRequest.getRedirectUrl());
//		}
//		ObjectMapper mapper = new ObjectMapper();
//		response.getWriter().write(mapper.writeValueAsString(jsonBean));
		UserSessionInfoVo user = null;
		if(authentication != null){
			user = (UserSessionInfoVo)authentication.getPrincipal();
		}
		request.getSession().removeAttribute(SecureRsaCripto.RSA_DYNMIC_KEY);
//		String homeDir = "/home.do";
//		if(request.getSession().getAttribute("HomeDir") != null ||request.getSession().getAttribute("HomeDir") == "") {
//			homeDir = request.getSession().getAttribute("HomeDir").toString();
//		}
		
		
		redirectStrategy.sendRedirect(request, response, "?lang="+user.getUserInfo().getLangCd());
		
	}

}
