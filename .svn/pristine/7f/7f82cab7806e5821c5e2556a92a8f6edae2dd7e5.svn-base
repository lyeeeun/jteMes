package kr.co.itcall.jte.spring.config;

import java.io.File;
import java.io.IOException;
import java.util.Locale;

import javax.servlet.MultipartConfigElement;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.FixedLocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * <b>kr.co.itcall.jte.spring.config</b>
 * <b>BeanConfig.java</b>
 * <p>Descriptions : 각종 간단히 선언할 Bean을 모아놓은 class </p>
 * </pre>
 * 
 * @author  : khaeng@nate.com
 * @Date    : 2019. 4. 8.
 * @Version :
 */
@Slf4j
@Configuration
public class BeanConfig {

	@Value("${spring.profiles.active:prd}")
	private String profile;

	@Value("${exec.pool.core.size:10}")
	private int taskExecutorCorePoolSize;
	@Value("${exec.pool.max.size:50}")
	private int taskExecutorMaxPoolSize;
	@Value("${exec.pool.keep.max.size:100000}")
	private int taskExecutorKeepMaxSize;

	@Value("#{app['file.upload.temp.path']?:'./upload/temp'}")
	private String uploadTempDir;
	@Value("#{app['file.upload.max.file.size']?:10000000}")
	private long maxUploadSizePerFile;
	@Value("#{app['file.upload.max.total.size']?:50000000}")
	private long maxUploadSize;


	// @Bean // SpringSecurity에서 공식적으로 권장지원하며, 단방향SHA-256 + 자동적용 SALT.
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

//	@Bean
//	public LocaleResolver localeResolver(){
//		FixedLocaleResolver fixedLocaleResolver = new FixedLocaleResolver();
//		// fixedLocaleResolver.setDefaultLocale(Locale.KOREA);
//		fixedLocaleResolver.setDefaultLocale(Locale.ENGLISH);
//		return fixedLocaleResolver;
//	}
	@Bean
	public LocaleResolver localeResolver() {
		SessionLocaleResolver sessionLocaleResolver = new SessionLocaleResolver();
		// sessionLocaleResolver.setDefaultLocale(Locale.KOREA);
		sessionLocaleResolver.setDefaultLocale(Locale.ENGLISH);
		return sessionLocaleResolver;
	}
	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasenames("file:./config/message/messages", "file:./config/messages", "file:./message/messages", "classpath:message/messages");
		messageSource.setCacheSeconds(10); // reload messages every 10 seconds
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setUseCodeAsDefaultMessage(true); // 없는 메세지일 경우 예외를 발생시키는 대신 코드를 기본 메세지로 한다.
		log.debug("MessageSource info[{}]", messageSource);
		return messageSource;
	}
	@Bean
	public MessageSourceAccessor messageSourceAccessor(@Qualifier("messageSource")MessageSource messageSource){
		MessageSourceAccessor messageSourceAccessor = new MessageSourceAccessor(messageSource);
		return messageSourceAccessor;
	}

	@Bean(name = {"taskScheduler", "scheduler"}, destroyMethod = "destroy")
	public TaskScheduler taskScheduler() {
		ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
		taskScheduler.setPoolSize(this.taskExecutorCorePoolSize);
		taskScheduler.initialize();
		taskScheduler.setThreadNamePrefix("Schd-");
		return taskScheduler;
	};

	@Bean(name= {"asyncTaskExecutor", "taskExecutor", "executor"}, destroyMethod = "destroy")
	public TaskExecutor taskExecutor() {
		ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
		taskExecutor.setCorePoolSize(this.taskExecutorCorePoolSize);
		taskExecutor.setMaxPoolSize(this.taskExecutorMaxPoolSize);
		taskExecutor.setQueueCapacity(this.taskExecutorKeepMaxSize);
		taskExecutor.initialize();
		taskExecutor.setThreadNamePrefix("Async-");
		return taskExecutor;
	}

//	@Value("${multipart.maxFileSize}")
//	private String maxFileSize;
//	
//	@Value("${multipart.maxRequestSize}")
//	private String maxRequestSize;
//	
//	@Bean
//	public MultipartConfigElement multipartConfigElement() {
//		MultipartConfigFactory factory = new MultipartConfigFactory();
//		factory.setMaxFileSize(maxFileSize);
//		factory.setMaxRequestSize(maxRequestSize);
//		return factory.createMultipartConfig();
//	}
//
//	@Bean
//	public MultipartResolver multipartResolver() {
//		return new StandardServletMultipartResolver();
//	}

	@Bean(name="multipartResolver")
	public MultipartResolver multipartResolver(@Qualifier("uploadDirResource") Resource uploadTempDir) throws IOException{
		CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver();
		commonsMultipartResolver.setMaxUploadSize(maxUploadSize);
		commonsMultipartResolver.setMaxUploadSizePerFile(maxUploadSizePerFile);
		commonsMultipartResolver.setUploadTempDir(uploadTempDir);
		commonsMultipartResolver.setDefaultEncoding("UTF-8");
		return commonsMultipartResolver;
	}
	
	@Bean(name="uploadDirResource")
	public Resource uploadDirResource(){
		File file = new File(uploadTempDir);
		if(!file.exists() && !file.isDirectory()) {
			file.mkdirs();
		}
		FileSystemResource fileSystemResource = new FileSystemResource(file);
		return fileSystemResource;
	}
	
}
