package kr.co.itcall.jte.spring.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.server.ConfigurableWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

////@Configuration
////@EnableWebMvc
//public class WebConfig extends WebMvcConfigurerAdapter {
// 
//	@Override
//	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
//		configurer.enable();
//	}
//	
////	@Override
////	public void addResourceHandlers(ResourceHandlerRegistry registry) {
////		registry.addResourceHandler("/resources/**").addResourceLocations("/WEB-INF/resources/");
////
////	}
//
//}

@Slf4j
@Component
public class WebConfig implements WebServerFactoryCustomizer<ConfigurableWebServerFactory>{

	@Value("${spring.profiles.active:prd}")
	private String profile;

	@Value("${server.port:0}")
	private int serverPort;
	@Value("#{biz['server.port']?:0}")
	private int bizServerPort;

	@Override
	public void customize(ConfigurableWebServerFactory factory) {
		// factory.addErrorPages(ErrorPage);
		log.debug("ConfigurableWebServerFactory info[{}]", factory);
		String envServerPort = System.getProperty("server.port");
		log.debug("System.getProperty(\"server.port\") = [{}]", envServerPort);
		log.debug("${server.port:0} = [{}]", serverPort);
		log.debug("#{biz['server.port']?:0} = [{}]", bizServerPort);
		if(envServerPort==null && serverPort==0 && bizServerPort>0) {
			factory.setPort(bizServerPort);
		}
		log.debug("ConfigurableWebServerFactory info[{}]", factory);
	}
	
//	@Bean
//	public WebServerFactoryCustomizer<ConfigurableServletWebServerFactory> webServerFactoryCustomizer() {
//		return factory -> factory.setContextPath("/");
//	}

}