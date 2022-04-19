package kr.co.itcall.jte.common.message;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.itcall.jte.common.util.JteUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/common/msg")
public class MessageSourceController {

	@Resource(name="messageSource")
	private MessageSource messageSource;
	@Resource(name="messageSourceAccessor")
	private MessageSourceAccessor messageSourceAccessor;
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = {"/getAllMessages"}, method = RequestMethod.POST , produces = {"application/json"})
	public ResponseEntity<Object> setComnCode(HttpServletRequest request, ModelMap map) {
		Map<String, String> result = new HashMap<String, String>();
		Set<String> sets = ((ReloadableResourceBundleMessageSource)messageSource).getBasenameSet();
		for (String key : sets) {
			result.put(key, messageSourceAccessor.getMessage(key));
		}
		log.info("message.count = [{}]", sets.size());
		return new ResponseEntity<Object>(result, HttpStatus.OK);
	}

	@PostMapping("/getComMsg")
	public ResponseEntity<Object> getComMsg(Locale locale, @RequestParam(value="code") String code, @RequestParam(value="params[]", required=false) String[] params, @RequestParam(value="def", required=false, defaultValue="") String def, ModelMap model) {
		
		Locale userDblocale = JteUtils.getMyLocale();
		//if(!StringUtils.isEmpty(params) && params.length>0) {}
			//String[] msgParams = Arrays.copyOfRange(params, 1, params.length);
			try {
				//model.addAttribute("result", messageSourceAccessor.getMessage(code, msgParams, def, userDblocale));
				model.addAttribute("key", code);
				model.addAttribute("value", messageSourceAccessor.getMessage(code, def, userDblocale));
			} catch (Exception e) {
				//model.addAttribute("result", messageSourceAccessor.getMessage(code, msgParams, def));
				model.addAttribute("key", code);
				model.addAttribute("value", messageSourceAccessor.getMessage(code, def));
			}
		
		return new ResponseEntity<Object>(model, HttpStatus.OK);
	}

}
