package kr.co.itcall.jte.spring.config.security.handler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.itcall.jte.common.util.JteUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JteAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.info("AccessDeniedHandler from [{}], {}", accessDeniedException.getMessage(), accessDeniedException);
		request.setAttribute(RequestDispatcher.ERROR_STATUS_CODE, HttpStatus.UNAUTHORIZED.value());
		request.setAttribute(RequestDispatcher.ERROR_MESSAGE, 
				new StringBuffer().append(HttpStatus.UNAUTHORIZED.getReasonPhrase()).append("[").append(accessDeniedException.getMessage()).append("]").toString());

		if("XMLHttpRequest".equals(JteUtils.getMyRequest().getHeader("X-Requested-With"))){
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("code", request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE));
			resultMap.put("message", request.getAttribute(RequestDispatcher.ERROR_MESSAGE));
			ObjectMapper mapper = new ObjectMapper();
			response.getWriter().write(mapper.writeValueAsString(resultMap));
		} else {
			request.getRequestDispatcher("/error").forward(request, response);
		}
	}

}
