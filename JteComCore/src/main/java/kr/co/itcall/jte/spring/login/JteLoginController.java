package kr.co.itcall.jte.spring.login;

import java.io.IOException;
import java.rmi.ServerException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;
import kr.co.itcall.jte.spring.user.JteUserUtil;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.spring.user.service.UserSecurityService;
import kr.co.itcall.jte.spring.user.service.UserService;
import kr.co.itcall.jte.util.SecureRsaCripto;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class JteLoginController{

	@Autowired
	private UserSecurityService userSecurityService;
	
	@Autowired
	private UserService userService;

	@Value("#{app['secure.rsa.use.yn']?:'N'}")
	private String rsaUseYn;

	// 로그인
	@RequestMapping("/login")
	public ModelAndView login(ModelAndView model, HttpServletRequest request, HttpServletResponse response) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException {
		
		if(!StringUtils.isEmpty((String)request.getSession().getAttribute("loginMsg"))) {
			model.addObject("loginMsg", (String)request.getSession().getAttribute("loginMsg"));
		}
		
		model.setViewName("tlf/login/login");
		
//		HttpSession session = request.getSession(true);
//		try {
//			
//			Authentication authentication2 = SecurityContextHolder.getContext().getAuthentication();
//
//			System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
//			
//			System.out.println(authentication2.getPrincipal());
//			
//			System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
//			
//			if(!authentication2.getPrincipal().equals("anonymousUser")) {
//				
//				RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
//				//model.setViewName("/");
//				redirectStrategy.sendRedirect(request, response, "/");
//				//, "?lang="+authentication2..getPrincipal().getUserInfo().getLangCd()
//			}
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
		
		SecureRsaCripto.initRsaSession(this.rsaUseYn);
		
		return model;
	}
		
	// 로그인 실패시
	@RequestMapping(value = "/loginError")
	public ModelAndView loginError(ModelAndView model) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException {
		model.addObject("loginMsg", "Your username and password is invalid.");
		try {
			String username = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getAttribute("username").toString();
			String userId = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getParameter("id");
			
			UserInfoVo userInfo = userService.findByUserId(userId, false);
			if(userInfo != null) {
				if(userInfo.isLock()) {
					model.addObject("loginMsg", "잠금처리된 계정입니다. 관리자에게 문의해주세요.");
				}else {
					userService.setFailCntByUserId(userId);
					model.addObject("loginMsg", "로그인을 (5 / " + ((int)userInfo.getFailCnt() + 1)  + ")회 실패하셨습니다. 5회 이후 잠금처리됩니다.");
				}
			}else {
				model.addObject("loginMsg", "존재하지 않는 아이디입니다.");
			}
			
			model.setViewName("tlf/login/login");
		} catch (Exception e) {
			log.warn("실패된 로그인시도의 로그인ID를 찾을수없습니다.[{}] : {}", e.getMessage(), e);
		}
		SecureRsaCripto.initRsaSession(this.rsaUseYn);
		return model;
	}

	/**
	 * http://192.168.2.62:8090/loginProcessAuto?id=khaeng&pw=1q2w3e~!@
	 */
	// 수동로그인 처리
	@RequestMapping(value = "/loginProcessAuto")
	public String loginProcess(HttpServletRequest request, HttpServletResponse response, Model model, String id, String pw)  throws Exception  {
		return userSecurityService.autologin(request, response, model, id, pw);
	} 

//	@PostMapping(value = "/loginProcess")
//	public ModelAndView loginProcess(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
//		request.setAttribute(View.RESPONSE_STATUS_ATTRIBUTE, HttpStatus.TEMPORARY_REDIRECT);
//		return new ModelAndView("redirect:/login_post");
//	}

}
