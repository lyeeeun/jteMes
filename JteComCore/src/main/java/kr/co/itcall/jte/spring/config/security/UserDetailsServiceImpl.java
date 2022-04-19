package kr.co.itcall.jte.spring.config.security;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import jin.mes.common.menu.MenuService;
import jin.mes.form.basMgt.authMgt.authInfo.AuthInfoModel;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.spring.user.service.UserService;
import kr.co.itcall.jte.util.SecureRsaCripto;
import lombok.extern.slf4j.Slf4j;

@Slf4j
//@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserService userService;
	@Resource
	protected MessageSourceAccessor messageSourceAccessor;
	@Autowired
	private MenuService menuService;

	@Value("#{app['secure.rsa.use.yn']?:'N'}")
	private String rsaUseYn;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

////		String password = user.getPassword();
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
		Locale locale = JteUtils.getMyLocale(); // Locale.getDefault();
		try {
			username = SecureRsaCripto.getRsaDecodeFromSession(username, this.rsaUseYn);
			// SecurityContext secContext = SecurityContextHolder.getContext();
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			log.debug("locale change [{}] to [{}]", request.getLocale(), locale);
			log.debug("HttpServletRequest[{}]", request);
			log.debug("Client IpAddress[{}]", JteUtils.getClientIp());
			((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().setAttribute("username", username);
		} catch (Exception e) {
			log.warn("RSA Decode Error username[{}]", username);
		}


		/***********  사용자id 확인  : 정상 사용자에 대한 로그인 처리... ***********/
		// UserInfoVo user = userService.findByUserId(username);
		UserInfoVo user = userService.findByUserIdFromAll(username);

		/***********  사용자id 존재 확인  ***********/
		if(StringUtils.isEmpty(user)) {
			throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.user.invalid", username.split(","), locale));
		} else if(user.isDel()) {
			throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.user.delete", username.split(","), locale));
		} else if(user.isLock()) {
			throw new InternalAuthenticationServiceException(messageSourceAccessor.getMessage("login.error.user.lock", username.split(","), locale));
		}

		/*** 메시지 언어 설정 ***/
		if(!StringUtils.isEmpty(user.getLangCd()) && !locale.getLanguage().equals(user.getLangCd())) {

			/*** 로그인시에는 어떤 언어로 접근했던... 로그인 완료되면 사용자 정보에 기 저장된 언어정보를 적용해준다. ***/
			JteUtils.setMyLocale(user.getLangCd());

			/*** 로직변경 로그인 성공시점엔 원복하는 것으로... => UI에서 문자셋 변경요청이 오면 세션의 User정보와 다르면 저장하고 DB에도 업데이트 해준다. ***/
//			user.setLangCd(locale.getLanguage());
//			int setCnt = userService.setLangCdByUserId(locale, username);
//			log.debug("Locale changed to [{}], userId[{}], setResult[{}]", locale, username, setCnt);
		}

		List<String> roleGrpIds = new ArrayList<String>();
		Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
		List<AuthInfoModel> authInfoList = new ArrayList<AuthInfoModel>();
		List<String> authIdList = new ArrayList<String>();
//		for (RoleInfoVo role : user.getRoles()) {
//			for (AuthInfoModel authInfo : role.getAuthInfos()) {
//				grantedAuthorities.add(new SimpleGrantedAuthority(authInfo.getAuthId()));
//				authInfoList.add(authInfo);
//				authIdList.add(authInfo.getAuthId());
//			}
//			// grantedAuthorities.add(new SimpleGrantedAuthority(role.getRoleId()));
//		}

		/********
		 * 중복권한그룹을 소유한 케이스인 경우. 해당 중복된 기본권한들은 한 개만 추춣하여 세션에 저장한다.
		 */
//		user.getRoles().stream().filter(r-> !StringUtils.isEmpty(r)).forEach(r-> {
//			r.getAuthInfos().stream().filter(a-> !StringUtils.isEmpty(a)).forEach(a-> {
//				if(!authIdList.contains(a.getAuthInfo().getAuthId())) {
//					grantedAuthorities.add(new SimpleGrantedAuthority(a.getAuthInfo().getAuthId()));
//					authInfoList.add(a.getAuthInfo());
//					authIdList.add(a.getAuthInfo().getAuthId());
//				}
//			});
//			roleGrpIds.add(r.getRoleId());
//		});

		UserSessionInfoVo userSessionInfo = new UserSessionInfoVo(username,user.getPassword(),true,true,true,true,grantedAuthorities);
		// return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), grantedAuthorities);

		// 세션에 필요한 정보를 담는다.
		userSessionInfo.setUserInfo(user);
		userSessionInfo.setRoleGrpIds(roleGrpIds);
		userSessionInfo.setAuthInfoIds(authIdList);
		userSessionInfo.setAuthInfoModels(authInfoList);
		//userSessionInfo.setMyMenuVos(menuService.getMyMenuList(user));

		// 사용자에게 처음 열릴 기본메뉴를 셋팅한다. // 업무로직에 따라 입력할 수 있게 한다.
		//userSessionInfo.setDefMenu(userSessionInfo.getMyMenuVos().stream().filter(m-> m.getMenuCd().equals("F")).findFirst().get()); // 기본적으로 최초 조회되는 "/form/home" 화면을 셋팅해준다.

		// Spring.Security에서 제공되는 사용자 세션에 사용자정보를 확장하여 계속 넣어줄 수 있으며, 로그인 된 화면에서 꺼내 사용할 수 있다.
		userSessionInfo.setIsMoreInfos("Spring.Security에서 제공되는 사용자 세션에 사용자정보를 확장하여 계속 넣어줄 수 있으며, 로그인 된 화면에서 꺼내 사용할 수 있다.");

		return userSessionInfo;
	}




}
