package kr.co.itcall.jte.spring.config.web.filter.wrapper;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class WebLoggingHttpServletResponseWrapper extends HttpServletResponseWrapper {

	public WebLoggingHttpServletResponseWrapper(HttpServletResponse response) {
		super(response);
		// TODO Auto-generated constructor stub
		// 응답정보의 로깅등을 하는 곳.
	}

}
