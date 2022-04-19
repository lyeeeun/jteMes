package kr.co.itcall.jte.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

@Configuration
public class FreemarkerConfig {

//	@Bean
//	public ServletContextTemplateResolver templateResolver(ServletContext servletContext) {
//		ServletContextTemplateResolver resolver = new ServletContextTemplateResolver(servletContext);
//		resolver.setPrefix("/WEB-INF/views/");
//		resolver.setSuffix(".html");
//		resolver.setTemplateMode("HTML5");
//		resolver.setCacheable(false);
//		return resolver;
//	}
//
//	@Bean
//	public SpringTemplateEngine templateEngine(ServletContext servletContext) {
//		SpringTemplateEngine engine = new SpringTemplateEngine();
//		engine.setTemplateResolver(templateResolver(servletContext));
//		return engine;
//	}
//
//	@Bean
//	public ThymeleafViewResolver thymeleafViewResolver(ServletContext servletContext) {
//		ThymeleafViewResolver resolver = new ThymeleafViewResolver();
//		resolver.setTemplateEngine(templateEngine(servletContext));
//		return resolver;
//	}

	// http://wiki.gurubee.net/display/SWDEV/FreeMarker

	@Bean
	public FreeMarkerConfigurer freeMarkerConfigurer() {

		FreeMarkerConfigurer freeMarkerConfigurer = new FreeMarkerConfigurer();

		freeMarkerConfigurer.setTemplateLoaderPath("classpath:/templates/");
		// freeMarkerConfigurer.setTemplateLoaderPath("/WEB-INF/views/");
		freeMarkerConfigurer.setDefaultEncoding("UTF-8");

		return freeMarkerConfigurer;
	}

	@Bean
	public FreeMarkerViewResolver viewResolver() {

		FreeMarkerViewResolver viewResolver = new FreeMarkerViewResolver();
		// viewResolver.setPrefix("/WEB-INF/views/");
		// viewResolver.setSuffix(".jsp");
		viewResolver.setSuffix(".ftl");
		viewResolver.setCache(false); // Set to true during production !!!!! 매우중요.
		viewResolver.setContentType("text/html;charset=UTF-8");
		viewResolver.setOrder(0);
		viewResolver.setExposeSpringMacroHelpers(true); // Set to false during production

		return viewResolver;
	}

}
