package kr.co.itcall.jte.spring.config.web.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.filter.OncePerRequestFilter;

import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.web.filter.wrapper.WebLoggingHttpServletRequestWrapper;
import kr.co.itcall.jte.spring.config.web.filter.wrapper.WebLoggingHttpServletResponseWrapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component("afterRequestFilter")
public class AfterRequestFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
		/** 로깅처리는 FilterBefore에서 별도 구현해서 처리한다. 여기서는 예제로 일단 넣어둠. **/
		WebLoggingHttpServletRequestWrapper httpServletRequestWrapper = new WebLoggingHttpServletRequestWrapper(request);
		WebLoggingHttpServletResponseWrapper httpServletResponseWrapper = new WebLoggingHttpServletResponseWrapper(response);
		
		ServletWebRequest servletWebRequest = new ServletWebRequest(httpServletRequestWrapper, httpServletResponseWrapper);
		
		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if(authentication!=null && authentication.getPrincipal()!=null && !authentication.getPrincipal().equals("anonymousUser")){
				log.debug("로그인하여 유효세션을 취득한 사용자.[{}]", authentication.getPrincipal());
				/******************************************************************************************
				 * 실제 여기서는 다중서버가 구축되어 있으면 
				 * ㅇ. 사전에 ::: 세션정보 취득 시점에 세션ID등의 고유키와 사용자ID, 세션유효시각을 DB로 저장하고.
				 * ㅇ. 여기서 ::: DB에서 세션정보를 읽어와서 유효한지 확인하고 넘어간다. - 유효하지 않으면 로그아웃 처리 해야한다.
				 * ㅇ. 다중 서버인 경우 필수적으로 고안해서 구현해야 한다.
				 * ㅇ. 단일서버인 경우 서버자체가 세션정보를 들고있으며, 체결된 서버에게만 요청하므로 별도 인증세션 DB가 필요없지만...
				 * 
				 ******************************************************************************************/
			} else {
				if(authentication!=null && authentication.getPrincipal()!=null)
					log.debug("로그인 하지 않은 사용자 세션.[{}]", authentication.getPrincipal());
			}
			// servletWebRequest를 가지고 요청지 및 요청자정보에 따라 보안처리 reject등을 하는 처리를 서비스 기동전에 처리한다.
			
			log.debug("Try to starting user request : requestInfo【{}】, user[{}]", request.getRequestURL(), JteUtils.getUserId());
			filterChain.doFilter(httpServletRequestWrapper, httpServletResponseWrapper);
			response.flushBuffer();
		} finally {
			log.debug("Try to Ending user response : responseInfo【{}】", response);
		}
	}

}
