package kr.co.itcall.jte.spring.config.web.listener;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class JteAspectListener {

	private final static String EVERY_SERVICE_PATTERN = "execution(public * kr.co.itcall.jte..*Service.*(..))";
	/**
	 * <pre>
	 * 1. 개요 : 지정된 모든 서비스에 대한 전처리를 진행할 수 있다.
	 * 2. 처리내용 : === 미 정 ===
	 * </pre>
	 * @Method : beforeEntering
	 * @param joinPoint
	 * @param args
	 */
	@Before(value=EVERY_SERVICE_PATTERN, argNames="joinPoint")
	public void beforeEntering(JoinPoint joinPoint) {
		log.debug("@BeforeEntering Service log : ClassName[{}], MethodName[{}], with Parameters[{}]", joinPoint.getTarget().getClass().getName(), joinPoint.toShortString(), joinPoint.getArgs());
	}
	
	/**
	 * <pre>
	 * 1. 개요 : 지정된 모든 서비스에 대한 후처리를 진행할 수 있다.
	 * 2. 처리내용 : === 미 정 ===
	 * </pre>
	 * @Method : afterReturning
	 * @param joinPoint
	 * @param args
	 * @param result
	 */
	@AfterReturning(pointcut=EVERY_SERVICE_PATTERN, argNames="joinPoint,result", returning="result")
	public void afterReturning(JoinPoint joinPoint, Object result) {
		log.debug("@AfterReturning Service log : ClassName[{}], MethodName[{}], with Parameters[{}]", joinPoint.getTarget().getClass().getName(), joinPoint.toShortString(), joinPoint.getArgs());
	}
	
	/**
	 * <pre>
	 * 1. 개요 : 지정된 모든 서비스에 대한 Exception발생에 대한 후처리를 진행할 수 있다.(Exception을 잡을 수는 없다.)
	 * 2. 처리내용 : === 미 정 ===
	 * </pre>
	 * @Method : throwable
	 * @param joinPoint
	 * @param args
	 * @param exception
	 */
	@AfterThrowing(pointcut=EVERY_SERVICE_PATTERN, argNames="joinPoint,exception", throwing="exception")
	public void throwable(JoinPoint joinPoint, Exception exception) {
		log.debug("@AfterThrowing Service log : ClassName[{}], MethodName[{}], ExceptionMessage[{}] with Parameters[{}]", joinPoint.getTarget().getClass().getName(), joinPoint.toShortString(), exception.getMessage(), joinPoint.getArgs());
	}

}
