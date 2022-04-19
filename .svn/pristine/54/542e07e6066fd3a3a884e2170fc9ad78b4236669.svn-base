package kr.co.itcall.jte.api;

import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itcall.jte.spring.config.security.UserSessionInfoVo;

@Controller
public class TestController {

	@RequestMapping("/")
	public String index(Model model, @RequestParam Map<String, Object> param) {
		model.addAttribute("name", "<SpringBoot from Test>");
		model.addAttribute("param", param);
		return "main";
	}
	
	@RequestMapping("/hello")
	public String hello(Model model, @RequestParam Map<String, Object> param) {
		model.addAttribute("name", "<SpringBoot from Test>");
		model.addAttribute("param", param);
		return "hello";
	}

	@RequestMapping("/hello2")
	public ModelAndView hello2(ModelAndView mv, @RequestParam Map<String, Object> param) {
		mv.addObject("name", "<SpringBoot from Test>");
		mv.addObject("param", param);
		mv.setViewName("hello");
		return mv;
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/hello3")
	public String hello3(@AuthenticationPrincipal UserSessionInfoVo userInfo, Model model) {
		String username = userInfo.getUsername(); 
		// .. find messages for this user and return them ... 
		model.addAttribute("userName", username);
		model.addAttribute("userInfo", userInfo.getUserInfo());
		return "hello";
	}


//	@Autowired
//	private PmsService pmsService;
//	@Autowired
//	private ComnCodeService comnCodeService;
//
//	@PostMapping("/api/user/testRest")
//	public ResponseEntity<Object> callTestRest(
//			@PageableDefault(
//					// sort = { "plateNo","nationId","companyId","areaId","engineModel" }
//					sort = { "pmsPartDtlPk.plateNo","pmsPartDtlPk.nationId","pmsPartDtlPk.companyId","pmsPartDtlPk.areaId","pmsPartDtlPk.engineModel" }
//					, direction = Direction.ASC, page = 0, size = 10) Pageable pageable
//			, ModelMap modelMap
//			){
//		modelMap.addAttribute("pmsPartDtl", pmsService.getPmsPartDtl(pageable));
////		pageable = PageRequest.of(0, 5);
////		modelMap.addAttribute("pmsTechOrder", pmsService.getPmsTechOrder(pageable));
//		modelMap.addAttribute("pmsTechOrderHist", pmsService.getPmsTechOrderHist());
//		
//		
//		modelMap.addAttribute("comnCodeList", comnCodeService.getComnCodeList(""));
//		
//		return new ResponseEntity<Object>(modelMap, HttpStatus.OK);
//	}
//	@PostMapping("/api/user/testRestOrder")
//	public ResponseEntity<Object> callTestRestOrder(
//			@PageableDefault(
//					sort = { "pmsTechOrderPk.nationId","pmsTechOrderPk.companyId","pmsTechOrderPk.areaId","pmsTechOrderPk.engineModel" }
//					, direction = Direction.ASC, page = 0, size = 10) Pageable pageable
//			, ModelMap modelMap
//			){
//		//pageable = PageRequest.of(1, 100);
//		modelMap.addAttribute("pmsTechOrder", pmsService.getPmsTechOrder(pageable));
//		//modelMap.addAttribute("pmsTechOrderAll", pmsService.getPmsTechOrder());
//		//String result = new Gson().toJson(modelMap);
//		return new ResponseEntity<Object>(modelMap, HttpStatus.OK);
//	}

}
