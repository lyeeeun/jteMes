package kr.co.itcall.jte.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.support.WebApplicationContextUtils;

import lombok.extern.slf4j.Slf4j;

/**
 * <p>Spring-Container-Service를 이용한 Async 호출 : request요청 흐름에서만 가능함.</p>
 * request를 이용하여 Async를 호출할땐. Async로 넘어가기전에 request에서 Context를 뽑아내야 한다.
 * Async내부까지 request를 전달하여 Context를 추출하게 되면... request는 사용만료되어 에러가 발생할 수 있다. (단연 Async닌깐.)
 * <br/>
 * <pre><b>class원형으로 호출해줘야 한다. 상속되거나 선언된 bean이 interface에 의한 생성인 경우 class원형이 파악되지 않으므로 실행할 수 없다.</b></pre> 
 * @author khaeng@nate.com
 */
@Service("asyncUtilForSpringWebApplicationContextServiceDontUseDirect")
@EnableAsync
@Slf4j
public class AsyncUtil {

	private static ApplicationContext applicationContext = null;

	public static int callService(HttpServletRequest request, Class<?> clazz, String methodNm) {
		return callService(request, clazz, null, methodNm, new Object[0]);
	}
	public static int callService(HttpServletRequest request, Class<?> clazz, String methodNm, Object...args) {
		return callService(request, clazz, null, methodNm, args);
	}
	public static int callService(Class<?> clazz, String methodNm) {
		return callService(null, clazz, null, methodNm, new Object[0]);
	}
	public static int callService(Class<?> clazz, String methodNm, Object...args) {
		return callService(null, clazz, null, methodNm, args);
	}
	public static int callService(HttpServletRequest request, String beanNm, String methodNm) {
		return callService(request, null, beanNm, methodNm, new Object[0]);
	}
	public static int callService(HttpServletRequest request, String beanNm, String methodNm, Object...args) {
		return callService(request, null, beanNm, methodNm, args);
	}
	public static int callService(String beanNm, String methodNm) {
		return callService(null, null, beanNm, methodNm, new Object[0]);
	}
	public static int callService(String beanNm, String methodNm, Object...args) {
		return callService(null, null, beanNm, methodNm, args);
	}
	private static int callService(HttpServletRequest request, Class<?> clazz, String beanNm, String methodNm, Object...args) {
		ApplicationContext context = null;
		if(request!=null) {
			context = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
		} else {
			context = StringUtils.isEmpty(ContextLoader.getCurrentWebApplicationContext()) ? applicationContext : ContextLoader.getCurrentWebApplicationContext();
		}
		if(context!=null) {
			AsyncUtil asyncSvc = context.getBean(AsyncUtil.class);
			if(asyncSvc!=null) {
				Object bean = null;
				if(clazz!=null) {
					bean = context.getBean(clazz);
				}else if(beanNm!=null) {
					bean = context.getBean(beanNm);
				}else {
					log.error("Context 내부에서 실행할 bean를 찾지 못했습니다. context[{}], bean[{}], method[{}], args[{}]", context, beanNm, methodNm, args);
					return -2;
				}
				if(bean==null) {
					log.error("Context 내부에서 실행할 beanName를 찾지 못했습니다. context[{}], bean[{}], method[{}], args[{}]", context, beanNm, methodNm, args);
					return -3;
				}
				asyncSvc.callServiceWithAsyncDoNotUseDirectCall(context, bean, methodNm, args);
				return 0;
			}
		}
		log.error("Context가 Load되지 않아 실행할 bean를 찾지 못했습니다. context[{}], bean[{}], method[{}], args[{}]", context, beanNm, methodNm, args);
		return -1;
	}



	/**
	 * <p>업무에서 직접 호출하지 마세요.</p>
	 * WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
	 * @param context
	 * @param bean
	 * @param methodName
	 * @param args
	 */
	@Async
	@Deprecated
	protected void callServiceWithAsyncDoNotUseDirectCall(ApplicationContext context, Object bean, String methodName, Object...args) {
		log.debug("======================== callAsyncService Start =============================");
		if(context!=null) {
			try {
				if(bean!=null) {
					Method method = null;
					if(args!=null && args.length>0) {
						Class<?>[] clazz = new Class[args.length];
						Method[] arrMethod = bean.getClass().getDeclaredMethods();
						for (int i = 0; i < arrMethod.length; i++) {
							if(!arrMethod[i].getName().equalsIgnoreCase(methodName)) {
								continue;
							}
							Class<?>[] paramTypes = arrMethod[i].getParameterTypes();
							for (int j = 0; j < paramTypes.length; j++) {
								if(paramTypes[j].getName().equals("int")) {
									paramTypes[j] = Integer.class;
								}else if(paramTypes[j].getName().equals("long")) {
									paramTypes[j] = Long.class;
								}else if(paramTypes[j].getName().equals("float")) {
									paramTypes[j] = Float.class;
								}else if(paramTypes[j].getName().equals("double")) {
									paramTypes[j] = Double.class;
								}else if(paramTypes[j].getName().equals("boolean")) {
									paramTypes[j] = Boolean.class;
								}else if(paramTypes[j].getName().equals("char")) {
									paramTypes[j] = Character.class;
								}else if(paramTypes[j].getName().equals("byte")) {
									paramTypes[j] = Byte.class;
								}else if(paramTypes[j].getName().equals("short")) {
									paramTypes[j] = Short.class;
								}
							}
							if(paramTypes.length == args.length) {
								clazz = Arrays.copyOf(paramTypes, paramTypes.length);
								for (int j = 0; j < paramTypes.length; j++) {
									if(!paramTypes[j].isInstance(args[j])) {
										clazz[clazz.length-1] = null;
										break;
									}
								}
							}
							if(clazz[args.length-1]!=null) {
								method = arrMethod[i];
								break;
							}
						}
//						for (int i = 0; i < clazz.length; i++) {
//							clazz[i] = args.getClass();
//						}
//						method = ReflectionUtils.findMethod(bean.getClass(), methodName, clazz);
					}else {
						method = ReflectionUtils.findMethod(bean.getClass(), methodName); // method = bean.getClass().getDeclaredMethod(methodName, new Class[0]);
					}
					if(method!=null) {
						method.invoke(bean, args);
					}else {
						log.error("실행할 method를 찾지 못했거나 인수형식에 맞지 않습니다. bean[{}], method[{}], args[{}]", bean, methodName, args);
					}
				}else {
					log.error("Context 내부에서 실행할 bean를 찾지 못했습니다. context[{}], bean[{}], method[{}], args[{}]", context, bean, methodName, args);
				}
			} catch (NoSuchBeanDefinitionException | SecurityException | IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
				log.error("실행할 bean/method를 invoke서비스 중 에러가 발생했습니다.. bean[{}], method[{}], args[{}] exception[{}]", bean, methodName, args, e.getMessage());
			}
		}else {
			log.error("Context가 Load되지 않아 실행할 bean를 찾지 못했습니다. context[{}], bean[{}], method[{}], args[{}]", context, bean, methodName, args);
		}
		log.debug("======================== callAsyncService End!! =============================\n");
	}

	public static void setApplicationContext(ApplicationContext applicationContext) {
		AsyncUtil.applicationContext = applicationContext;
	}
	public static ApplicationContext getApplicationContext() {
		return AsyncUtil.applicationContext;
	}

}
