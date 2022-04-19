package kr.co.itcall.jte.spring.config.security.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import kr.co.itcall.jte.util.SecureRsaCripto;

public class JteAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		// 로그인 시도 실패에 대한 후 처리 및 로깅처리

		request.getSession().removeAttribute(SecureRsaCripto.RSA_DYNMIC_KEY);
		// request.setAttribute("username", request.getParameter("username"));
		request.getRequestDispatcher("/loginError").forward(request, response);

	}

}
