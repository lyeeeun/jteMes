package kr.co.itcall.jte.spring.config.security;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.spring.user.service.UserService;
import kr.co.itcall.jte.util.SecureRsaCripto;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserService userService;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Resource
	protected MessageSourceAccessor messageSourceAccessor;

	@Value("#{app['secure.rsa.use.yn']?:'N'}")
	private String rsaUseYn;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

////		String password = user.getPassword();
//		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//		String password = request.getParameter("password");
//		if(request.getAttribute("password")!=null) {
//			password = request.getAttribute("password").toString();
//		}
////		String password = request.getParameter("password");
//		log.debug("password[{}] == request.getAttribute(\"password\")[{}] == request.getParameter(\"password\")[{}]", password, request.getAttribute("password"), request.getParameter("password"));
//
//		UserInfoVo reqUser = null;;
//		try {
//			reqUser = SecureRsaCripto.getRsaDecodeFromSession(username, this.rsaUseYn);
//			username = reqUser.getUserId();
//			password = reqUser.getPassword();
//		} catch (Exception e) {
//			log.error("RSA Decode Error userId[{}], errorMsg[{}], errorLocalMsg[{}], errorInfo[{}]", username, e.getMessage(), e.getLocalizedMessage(), e.getCause());
//			throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.decode"));
//		}
		try {
			username = SecureRsaCripto.getRsaDecodeFromSession(username, this.rsaUseYn);
			((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().setAttribute("username", username);
		} catch (Exception e) {
			log.warn("RSA Decode Error username[{}]", username);
		}

		/* 자동로그인 처리할 수 있으므로 그경우에는 세션이 생성전이므로 null이 나온다. */
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		if(!authentication.getPrincipal().equals("anonymousUser")){
//			UserInfoVo userInfo = (UserInfoVo)authentication.getPrincipal();
//			String rawPassword = (String) authentication.getCredentials();
//		}

		/***********  패스워드와 사용자id 확인  : 정상 사용자에 대한 로그인 처리... ***********/

		UserInfoVo user = userService.findByUserId(username/* user.getUserId() */);

		/***********  사용자id 존재 확인  ***********/

		/***********  패스워드 일치 확인  ***********/
		if(user==null)
			throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.user.invalid"));
		// 패스워드 매칭처리는 .passwordEncoder(passwordEncoder); 설정으로 재구현 된곳에서 처리된다.
//		else if (!passwordEncoder.matches(password, user.getPassword()))
//			throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.password.invalid"));

		Set<GrantedAuthority> grantedAuthorities = new HashSet<>();

		for (RoleInfoVo role : user.getRoles()) {
			grantedAuthorities.add(new SimpleGrantedAuthority(role.getRoleId()));
		}

		UserSessionInfoVo userSessionInfo = new UserSessionInfoVo(username,user.getPassword(),true,true,true,true,grantedAuthorities);
		// return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), grantedAuthorities);

		// 세션에 필요한 정보를 담는다.
		userSessionInfo.setUserInfo(user);

		// Spring.Security에서 제공되는 사용자 세션에 사용자정보를 확장하여 계속 넣어줄 수 있으며, 로그인 된 화면에서 꺼내 사용할 수 있다.
		userSessionInfo.setIsMoreInfos("Spring.Security에서 제공되는 사용자 세션에 사용자정보를 확장하여 계속 넣어줄 수 있으며, 로그인 된 화면에서 꺼내 사용할 수 있다.");

		return userSessionInfo;
	}

}
