package kr.co.itcall.jte.spring.config.exception;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.util.JteUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class JteErrorController  implements ErrorController  {

	@RequestMapping("/error")
	public String handleCommonError(HttpServletRequest request, Model model) {

		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		Object message = request.getAttribute(RequestDispatcher.ERROR_MESSAGE);
		try {
			if(message==null || StringUtils.isEmpty(message.toString())) {
				message = request.getAttribute(RequestDispatcher.ERROR_EXCEPTION);
				if(message instanceof Exception) {
					message = ((Exception) message).getCause().getLocalizedMessage();
				}
			}
		} catch (Exception e) {}

		log.error("error handle : errorStatus[{}], errorMessage[{}], supportNames[{}]", status, message, request.getAttributeNames());

		model.addAttribute("code", status);
		model.addAttribute("message", message);

		if (status != null) {
			Integer statusCode = Integer.valueOf(status.toString());
			if (!"XMLHttpRequest".equals(request.getHeader("X-Requested-With")) 
					&& ( statusCode == HttpStatus.FORBIDDEN.value() 
					|| statusCode == HttpStatus.NOT_FOUND.value()
					|| statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value())) {
				return "tlf/error/" + statusCode;
			}
		}

		return getErrorPath(); // "tlf/error/error";
	}

	@Override
	public String getErrorPath() {
		if("XMLHttpRequest".equals(JteUtils.getMyRequest().getHeader("X-Requested-With"))){
			return "jsonView";
		} else {
			return "tlf/error/error";
		}
	}

}
