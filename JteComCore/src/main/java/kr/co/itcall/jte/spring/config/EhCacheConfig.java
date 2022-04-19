package kr.co.itcall.jte.spring.config;

import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.cache.jcache.JCacheCacheManager;
import org.springframework.cache.jcache.JCacheManagerFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableCaching
@Configuration
@EnableScheduling
public class EhCacheConfig {
	@Bean
	public JCacheManagerFactoryBean jCacheManagerFactoryBean() throws Exception{
		JCacheManagerFactoryBean jCacheManagerFactoryBean = new JCacheManagerFactoryBean();
		jCacheManagerFactoryBean.setCacheManagerUri(new ClassPathResource("ehcache/ehcache.xml").getURI());
		return jCacheManagerFactoryBean;
	}

	@Bean
	public JCacheCacheManager jCacheCacheManager(JCacheManagerFactoryBean jCacheManagerFactoryBean) {
		JCacheCacheManager jCacheCacheManager = new JCacheCacheManager();
		jCacheCacheManager.setCacheManager(jCacheManagerFactoryBean.getObject());
		return jCacheCacheManager;
	}
	
//	@Bean
//	public KeyGenerator simpleKeyGenerator() {
//		return (target, method, params) -> {
//			StringBuilder sb = new StringBuilder();
//			sb.append(target.getClass().getName());
//			sb.append(method.getName());
//			for (Object obj : params) {
//				sb.append(obj.toString());
//			}
//			return sb.toString();
//		};
//	}
}
