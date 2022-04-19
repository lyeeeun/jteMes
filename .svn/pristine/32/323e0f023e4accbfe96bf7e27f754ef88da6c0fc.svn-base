package kr.co.itcall.jte.spring.login;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itcall.jte.spring.user.service.UserSecurityService;
import kr.co.itcall.jte.util.SecureRsaCripto;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class JteLoginController{

	@Autowired
	private UserSecurityService userSecurityService;

	@Value("#{app['secure.rsa.use.yn']?:'N'}")
	private String rsaUseYn;

	// 로그인
	@RequestMapping("/login")
	public ModelAndView login(ModelAndView model, String error, String logout, HttpServletRequest request) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException {
		if (logout != null) {
			model.addObject("logout", "You have been logged out successfully.");
		}
		if(!StringUtils.isEmpty((String)request.getSession().getAttribute("logoutMsg"))&&request.getSession().getAttribute("logoutMsg").equals("sessionOut")) {
			model.addObject("logoutMsg", "sessionOut");
		}
		
		model.setViewName("tlf/login/login");
		
		
		SecureRsaCripto.initRsaSession(this.rsaUseYn);
		
		return model;
	}

	// 로그인 실패시
	@RequestMapping(value = "/loginError")
	public String loginError(Model model) throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException {
		model.addAttribute("error", "Your username and password is invalid.");
		try {
			String username = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest().getAttribute("username").toString();
			model.addAttribute("username", username);
		} catch (Exception e) {
			log.warn("실패된 로그인시도의 로그인ID를 찾을수없습니다.[{}] : {}", e.getMessage(), e);
		}
		SecureRsaCripto.initRsaSession(this.rsaUseYn);
		return "tlf/login/login";
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
