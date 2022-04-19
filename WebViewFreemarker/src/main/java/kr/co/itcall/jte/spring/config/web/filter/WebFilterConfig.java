package kr.co.itcall.jte.spring.config.web.filter;

import javax.annotation.Resource;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.OncePerRequestFilter;

//@Configuration
public class WebFilterConfig {

//	@Resource
//	private OncePerRequestFilter loggerFilter;
//
//	@Bean
//	public FilterRegistrationBean loggerFilter(){
//		if(this.loggerFilter==null)
//			return null;
//		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
//		registrationBean.setFilter(loggerFilter);
//		registrationBean.setAsyncSupported(true);
//		registrationBean.addUrlPatterns("/*");
//		return registrationBean;
//	}

}
