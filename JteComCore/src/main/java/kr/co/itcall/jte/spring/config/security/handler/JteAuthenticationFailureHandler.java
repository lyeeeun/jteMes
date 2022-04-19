package kr.co.itcall.jte.spring.config.security.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import kr.co.itcall.jte.util.SecureRsaCripto;

@Component
public class JteAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		// 로그인 시도 실패에 대한 후 처리 및 로깅처리

		String loginMsg = null;
		
		if(exception instanceof BadCredentialsException) {
			loginMsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
		} else if(exception instanceof InternalAuthenticationServiceException) {
			if(exception.getMessage() == "login.error.user.lock") {
				loginMsg = "해당 사용자는 잠긴 사용자입니다. 관리자에게 문의하시기 바랍니다.";
			}
		}
			
		request.setAttribute("loginMsg", loginMsg);

		request.getSession().removeAttribute(SecureRsaCripto.RSA_DYNMIC_KEY);
		
		request.getRequestDispatcher("/loginError").forward(request, response);

	}

}
