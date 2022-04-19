package kr.co.itcall.jte.spring.user.service;

import java.util.HashSet;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;

import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.util.SecureRsaCripto;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserSecurityService {

	@Autowired
	private UserService userService;

	@Autowired
	private AuthenticationManager authenticationManager;

	@Resource
	private MessageSourceAccessor messageSourceAccessor;

	@Value("#{app['secure.rsa.use.yn']?:'N'}")
	private String rsaUseYn;

	public String findLoggedInUsername() {
		Object userDetails = SecurityContextHolder.getContext().getAuthentication().getDetails();
		if (userDetails instanceof UserDetails) {
			return ((UserDetails) userDetails).getUsername();
		}
		return null;
	}

	public String autologin(HttpServletRequest request, HttpServletResponse response, Model model, String username, String password) throws Exception {
		try {
			username = SecureRsaCripto.getRsaDecodeFromSession(username, this.rsaUseYn);
			password = SecureRsaCripto.getRsaDecodeFromSession(password, this.rsaUseYn);
			UserInfoVo user = userService.findByUserId(username); // 정상적인 사용자만 조회한다.
			/***********  사용자id 존재 확인  ***********/
			if(StringUtils.isEmpty(user)) {
				throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.user.invalid", username.split(","), JteUtils.getMyLocale()));
			} else if(user.isDel()) {
				throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.user.delete", username.split(","), JteUtils.getMyLocale()));
			} else if(user.isLock()) {
				throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.user.lock", username.split(","), JteUtils.getMyLocale()));
			}
			HttpSession session = request.getSession(true);
			UserDetails ckUserDetails = new User(username, user.getPassword(), new HashSet<>());
			Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(ckUserDetails, password)); /*** 실제 로그인 처리 ***/
			if (authentication.isAuthenticated()) {
				SecurityContext securityContext = SecurityContextHolder.getContext();
				securityContext.setAuthentication(authentication);
				session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
			} else {
				throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.password.invalid", username.split(","), JteUtils.getMyLocale()));
			}
		} catch (BadCredentialsException | AccessDeniedException | InternalAuthenticationServiceException accessDeniedException) {
			response.setStatus(HttpStatus.UNAUTHORIZED.value());
			log.info("AccessDeniedHandler from [{}], {}", accessDeniedException.getMessage(), accessDeniedException);
			Object status = HttpStatus.UNAUTHORIZED.value();
			Object message = request.getAttribute(RequestDispatcher.ERROR_MESSAGE);
			Object trace = new StringBuffer().append(request.getAttribute(RequestDispatcher.ERROR_EXCEPTION_TYPE)).append("[").append(request.getAttribute(RequestDispatcher.ERROR_EXCEPTION)).append("]").toString();
			request.setAttribute(RequestDispatcher.ERROR_STATUS_CODE, status);
			request.setAttribute(RequestDispatcher.ERROR_MESSAGE, message);
			if("XMLHttpRequest".equals(JteUtils.getMyRequest().getHeader("X-Requested-With"))){
				model.addAttribute("code", status);
				model.addAttribute("message", message);
				model.addAttribute("error", message);
				model.addAttribute("trace", trace);
				return "jsonView";
			} else {
				return "redirect:/login";
			}
		}
		return "redirect:/";
	}
}
