package kr.co.itcall.jte.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
public class JstlJspConfig {

	@Bean
	public InternalResourceViewResolver setJspViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/jsp/");
		resolver.setSuffix(".jsp");
		resolver.setCache(false); // 바로 적용할 수 있게... 운영환경에서는 제외해야 한다.
		return resolver;
	}

}
