package kr.co.itcall.jte.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.rms.model.ElasticVO;

@Controller
public class SecurityController {	
	
	@Autowired
	SecurityService securityService;
	
	// security view
	@RequestMapping("/jkkim/security")
	@PreAuthorize("isAuthenticated()")
	public String sampleSecurity() {
			return "user/security";
	}
	// security enc
	@RequestMapping("/web-security-enc")
	@ResponseBody
	public String GetData_Security_Enc(@RequestBody SecurityVO securityVO) throws Exception {
		return securityService.GetData_Security_Enc(securityVO);
	}
	// security dec
	@RequestMapping("/web-security-dec")
	@ResponseBody
	public String GetData_Security_Dec(@RequestBody SecurityVO securityVO) throws Exception {
		return securityService.GetData_Security_Dec(securityVO);
	}
	
	// security enc
	@RequestMapping("/web-jsaypt-enc")
	@ResponseBody
	public String GetData_Jsaypt_Enc(@RequestBody SecurityVO securityVO) throws Exception{
		return securityService.GetData_Jsaypt_Enc(securityVO);
	}
	// security dec
	@RequestMapping("/web-jsaypt-dec")
	@ResponseBody
	public String GetData_Jsaypt_Dec(@RequestBody SecurityVO securityVO) throws Exception{
		return securityService.GetData_Jsaypt_Dec(securityVO);
	}
	
	// security enc
	@RequestMapping("/web-rsa-enc")
	@ResponseBody
	public String GetData_Rsa_Enc(@RequestBody SecurityVO securityVO) throws Exception {
		return securityService.GetData_Rsa_Enc(securityVO);
	}
	// security dec
	@RequestMapping("/web-rsa-dec")
	@ResponseBody
	public String GetData_Rsa_Dec(@RequestBody SecurityVO securityVO) throws Exception {
		return securityService.GetData_Rsa_Dec(securityVO);
	}
	
	// security enc
	@RequestMapping("/web-rsakey-enc")
	@ResponseBody
	public String GetData_RsaKey_Enc(@RequestBody SecurityVO securityVO) throws Exception {
		return securityService.GetData_RsaKey_Enc(securityVO);
	}
	// security dec
	@RequestMapping("/web-rsakey-dec")
	@ResponseBody
	public String GetData_RsaKey_Dec(@RequestBody SecurityVO securityVO) throws Exception {
		return securityService.GetData_RsaKey_Dec(securityVO);
	}
}
