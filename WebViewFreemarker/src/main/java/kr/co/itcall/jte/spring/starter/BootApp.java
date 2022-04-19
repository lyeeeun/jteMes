package kr.co.itcall.jte.spring.starter;

import javax.servlet.MultipartConfigElement;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorMvcAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;

@ComponentScan("kr.co.itcall.jte")
@EnableCaching
@SpringBootApplication(scanBasePackages = {"kr.co.itcall.jte"})
@EntityScan("kr.co.itcall.jte")
@EnableJpaRepositories(basePackages = {"kr.co.itcall.jte"})
@EnableAutoConfiguration // (exclude = {ErrorMvcAutoConfiguration.class}) // Spring에서 제공하는 에러정보 페이지를 사용하지 않는다.
@EnableJpaAuditing

public class BootApp extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		SpringApplicationBuilder builder = application.sources(BootApp.class);
		// builder. // 프로퍼티 설정
		// builder.properties("spring.thymeleaf.check-template-location=false");
		return builder;
	}
	
	public static void main(String[] args) {
		
		/********************************************
		 * Log4j-2 for Jansi Support is skiped...
		 * Need to option : -Dlog4j.skipJansi=false
		 ********************************************/
		System.setProperty("log4j.skipJansi", "false");
		/********************************************
		 * Eclipse Error in Debug >>> throw new SilentExitException();
		 ********************************************/
		System.setProperty("spring.devtools.restart.enabled", "false");
		
		SpringApplication.run(BootApp.class, args);
	}

//	@Bean
//	public InternalResourceViewResolver setJspViewResolver() {
//		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
//		resolver.setPrefix("/WEB-INF/jsp/");
//		resolver.setSuffix(".jsp");
//		resolver.setCache(false); // 바로 적용할 수 있게...
//		return resolver;
//	}

}
