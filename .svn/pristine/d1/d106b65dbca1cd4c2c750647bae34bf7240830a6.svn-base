package kr.co.itcall.jte.spring.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import kr.co.itcall.jte.spring.config.security.type.RoleBaseCd;
import kr.co.itcall.jte.spring.config.security.type.RoleUserCd;
import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.spring.user.service.UserSecurityService;
import kr.co.itcall.jte.spring.user.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private UserSecurityService userSecurityService;

	@RequestMapping(value = "/main")
	public String main() {
		log.info("AccessUser : [{}]", JteUtils.getUserId());
		log.info("Created Object for model : [{}]", new RoleInfoVo());
		RoleInfoVo vo = new RoleInfoVo();
		return "main";
	}

	// 회원가입폼
	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public String registration(Model model) {
		model.addAttribute("userForm", new UserInfoVo());
		model.addAttribute("roles", RoleBaseCd.getRoles());
		model.addAttribute("userRoles", RoleUserCd.getAllUserRoles());
		return "login/registration";
	}

	// 회원가입 처리 후 로그인
	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registration(@ModelAttribute("userForm") UserInfoVo userForm, BindingResult bindingResult,
			Model model, String[] roles) {
		String password = userForm.getPassword();
		/*** 최초 사용자 요청에 의해서 입력되는 사용자는 Lock을 걸어서 사용못하게 한다. 이후 관리자가 Lock을 풀어야 사용할 수 있다. ***/
		userForm.setLock(true);
		if(userService.findByUserIdFromAll(userForm.getUserId())==null) {
			 // 등록된 사용자가 존재하지 않으면 신규로 생성한다. 기존 생성된 사용자에 대해서 수행하면 업데이트 된다.
			userService.saveUser(userForm, roles);
		}
		userSecurityService.autologin(userForm.getUserId(), password);
		return "redirect:/main";
	}

	// root 사용자 테스트
	@RequestMapping("/api/root")
	public String root() {
		return "root/root";
	}

	// admin 사용자 테스트
	@RequestMapping("/api/admin")
	public String admin() {
		return "admin/admin";
	}

	// user 사용자 테스트
	@RequestMapping("/api/user")
	public String user() {
		return "user/user";
	}

	// 사용자권한이 있으면서, 특정권한이 존재하면 수행한다.(사용자권한 url 내부에 존재하므로...)
	@PreAuthorize(("hasAnyAuthority('ROLE_SOME_AUTH', 'ROLE_SOME_AUTH_WRITE')"))
	@RequestMapping("/api/user/someone")
	public String hasAuthority() {
		return "user/someone";
	}

	// 권한없는 페이지를 들어갔을때
	@RequestMapping("/error/403")
	public String access() {
		return "error/access";
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/myInfo"}, method = RequestMethod.POST , produces = {"application/json"})
	public Map<String,Object> myInfo(HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserSessionInfoVo userSessionInfoVo = (UserSessionInfoVo)authentication.getPrincipal();

		Map<String,Object> result = new HashMap<String,Object>();
//		ImmutableMap.Builder<String,Object> builder = ImmutableMap.builder();
//		builder.put("user", userSessionInfoVo);
//		builder.put("menu", menuCacheService.getAllMyMenu());
//		return builder.build();
		result.put("user", userSessionInfoVo);
//		result.put("menu", menuCacheService.getAllMyMenu());
//		if(user!=null && user.getDefMenuSvcUrl()!=null) {
//			result.put("defMenu", MenuCacheService.getMenuByUrl(user.getDefMenuSvcUrl()));
//		}else {
//			result.put("defMenu", MenuCacheService.getMenuByUrl("/custCont/contract/contractForm"));
//			// result.put("defMenuId", "1100"); // 특정 작업이 없는한 청약화면을 기본화면으로 한다.
//		}
//		result.put("code", codeCacheService.getAllCode()); // codeCacheService.getCacheData()); // 통합용 코드만 읽어온다.
		return result;
	}

}
