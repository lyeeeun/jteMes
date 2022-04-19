package kr.co.itcall.jte.spring.config.web.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import com.fasterxml.jackson.databind.ObjectMapper;

import jin.mes.form.devtol.svcLog.SvcLogDto;
import jin.mes.form.devtol.svcLog.SvcLogService;
import kr.co.itcall.jte.common.util.JteUtils;

@Component
@Aspect
public class LogAspect {
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	SvcLogService svcLogService;
	
	//@Around("execution(* jin.mes.form..*Service.*(..)) || execution(* jin.mes.cform..*Service.*(..))")
	
	@Around("(execution(* jin.mes.form..*Service.*(..)) && !execution(* jin.mes.form.devtol..*.*(..))) "
			+ " || (execution(* jin.mes.cform..*Service.*(..)) && !execution(* jin.mes.cform.basMgt.devtol..*.*(..)))")
	public Object svcLogging(ProceedingJoinPoint joinPoint) throws Throwable{
		StopWatch stopWatch = new StopWatch();
		ObjectMapper objectMapper = new ObjectMapper();
		boolean isSuccess = true;
		String isResult = "normal";
		String errorMsg = null;
		
		stopWatch.start();
		Object proceed = null;
		try{
			proceed = joinPoint.proceed();
		}catch(Throwable t) {
			isSuccess = false;
			isResult = "error";
			errorMsg = t.getMessage();
		}
		stopWatch.stop();
		
		Signature signature = joinPoint.getSignature();
		String logPrmt = objectMapper.writeValueAsString(joinPoint.getArgs());
		
//		Class clazz = Class.forName("kr.co.itcall.jte.common.mvc.BaseVo");
//		Field field = clazz.getDeclaredField("currentMenuId"); 
//		field.setAccessible(true);
//		String menuId = field.get(joinPoint.getArgs()[0]).toString();

		String menuId = JteUtils.getUserCookie("currentMenuId");
		
		SvcLogDto svcLogDto = new SvcLogDto(stopWatch.getTotalTimeSeconds(), menuId, signature.getName(), signature.getDeclaringTypeName(), logPrmt,
				isSuccess, errorMsg, JteUtils.getUserId(), isResult, JteUtils.getClientIp(), JteUtils.getUserDevice());
		svcLogService.setSvcLog(svcLogDto);
		
		return proceed;
	}
	
}
