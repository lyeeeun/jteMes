package kr.co.itcall.jte.spring.config.web.filter.wrapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class WebLoggingHttpServletRequestWrapper extends HttpServletRequestWrapper {

	public WebLoggingHttpServletRequestWrapper(HttpServletRequest request) {
		super(request);
		// TODO Auto-generated constructor stub
		// 요청정보의 로깅등을 하는 곳...
	}

}
