package kr.co.itcall.jte.spring.config;

import java.io.File;
import java.io.IOException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.MessageSourceAccessor;
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
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import jin.mes.common.msg.ReloadableResourceBundleMessageSourceFromDatabase;
import kr.co.itcall.jte.common.util.CodeUtil;
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
	
	//jkkim(주석추가) - 메세지 프로퍼티 가상경로?
	/*** Message Properties 경로_PGW ***/
	private static final String[] ARR_MESSAGE_SOURCE = new String[] 
			// {"file:../MesStaticWeb/WebContent/resources/locale/messages", "file:./config/message/messages", "file:./config/messages", "file:./message/messages", "classpath:message/messages", "/resources/locale/messages"};
			{"dataSource"};
	//jkkim(주석추가) - 캐시 리로드 타임	
	private static final int SYS_FLAG_REFLASH_SECONDS = 10 * 60; // 10분.

	//jkkim(주석추가) - 
	@Value("${spring.profiles.active:prd}")
	private String profile;

	//jkkim(주석추가) - 첨부파일 관련 설정값
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
	
	/** 
	 * SessionLocaleResolver : 세션으로부터 Locale 정보를 구한다.
	 * setLocale(), setDefaultLocale() 세션에 Locale 정보를 저장한다. 
	 * 작성자: PGW
	**/
	//jkkim(주석추가) - 다국어 기본언어 지정
	@Bean("localeResolver")
	public SessionLocaleResolver sessionLocaleResolver() {
		SessionLocaleResolver sessionLocaleResolver = new SessionLocaleResolver();
		sessionLocaleResolver.setDefaultLocale(Locale.KOREAN);
//		sessionLocaleResolver.setDefaultLocale(Locale.ENGLISH);
		return sessionLocaleResolver;
	}
	//jkkim(주석추가) - 다국어 쿠키 
//	@Bean("localeResolver")
	public LocaleResolver cookieLocaleResolver() {
		CookieLocaleResolver cookieLocaleResolver = new CookieLocaleResolver();
		cookieLocaleResolver.setCookieName("lang");
		cookieLocaleResolver.setCookieMaxAge(100000);
		cookieLocaleResolver.setCookiePath("/");
		cookieLocaleResolver.setDefaultLocale(Locale.KOREAN);
//		cookieLocaleResolver.setDefaultLocale(Locale.ENGLISH);
		return cookieLocaleResolver;
	}
	@Bean
	// @DependsOn({"dbConfig", "dataSourceConfig"})
	public MessageSource messageSource() {
		// ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		/*** ReloadableResourceBundleMessageSource: Reloading 정보를 입력해 주기적인 Message Reloading _PGW ***/
		ReloadableResourceBundleMessageSourceFromDatabase messageSource = new ReloadableResourceBundleMessageSourceFromDatabase();
		/*** setBasenames 이용하여 여러 파일 등록_PGW ***/
		messageSource.setBasenames(ARR_MESSAGE_SOURCE);
		/*** 로딩순서 문제로 ReloadableResourceBundleMessageSourceFromDatabase에서 캐쉬저장주기를 변경하는것으로 조정함. 최초에는 무조건 10분임. ***/
		//코드 ID sys.flag.reflash -> cacheRefreshTime 변경
		messageSource.setCacheSeconds(Integer.parseInt(CodeUtil.getCode("cacheRefreshTime", SYS_FLAG_REFLASH_SECONDS).getCdVal())); // 10분(10*60) // reload messages every 10 seconds
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setUseCodeAsDefaultMessage(true); // 없는 메세지일 경우 예외를 발생시키는 대신 코드를 기본 메세지로 한다.
		log.debug("MessageSource info[{}]", messageSource);
		return messageSource;
	}
	@Bean
	public MessageSourceAccessor messageSourceAccessor(@Qualifier("messageSource")MessageSource messageSource){
		/*** MessageSource 이용하기 위한 Accessor 등록_PGW ***/
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
	
	@Bean(name="getCronOneDayExp")
	public String getCronOneDayExp()
	{
		return CodeUtil.getCode("scheduler.oneDay").getCdVal();
	}
}
