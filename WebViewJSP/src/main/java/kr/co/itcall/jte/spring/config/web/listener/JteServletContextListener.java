package kr.co.itcall.jte.spring.config.web.listener;

import javax.annotation.Resource;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import lombok.extern.slf4j.Slf4j;

/********************************************************
 * ServletContext가 로드된 후 수행되는 리스너.
 * @Primay등으로 선언된것들을 포함하여 필수 컨테이너가
 * 로드된 이후 호출된다.
 * 즉, ServletContext가 생성된 후 호출된다.
 * Application이 모두 로드된(완성된) 이후 수행하고자 하는 
 * 로직들은 ApplicationListener에서 구현해야한다.
 * 여기는 업무로직 전 먼저 수행하고자 하는 로직을 구현한다.
 * ServletContext > 
 * @author 91094035
 ********************************************************/
@Slf4j
//@Component("JteServletContextListener")
//@Configuration
@WebListener/*("JteServletContextListener")*/
public class JteServletContextListener implements ServletContextListener {

	@Resource
	private ApplicationContext ctx;

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		log.debug("JteServletContextListener.StoppWork.Started");
//		BatchInfoHstVo batchInfoHst = new BatchInfoHstVo();
//		batchInfoService.setBatchInfoHstLastStatus(batchInfoHst);
		log.debug("JteServletContextListener.StoppWork.Ended");
	}

	@Override
	public void contextInitialized(final ServletContextEvent event) {

		log.info("JteServletContextListener.Started");

		/*** 최초 로드될때 현재 this오브젝트에 Container참조 개체를 주입한다. ***/
		if(this.ctx==null) {
			AutowireCapableBeanFactory autowireCapableBeanFactory = WebApplicationContextUtils
					.getRequiredWebApplicationContext(event.getServletContext())
					.getAutowireCapableBeanFactory();
			autowireCapableBeanFactory.autowireBean(this);
		}

		// 환경초기화...
		

		/**********************************************
		 * JVM종료시 무조건 수행. kill -9를 제외하고 무조건 실행됨.
		 **********************************************/
//		Runtime.getRuntime().addShutdownHook(new Thread() {
//			@Override public void run() {
//				contextDestroyed(event);
//			}
//		});


	}

}
