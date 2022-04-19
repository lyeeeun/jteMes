package kr.co.itcall.jte.spring.config;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.security.web.authentication.switchuser.SwitchUserFilter;

import kr.co.itcall.jte.spring.config.security.handler.JteAccessDeniedHandler;
import kr.co.itcall.jte.spring.config.security.handler.JteAuthenticationFailureHandler;
import kr.co.itcall.jte.spring.config.security.handler.JteAuthenticationSuccessHandler;
import kr.co.itcall.jte.spring.config.security.handler.JteLogoutSuccessHandler;
import kr.co.itcall.jte.spring.config.security.type.PermitStaticList;
import kr.co.itcall.jte.spring.config.security.type.PermitSvcList;
import kr.co.itcall.jte.spring.config.web.filter.AfterRequestFilter;
import kr.co.itcall.jte.spring.config.web.filter.HtmlRequestTagFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled=true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Value("#{biz['session.duplicated.max.count']?:'1'}") // 동일ID 중복접속자 허용 수 //  테스트를 위함.
	private int sessionDuplicatedMaxCount;
	@Value("${session.max.cnt:0}") // 동일ID 중복접속자 허용 수 //  테스트를 위함.
	private int sessionDuplicatedMaxCountByCmd;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private UserDetailsService userDetailsService;

	@Resource
	private HtmlRequestTagFilter htmlRequestTagFilter;

	@Resource
	private AfterRequestFilter afterRequestFilter;

	@Override
	public void configure(WebSecurity web) throws Exception
	{
		web.ignoring().antMatchers(PermitStaticList.toArray());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		int sessionDuplicatedMaxCount = sessionDuplicatedMaxCountByCmd>0 ? sessionDuplicatedMaxCountByCmd : this.sessionDuplicatedMaxCount;

		http.authorizeRequests()
				.antMatchers(PermitSvcList.toArray()).permitAll()
				.antMatchers("/root/**").hasRole("ROOT")
				.antMatchers("/admin/**").hasRole("ADMIN")
				.antMatchers("/manager/**").hasRole("MANAGER")
				.antMatchers("/member/**").authenticated()
				.anyRequest().authenticated();

		http.formLogin().loginPage("/login") // default
				// 아래부분은 구현해야할지 테스트해봐야 한다.
				.loginProcessingUrl("/loginProcess").failureUrl("/loginError?error") // default
				.defaultSuccessUrl("/").usernameParameter("id").passwordParameter("pw")
				.successHandler(new JteAuthenticationSuccessHandler()) // 로그인 성공 핸들러
				.failureHandler(new JteAuthenticationFailureHandler()) // 로그인 실패 핸들러
				.permitAll();

		http.logout().logoutUrl("/logout") // default
				.logoutSuccessUrl("/login")
				.logoutSuccessHandler(new JteLogoutSuccessHandler())
				.invalidateHttpSession(false)//(false)
				.permitAll();

		http.exceptionHandling()
				.accessDeniedHandler(new JteAccessDeniedHandler());
				// .accessDeniedPage("/error/403?denied"); // 권한이 없을경우 해당 url로 이동

		// http.authenticationProvider(authenticationProvider); // 2번 호출되므로 configure에서 구현해줘야 한다.

		http.sessionManagement()
				// .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED) // default.
				.sessionCreationPolicy(SessionCreationPolicy.ALWAYS) // default.
				.sessionFixation()
				.newSession() // .migrateSession()
				.invalidSessionUrl("/login")
				.maximumSessions(sessionDuplicatedMaxCount)
				.expiredUrl("/login");

		http
				// .csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()).and()
				.csrf().disable() // 사용안함. CSRF 토큰없이 개발 // HTTP Status 403 - Expected CSRF token not found. Has your session expired
				.headers().frameOptions().sameOrigin().disable() // iframe 에러 // sameOrigin X-Frame-Options : DENY 에러 발생.
				// .addFilterBefore(webLoggingFilter, SwitchUserFilter.class)
				.addFilterBefore(htmlRequestTagFilter, SwitchUserFilter.class)
				.addFilterAfter(afterRequestFilter, SwitchUserFilter.class) // 세션이 정상적인지 체크하는 Filter 처리.
				// 필터에서 세션을 가져와서 저장되어있는 것인지 체크한다.
				// 참고. https://www.baeldung.com/spring-security-session
				// 로그인 처리 성공 시 세션을 생성해서 DB에 저장하여 사용기간동안 유지하고, 이외에는 reject처리할 사용자 필터를 만든다.
				.httpBasic()
				.authenticationEntryPoint(new LoginUrlAuthenticationEntryPoint("/login"));
				// Ajax호출시 페이지만료에 의한 로그아웃처리를 하려면 별도 구현할 수도 있다.
	}

	/***********************************************************************************
	 * <pre>
	 * 1. 개요 : 사용자로그인 처리및 자동 패스워드 매칭처리.
	 * 2. 처리내용 : 
	 * 		.userDetailsService(userDetailsService) 사용자로그인처리
	 * 		.passwordEncoder(passwordEncoder) 패스워드 자동매칭 처리
	 * 				==> (RSA 복호화 처리할경우.  implements PasswordEncoder 에서 별도 구현한다.)
	 * </pre>
	 * @Method : configureGlobal
	 * @param auth
	 * @throws Exception
	 */
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
	}

	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	// 직접 사용자를 인증하는 방법.
//	@Autowired
//	private UserAuthenticationProvider authenticationProvider;
//	
//	@Override
//	protected void configure(AuthenticationManagerBuilder auth) {
//		auth.authenticationProvider(authenticationProvider);
//	}

}