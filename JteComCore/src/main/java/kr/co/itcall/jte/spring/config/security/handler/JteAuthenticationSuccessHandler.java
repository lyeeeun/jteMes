package kr.co.itcall.jte.spring.config.security.handler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import jin.mes.form.devtol.userConn.UserConnDto;
import jin.mes.form.devtol.userConn.UserConnService;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.security.LoginUserService;
import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import kr.co.itcall.jte.spring.user.service.UserService;
import kr.co.itcall.jte.util.SecureRsaCripto;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class JteAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Autowired
	private UserConnService userConnService;

	@Resource
	private LoginUserService loginUserService;
	
	@Resource
	UserService userService;
	
	//	public JteAuthenticationSuccessHandler(String defaultTargetUrl, UserService userService) {
	//		setDefaultTargetUrl(defaultTargetUrl);
	//		super.setDefaultTargetUrl(defaultTargetUrl);
	//		this.userService = userService;
	//	}
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		// 로그인 성공에 대한 히스토리 및 페이지 이동처리를 한다.
		
		UserSessionInfoVo userSessionInfoVo = (UserSessionInfoVo)authentication.getPrincipal();

		UserConnDto userConnDto = null;
		//사용자 접속기록 등록 2020-06-15
		if(!userSessionInfoVo.getUserInfo().getUserId().equals("unkownUser")) {
			String userConnId = "";
			userConnDto = new UserConnDto(null, userSessionInfoVo.getUserInfo().getUserId(), null, null, null, JteUtils.getClientIp(),JteUtils.getUserDevice());
			userConnDto.setAction("C");
			userConnId = userConnService.setUserConn(userConnDto);
			request.getSession().setAttribute("session_id", userConnId);
			request.getSession().setAttribute("userConnDto", userConnDto);
			
			loginUserService.LOGIN_USER_IN_SERVER.put(request.getSession().getId(), userConnDto);
		}
		
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
			userService.setFailCntInitByUserId(user.getUserInfo().getUserId());
		}
		request.getSession().removeAttribute(SecureRsaCripto.RSA_DYNMIC_KEY);
//		String homeDir = "/home.do";
//		if(request.getSession().getAttribute("HomeDir") != null ||request.getSession().getAttribute("HomeDir") == "") {
//			homeDir = request.getSession().getAttribute("HomeDir").toString();
//		}
		
		//response.addHeader("lang", user.getUserInfo().getLangCd());
		//
		redirectStrategy.sendRedirect(request, response, "?lang="+user.getUserInfo().getLangCd());
		
		//super.onAuthenticationSuccess(request, response, authentication);
		//response.addHeader("lang", user.getUserInfo().getLangCd());
		//request.getRequestDispatcher("/").forward(request, response);
	}

}
