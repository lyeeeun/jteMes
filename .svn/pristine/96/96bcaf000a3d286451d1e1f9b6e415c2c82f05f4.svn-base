package kr.co.itcall.jte.spring.config.security;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

//@Component
public class UserAuthenticationProvider implements AuthenticationProvider {

//	@Autowired
//	UserService userService;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
//		String email = authentication.getName();
//
//		UserInfoVo userInfoVo = userService.authenticate(email, password);
//		if (userInfoVo == null)
//			throw new BadCredentialsException("Username not found !!");
//
//		String rawPassword = (String) authentication.getCredentials();
//
//		if (!passwordEncoder.matches(rawPassword, userInfoVo.getPassword()))
//			throw new new UsernameNotFoundException("Do not matches password !!");
//
//		userInfoVo.setPassword(null);
//
//		ArrayList<SimpleGrantedAuthority> authorities = new ArrayList<>();
//		authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
//
//		return new UsernamePasswordAuthenticationToken(userInfoVo, null, authorities);
		return null;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
