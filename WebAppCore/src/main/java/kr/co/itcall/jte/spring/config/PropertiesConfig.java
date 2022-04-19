package kr.co.itcall.jte.spring.config;

import java.util.Properties;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.EnvironmentStringPBEConfig;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;

import kr.co.itcall.jte.util.SecureAesCripto;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableConfigurationProperties
public class PropertiesConfig {

	private static final String JASYPT_STD_WITH = "ENC(";
	private static final String JASYPT_END_WITH = ")";
	private static final String JASYPT_ALGORITHM = "PBEWITHMD5ANDDES";
	private static final String JASYPT_KEY_CODE = "SlsvPpmFBZi9wBEGbZlpZJGO7HvvFoH9V/oyOa3R8B1QWKBLE7MqyHtXadNwO/JF";

	/*** @EnableConfigurationProperties 때문에 기본 Properties 정보를 읽어오지 못한다. ***/
//	@Value("${spring.profiles.active:prd}")
//	private String profile;

	@Resource(name="jasyptStringEncryptor")
	private StandardPBEStringEncryptor stringEncryptor;

	@Resource
	private @Qualifier("appProperties") PropertiesFactoryBean appProps;
	@Resource
	private @Qualifier("bizProperties") PropertiesFactoryBean bizProps;

	@PostConstruct
	@DependsOn(value = {"jasyptStringEncryptor", "appProperties", "bizProperties"})
	public void initialize() throws Exception {
		// Spring에 의해 자동복호화가 된다. [SystemProperties/application.properties] // System.setProperties(doDecriypt(System.getProperties()));
		appProps.setProperties(doDecriypt(appProps.getObject()));
		bizProps.setProperties(doDecriypt(bizProps.getObject()));
	}

	/**
	 * Properties 암복호화 로직. 
	 * Jsaypt라이브러리를 사용하며, 라이브러리의 키값은 SecureAesCripto를 이용하며, SecureAesCripto의 키는 실행환경에서 읽어온다. (-Daes.enc.pwd=passwordKey from runTime.)
	 * SpringBoot2.x 이상에서는 bean이름을 "jasyptStringEncryptor"로 설정하고 Property에 "jasypt.encryptor.bean=jasyptStringEncryptor"를 추가해줘야 한다. ㅠㅠ 2틀 고생함. 이런것들이 짜증나지 khaeng@nate.com
	 * @param secureAesCripto
	 * @return
	 * @throws Exception 
	 */
	@Bean(name = {"jasyptStringEncryptor", "standardPBEStringEncryptor", "stringEncryptor"})
	@DependsOn(value={"secureAesCripto"})
	public StringEncryptor stringEncryptor(@Qualifier("secureAesCripto") SecureAesCripto secureAesCripto) throws Exception {
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		String psNameKey = secureAesCripto.decrypt(JASYPT_KEY_CODE);
		EnvironmentStringPBEConfig pbeConfig = new EnvironmentStringPBEConfig();
		pbeConfig.setAlgorithm(JASYPT_ALGORITHM);
		pbeConfig.setPassword(psNameKey);
		encryptor.setConfig(pbeConfig);
		return encryptor;
	}

	private Properties doDecriypt(Properties properties) throws Exception {
		/*************************************
		 * 암호화 Properties가 
		 * $으로 읽어올땐 자동으로 풀려지고.
		 * #으로 읽어올땐 자동으로 안풀려져서.
		 * 여기서 강제로 암호화 Properties는 강제로 풀려서 저장하게끔 한다.
		 *************************************/
		if(properties!=null)
			for (Object key : properties.keySet()) {
				if(key!=null && key instanceof String && isEncryptedPropperty(properties.getProperty((String) key))) {
					log.info("암호화된 Property key[{}], value[{}], 복호화데이터[{}]", key, properties.getProperty((String) key), getDecrypt(properties.getProperty((String) key)));
					properties.setProperty((String)key, getDecrypt(properties.getProperty((String) key)));
				}
			}
		return properties;
	}

	public String getDecrypt(String value) throws Exception {
		if(value==null)
			return null;
		String retValue = value.trim();
		if(stringEncryptor!=null&&value!=null&&value.startsWith(JASYPT_STD_WITH)&&value.endsWith(JASYPT_END_WITH)) {
			retValue = value.substring(JASYPT_STD_WITH.length(), value.length()-JASYPT_END_WITH.length());
			try {
				retValue = stringEncryptor.decrypt(retValue);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return retValue;
	}
	public boolean isEncryptedPropperty(String value) {
		if(value!=null&&value.trim().startsWith(JASYPT_STD_WITH)&&value.trim().endsWith(JASYPT_END_WITH)) {
			return true;
		}
		return false;
	}

	/**
	 * <pre>
	 * 1. 개요 : Properties파일을 실행위치 지정.
	 * 2. 처리내용 : 실행위치의 ./config/properties/... ./config/... 순서대로 찾아서 읽어오며, 없으면 프로젝트 내부의 classPath에서 읽어간다.
	 * </pre>
	 * @Method : getLocationResource
	 * @param fileName
	 * @return
	 */
	public org.springframework.core.io.Resource getLocationResource(String fileName) {
		String profile=System.getProperty("spring.profiles.active", "prd");
		log.info("NOW spring.profiles.active[{}]", profile);
		String[] locations = new String[] {String.format("./config/properties/%s-%s.properties", fileName, profile)
				, String.format("./config/%s-%s.properties", fileName, profile)
				, String.format("./properties/%s-%s.properties", fileName, profile)
				, String.format("./config/properties/%s.properties", fileName, profile)
				, String.format("./config/%s.properties", fileName)
				, String.format("./properties/%s.properties", fileName)};
		for (String location : locations) {
			FileSystemResource fileSystemResource = new FileSystemResource(location);
			if(fileSystemResource.exists() && fileSystemResource.isFile() && fileSystemResource.isReadable()) {
				return fileSystemResource;
			}
		}
		return new ClassPathResource(String.format("/properties/%s-%s.properties", fileName, profile));
	}

	// @Profile("prd")
	@Bean(name = {"app", "appProperties"})
	@DependsOn(value={"jasyptStringEncryptor"})
	public PropertiesFactoryBean getProdAppProperties() throws Exception {
		PropertiesFactoryBean bean = new PropertiesFactoryBean();
		bean.setLocation(getLocationResource("application")); // (new ClassPathResource("/properties/application-prod.properties"));
		/**
		 * 경로를 셋팅한 후 afterPropertiesSet()을 호출하면 해당 Properties정보를 읽어온다.
		 * 이후 Properties의 내용 중 암호화된 정보를 평문으로 변경하는 작업을 setProperties(doDecriypt(bean.getObject()))으로 
		 * 수행 할 수는 있다.
		 * 하지만 이후 Spring에 의해서 다시 afterPropertiesSet()이 자동으로 호출되므로 의미없는 행위가 된다.
		 * 즉, 모든 Properties가 Spring에 의해서 자동Load된 이후에 변경작업을 해야한다. 
		 * >>> @PostConstruct의 initialize()에서 최종 수행된다.
		 * bean.afterPropertiesSet();
		 * bean.setProperties(doDecriypt(bean.getObject()));
		 */
		return bean;
	}

	// @Profile("prd")
	@Bean(name = {"biz", "bizProperties"})
	@DependsOn(value={"jasyptStringEncryptor"})
	public PropertiesFactoryBean getProdCommonProperties() throws Exception {
		PropertiesFactoryBean bean = new PropertiesFactoryBean();
		bean.setLocation(getLocationResource("biz")); // (new ClassPathResource("/properties/biz-prod.properties"));
		return bean;
	}

}
