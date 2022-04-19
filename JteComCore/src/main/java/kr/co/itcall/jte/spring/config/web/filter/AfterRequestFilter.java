package kr.co.itcall.jte.spring.config.web.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.filter.OncePerRequestFilter;

import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.security.LoginUserService;
import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import kr.co.itcall.jte.spring.config.security.type.PermitSvcList;
import kr.co.itcall.jte.spring.config.web.filter.wrapper.WebLoggingHttpServletRequestWrapper;
import kr.co.itcall.jte.spring.config.web.filter.wrapper.WebLoggingHttpServletResponseWrapper;
import kr.co.itcall.jte.spring.user.JteUserUtil;
import kr.co.itcall.jte.spring.user.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component("afterRequestFilter")
public class AfterRequestFilter extends OncePerRequestFilter {

	@Autowired
	private UserRepository userRepository;

//	@Autowired
//	private LocaleResolver localeResolver;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
		/** 로깅처리는 FilterBefore에서 별도 구현해서 처리한다. 여기서는 예제로 일단 넣어둠. **/
		WebLoggingHttpServletRequestWrapper httpServletRequestWrapper = new WebLoggingHttpServletRequestWrapper(request);
		WebLoggingHttpServletResponseWrapper httpServletResponseWrapper = new WebLoggingHttpServletResponseWrapper(response);
		
		ServletWebRequest servletWebRequest = new ServletWebRequest(httpServletRequestWrapper, httpServletResponseWrapper);
		
		try {
			String localeParam = request.getParameter("lang");
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			if(authentication!=null && authentication.getPrincipal()!=null && !authentication.getPrincipal().equals("anonymousUser")){
				log.debug("로그인하여 유효세션을 취득한 사용자. userId[{}], userName[{}]", JteUserUtil.getUserInfo().getUsername(), JteUserUtil.getUserInfo().getUserInfo().getUserNm()/* authentication.getPrincipal() */);
				UserSessionInfoVo userSessionInfoVo = JteUserUtil.getUserInfo();
				if(!StringUtils.isEmpty(userSessionInfoVo)) {
					
					String sessionId = request.getSession().getId();
//					synchronized (LoginUserService.LOGIN_USER_IN_SERVER) {
//						if(!StringUtils.isEmpty(sessionId) && StringUtils.isEmpty(LoginUserService.LOGIN_USER_IN_SERVER.get(sessionId))) {
//							LoginUserService.LOGIN_USER_IN_SERVER.put(request.getSession().getId(), userSessionInfoVo.getUserConnDto());
//						}
//					}
					/******************************************************************************************
					 * 실제 여기서는 다중서버가 구축되어 있으면 
					 * ㅇ. 사전에 ::: 세션정보 취득 시점에 세션ID등의 고유키와 사용자ID, 세션유효시각을 DB로 저장하고.
					 * ㅇ. 여기서 ::: DB에서 세션정보를 읽어와서 유효한지 확인하고 넘어간다. - 유효하지 않으면 로그아웃 처리 해야한다.
					 * ㅇ. 다중 서버인 경우 필수적으로 고안해서 구현해야 한다.
					 * ㅇ. 단일서버인 경우 서버자체가 세션정보를 들고있으며, 체결된 서버에게만 요청하므로 별도 인증세션 DB가 필요없지만...
					 * 
					 ******************************************************************************************/
					if( System.currentTimeMillis() < userSessionInfoVo.getLastConTime() + 60 * 60 * 1000) {
						// 정상처리
						//request.getRequestURI()
						log.info("요청 URL : [{}]",request.getRequestURI());
						userSessionInfoVo.setLastConTime(System.currentTimeMillis());
					} else {
						// 로그아웃 처리.세션아웃.
					}
					/*** UI에서 문자셋 변경요청이 오면 세션의 User정보와 다르면 저장하고 DB에도 업데이트 해준다. 향후 로그인 시 적용되도록 한다. 로그인 성공한 경우만 가능하다. ***/
					if(!StringUtils.isEmpty(localeParam) && !localeParam.equals(userSessionInfoVo.getUserInfo().getLangCd())) {
						try {
							userRepository.updateLangCdByUserId( localeParam, userSessionInfoVo.getUserInfo().getUserId());
							userSessionInfoVo.getUserInfo().setLangCd(localeParam);
						} catch (Exception e) {
							log.error("언어속성을 사용자정보에 반영하지 못했습니다. userId[{}], langCd[{}], error[{}], {}", userSessionInfoVo.getUserInfo().getUserId(), localeParam, e.getMessage(), e);
						}
					}
				}
			} else {
				if(authentication!=null && authentication.getPrincipal()!=null)
					log.debug("로그인 하지 않은 사용자 세션.[{}]", authentication.getPrincipal());
			}
			// servletWebRequest를 가지고 요청지 및 요청자정보에 따라 보안처리 reject등을 하는 처리를 서비스 기동전에 처리한다.
			
			/*** UI에서 문자셋 변경요청이 오면 요청 커넥션에 대해서 변경해준다. ***/
			if(!StringUtils.isEmpty(localeParam)) {
				log.debug("request Locale[{}], parameter[lang:{}]", request.getLocale(), localeParam);
				log.debug("localeResolver.resolveLocale(request) change before = [{}]", JteUtils.getMyLocale()/*localeResolver.resolveLocale(request)*/);
				JteUtils.setMyLocale(localeParam); // localeResolver.setLocale(request, response, new Locale(localeParam));
				log.debug("localeResolver.resolveLocale(request) changed... = [{}]", JteUtils.getMyLocale()/*localeResolver.resolveLocale(request)*/);
			}
			
			log.debug("Try to starting user request : requestInfo【{}】, userId[{}]", request.getRequestURL(), JteUtils.getUserId());
			filterChain.doFilter(httpServletRequestWrapper, httpServletResponseWrapper);
			response.flushBuffer();
		} finally {
			log.debug("Try to Ending user response : responseInfo【{}】", response);
		}
	}

}
