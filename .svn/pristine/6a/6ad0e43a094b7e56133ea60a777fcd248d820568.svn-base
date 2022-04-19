package kr.co.itcall.jte.spring.config;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.BooleanTypeHandler;
import org.apache.ibatis.type.DateTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@EnableAspectJAutoProxy
@Configuration
@EnableTransactionManagement
@DependsOn({"dbConfig"})
public class DataSourceConfig {

	private final static String MYBATIS_CONFIG_FILE = "classpath:/config/spring/mybatisConfig.xml";
	private final static String MYBATIS_MAPPER_LOCATION_PATTERN_LIST = "classpath:mybatis/**/*Mapper.xml,classpath:/mapper/**/*_SQL.xml,/WEB-INF/mapper/**/*Mapper.xml,classpath:/mapper/**/*Mapper.xml";
	
	@Value("#{biz['config.mybatis.config.file']?:'"+MYBATIS_CONFIG_FILE+"'}")
	private String mybatisConfigFile;
	
	@Value("#{biz['config.mybatis.mapper.patterns']?:'"+MYBATIS_MAPPER_LOCATION_PATTERN_LIST+"'}")
	private String mybatisMapperPatterns;
	
	@Resource
	private ApplicationContext applicationContext;

	@Bean(name = {"sqlSession", "sqlSessionFactory"})
	public SqlSessionFactory sqlSessionFactory(@Qualifier("dataSource") DataSource dataSource) throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(dataSource);

//		Mybatis-Config파일로 설정하는 방법.
//		sqlSessionFactory.setConfigLocation(applicationContext.getResource(mybatisConfigFile));

//		Mybatis-Config를 자바소스로 설정하는 방법.
		org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
		configuration.setCallSettersOnNulls(true);
		configuration.setJdbcTypeForNull(JdbcType.NULL);
		configuration.setCacheEnabled(true);
		// 기본값 사용. configuration.setUseGeneratedKeys(false);
		configuration.setMapUnderscoreToCamelCase(true);
		configuration.setDefaultExecutorType(ExecutorType.REUSE);
		configuration.setLogPrefix("mapper.");
		sqlSessionFactory.setConfiguration(configuration );
		
		List<org.springframework.core.io.Resource> resources = new ArrayList<org.springframework.core.io.Resource>();
		
		for (String mapperLocationPattern : mybatisMapperPatterns.split(",")) {
			resources.addAll(Arrays.asList(applicationContext.getResources(mapperLocationPattern.trim())));
		}
		
		sqlSessionFactory.setMapperLocations(resources.toArray(new org.springframework.core.io.Resource[resources.size()]));
//		sqlSessionFactory.setTypeAliasesPackage("<mapper namespace='jin.mes.form.basMgt.codeMgt.CodeMgtMapper'> << 해당부분 중 jin.mes.form를 써놓으면 실제 구현된 Mapper에서는 이후의 패키지명만 사용하면 된다.");
//		sqlSessionFactory.setTypeHandlers(new TypeHandler[] {
//				new DateTypeHandler()
//				, new BooleanTypeHandler()
//				, new 사용자_타입_헨들러(enum 같은 것을 사용할 수 있다.)
//		});
		log.debug("로드된 Mapper 갯수[{}], resources[{}]", resources.size(), resources);
		
		return (SqlSessionFactory) sqlSessionFactory.getObject();
	}

	@Bean(name = {"sqlSessionTemplate"})
	public SqlSessionTemplate sqlSessionTemplate(@Qualifier("sqlSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
		SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
		return sqlSessionTemplate;
	}

}
