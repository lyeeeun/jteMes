package kr.co.itcall.jte.spring.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserSecurityServiceImpl implements UserSecurityService {
	@Autowired
	private UserDetailsService userDetailsService;

	@Autowired
	private AuthenticationManager authenticationManager;

	@Override
	public String findLoggedInUsername() {
		Object userDetails = SecurityContextHolder.getContext().getAuthentication().getDetails();
		if (userDetails instanceof UserDetails) {
			return ((UserDetails) userDetails).getUsername();
		}
		return null;
	}

	@Override
	public void autologin(String username, String password) {
		UserDetails userDetails = userDetailsService.loadUserByUsername(username);
		UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
				userDetails, password, userDetails.getAuthorities());
		// SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);

		log.info("회원가입 성공 후 자동 로그인처리 ::: 사용자정보[{}]", userDetails);

//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		
		authenticationManager.authenticate(usernamePasswordAuthenticationToken);

//		authentication = SecurityContextHolder.getContext().getAuthentication();

		if (usernamePasswordAuthenticationToken.isAuthenticated()) {
			SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
			log.info("Auto login[{}]/[{}] successfully!", username, password);
		}
	}
}
