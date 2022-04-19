package kr.co.itcall.jte.spring.config.web.listener;

import javax.annotation.Resource;
import javax.servlet.ServletRequestEvent;
import javax.servlet.annotation.WebListener;

import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.context.support.WebApplicationContextUtils;

@Configuration
@WebListener
public class JteRequestContextListener extends RequestContextListener {

	/**********************************************************
	 * For
	 * ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()) 
	 * Controller진입에 의하여 Active중인 Process는 언제 어디서든 Request를 가져올 수 있다.
	 **********************************************************/

	@Resource
	private ApplicationContext ctx;

	@Override
	public void requestInitialized(ServletRequestEvent event) {
		super.requestInitialized(event);
		/*** 최초 로드될때 현재 this오브젝트에 Container참조 개체를 주입한다. ***/
		if(this.ctx==null) {
			AutowireCapableBeanFactory autowireCapableBeanFactory = WebApplicationContextUtils
					.getRequiredWebApplicationContext(event.getServletContext())
					.getAutowireCapableBeanFactory();
			autowireCapableBeanFactory.autowireBean(this);
		}
	}
}
