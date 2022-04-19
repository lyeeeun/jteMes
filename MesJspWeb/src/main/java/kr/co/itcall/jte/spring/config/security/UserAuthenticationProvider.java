package kr.co.itcall.jte.spring.config.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class UserAuthenticationProvider implements AuthenticationProvider {

//	@Autowired
	private LoginUserService loginUserService;

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// 입력받은 id, pw 저장할 변수 선언
				String userId = (String)authentication.getPrincipal();
				String userPw = (String)authentication.getCredentials();
				
				// user 정보를 저장할 변수 선언
				loginUserService.setUserPw(userPw);

				List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
				if(!userId.equals("guest")){
					roles.add(new SimpleGrantedAuthority("ROLE_USER"));
				}
				UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(userId, userPw, roles);
				
				return result;
	}



}
