package kr.co.itcall.jte.spring.login;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import kr.co.itcall.jte.spring.user.service.UserSecurityService;
import kr.co.itcall.jte.util.SecureRsaCripto;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {

	@Autowired
	private UserSecurityService userSecurityService;

	@Value("#{app['secure.rsa.use.yn']?:'N'}")
	private String rsaUseYn;

	// 로그인
	@RequestMapping("/login")
	public String login(Model model, String error, String logout, HttpServletRequest request) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException {
		if (logout != null) {
			model.addAttribute("logout", "You have been logged out successfully.");
		}
		SecureRsaCripto.initRsaSession(this.rsaUseYn);
		return "login/login";
	}

	// 로그인 실패시
	@RequestMapping(value = "/loginError")
	public String loginError(Model model) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException {
		model.addAttribute("error", "Your username and password is invalid.");
		try {
			String username = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getAttribute("username").toString();
			model.addAttribute("username", username);
		} catch (Exception e) {
		}
		SecureRsaCripto.initRsaSession(this.rsaUseYn);
		return "login/login";
	}

//	// 수동로그인 처리
//	@RequestMapping(value = "/loginProcess")
//	public String loginProcess(HttpServletRequest request, HttpServletResponse response, Model model, String username) throws Exception {
//		UserInfoVo user = SecureRsaCripto.getRsaDecodeFromSession(username);
//		request.setAttribute("username", user.getUserId());
//		request.setAttribute("password", user.getPassword());
//		userSecurityService.autologin(user.getUserId(), user.getPassword());
//		request.getSession().removeAttribute(SecureRsaCripto.RSA_DYNMIC_KEY);
//		
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		log.debug("after loginProcess[{}]", authentication.getPrincipal());
//		
//		return "redirect:/main";
//	}

	@PostMapping(value = "/loginProcess")
	public ModelAndView loginProcess(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		request.setAttribute(View.RESPONSE_STATUS_ATTRIBUTE, HttpStatus.TEMPORARY_REDIRECT);
		return new ModelAndView("redirect:/login_post");
	}

}
