package kr.co.itcall.jte.spring.config;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.converter.xml.MappingJackson2XmlHttpMessageConverter;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import org.thymeleaf.spring5.SpringTemplateEngine;
import org.thymeleaf.spring5.templateresolver.SpringResourceTemplateResolver;
import org.thymeleaf.spring5.view.ThymeleafViewResolver;
import org.thymeleaf.templatemode.TemplateMode;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.itcall.jte.util.AsyncUtil;
import nz.net.ultraq.thymeleaf.LayoutDialect;

@Configuration
@EnableWebMvc
public class WebViewConfig implements WebMvcConfigurer, ApplicationContextAware {

	private static final String DEF_DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";

//	@Value("#{biz['web.static.resources.path']?:'file:///D:/JTE/Workspace/JinTechEngParents/MesStaticWeb/WebContent/'}") // WEB-RESOURCES 경로.
	@Value("#{biz['web.static.resources.path']?:'file:../MesStaticWeb/WebContent/'}") // WEB-RESOURCES 경로.
	private String staticResouceLocation;
	
	@Value("#{biz['web.static.resources.path']?:'file:../MesStaticWeb/WebContent/resources/'}") // WEB-RESOURCES 경로.
	private String staticResouceLocation2;
	
	@Value("${spring.profiles.active:prd}")
	private String profile;
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) {
		AsyncUtil.setApplicationContext(applicationContext);
	}
	
//	@Override
//	public void addResourceHandlers(ResourceHandlerRegistry registry) {
//		registry.addResourceHandler("/resources/**")
//				.addResourceLocations("/baseProject/resources/")
//				.setCachePeriod(60) // 캐쉬 지속시간 60초
//				;
//		WebMvcConfigurer.super.addResourceHandlers(registry);
//	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/favicon.ico").addResourceLocations("classpath:/static/favicon.ico")
				.setCacheControl(CacheControl.maxAge(7, TimeUnit.DAYS).cachePublic());
		registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/")
				.setCacheControl(CacheControl.maxAge(7, TimeUnit.DAYS).cachePublic());
		registry.addResourceHandler("/ATOS_MES/**").addResourceLocations(staticResouceLocation);
		registry.addResourceHandler("/resources/**").addResourceLocations(staticResouceLocation2);
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(localeChangeInterceptor()); // WebMvcConfigurer.super.addInterceptors(registry);
//		registry.addInterceptor(themeChangeInterceptor()).addPathPatterns("/**").excludePathPatterns("/admin/**");
//		registry.addInterceptor(securityInterceptor()).addPathPatterns("/secure/*");
	}

	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
		configurer.favorPathExtension(false)
				.favorParameter(false)
				.defaultContentType(MediaType.APPLICATION_JSON)
				.mediaType("xml", MediaType.APPLICATION_ATOM_XML)
				.mediaType("json", MediaType.APPLICATION_JSON)
				.mediaType("text", MediaType.TEXT_HTML)
				.mediaType("htm", MediaType.TEXT_HTML)
				.mediaType("html", MediaType.TEXT_HTML);
	}
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
//		registry.addViewController("/login").setViewName("testLogin");
//		registry.addViewController("/index").setViewName("index");
//		registry.addViewController("/notice").setViewName("tlf/notice");
		registry.addViewController("/form/common/popup/comPopup").setViewName("/form/common/popup/comPopup");
		registry.addViewController("/common/popup/comPopup")     .setViewName("/form/common/popup/comPopup");
		registry.addViewController("/form/home").setViewName("/form/home");
//		registry.addViewController("/tabMain").setViewName("/tabMain");
		registry.addViewController("/").setViewName("/tabMain");
	}

//	@Override
//	public void addFormatters(FormatterRegistry registry) {
//		
//	}
//
//	@Override
//	public Validator getValidator() {
//	  return null;
//	}

	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		Jackson2ObjectMapperBuilder builder = new Jackson2ObjectMapperBuilder();
		builder.indentOutput(true)
				// .simpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.dateFormat(new SimpleDateFormat(DEF_DATE_TIME_FORMAT));
		converters.add(new MappingJackson2HttpMessageConverter(builder.build()));
		converters.add(new MappingJackson2XmlHttpMessageConverter(builder.createXmlMapper(true).build()));
	}





	/*********************************  Bean설정  ****************************/
	@Bean
	public ContentNegotiatingViewResolver viewResolver(ContentNegotiationManager cnManager, MessageSource messageSource) {
		ContentNegotiatingViewResolver cnResolver = new ContentNegotiatingViewResolver();
		cnResolver.setContentNegotiationManager(cnManager);
		
		List<ViewResolver> viewResolvers = new ArrayList<ViewResolver>();
		viewResolvers.add(thymeleafViewResolver(messageSource));
		viewResolvers.add(jspViewResolver());
		cnResolver.setViewResolvers(viewResolvers);
		
		List<View> defaultViews = new ArrayList<View>();
		defaultViews.add(jsonView()); // @ResponseBody 또는 viewName이 지정되지 않으면 기본적으로 jsonView로 반환한다.
		cnResolver.setDefaultViews(defaultViews);
		
		return cnResolver;
	}
	
	@Bean
	public InternalResourceViewResolver jspViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jsp");
		resolver.setOrder(2);
		if(StringUtils.equalsIgnoreCase(profile, "local"))
			resolver.setCache(false); // 바로 적용할 수 있게... 운영환경에서는 제외해야 한다.
		return resolver;
	}

	@Bean
	public LocaleChangeInterceptor localeChangeInterceptor() {
		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
		// request로 넘어오는 language parameter를 받아서 locale로 설정 한다.
		localeChangeInterceptor.setParamName("lang");
		return localeChangeInterceptor;
	}

	public SpringResourceTemplateResolver templateResolver() {
		SpringResourceTemplateResolver templateResolver = new SpringResourceTemplateResolver();
		templateResolver.setApplicationContext(AsyncUtil.getApplicationContext());
		templateResolver.setPrefix("classpath:/templates/");
		templateResolver.setCharacterEncoding("UTF-8");
		templateResolver.setSuffix(".html");
		templateResolver.setTemplateMode(TemplateMode.HTML); // .setTemplateMode("LEGACYHTML5");
		if(StringUtils.equalsIgnoreCase(profile, "local"))
			templateResolver.setCacheable(false);
		return templateResolver;
	}

	public SpringTemplateEngine templateEngine(MessageSource messageSource) {
		SpringTemplateEngine templateEngine = new SpringTemplateEngine();
		templateEngine.setTemplateResolver(templateResolver());
		templateEngine.setTemplateEngineMessageSource(messageSource);
		templateEngine.addDialect(layoutDialect());
		return templateEngine;
	}

	@Bean
	@Autowired
	public ThymeleafViewResolver thymeleafViewResolver(MessageSource messageSource) {
		ThymeleafViewResolver viewResolver = new ThymeleafViewResolver();
		viewResolver.setTemplateEngine(templateEngine(messageSource));
		viewResolver.setCharacterEncoding("UTF-8");
		viewResolver.setOrder(1);
		viewResolver.setViewNames("tlf/*".split(","));
		if(StringUtils.equalsIgnoreCase(profile, "local"))
			viewResolver.setCache(false); // 로컬 개발환경에서 디버깅을 위한 캐쉬를 하지 않는다.
		return viewResolver;
	}

	public LayoutDialect layoutDialect() {
		return new LayoutDialect();
	}

	@Bean
	/**
	 * Controller에서 viewResolve를 해당 Bean이름(jsonView)으로 반환하면 json으로 돌려준다. 즉 Ajax통신이 가능하게 한다.
	 */
	public MappingJackson2JsonView jsonView() {
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		jsonView.setObjectMapper(objectMapper());
		return jsonView;
	}

	@Bean
	public MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter() {
		MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		converter.setObjectMapper(objectMapper());
		return converter;
	}

	@Bean
	public ObjectMapper objectMapper() {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.setDateFormat(new SimpleDateFormat(DEF_DATE_TIME_FORMAT));
		// objectMapper.registerModule(new Module());
		return objectMapper;
	}


}
