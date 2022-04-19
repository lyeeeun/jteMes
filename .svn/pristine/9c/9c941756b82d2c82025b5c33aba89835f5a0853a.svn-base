package kr.co.itcall.jte.spring.config.jpa;

import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.interceptor.TransactionInterceptor;

import lombok.extern.slf4j.Slf4j;
import net.sf.log4jdbc.Log4jdbcProxyDataSource;
import net.sf.log4jdbc.tools.Log4JdbcCustomFormatter;
import net.sf.log4jdbc.tools.LoggingType;

@Slf4j
@EnableAspectJAutoProxy
@Configuration
@EnableTransactionManagement
@DependsOn({"propertiesConfig"})
public class DbConfig {

	@Value("${spring.profiles.active:prd}")
	private String profile;

	@Value("${spring.datasource.driver-name:}")
	private String cmdDriverClassName;
	@Value("${spring.datasource.url:}")
	private String cmdDataSourceUrl;
	@Value("${spring.datasource.username:}")
	private String cmdDataSourceUsername;
	@Value("${spring.datasource.password:}")
	private String cmdDataSourcePassword;

	@Value("${spring.datasource.jndi-name:}")
	private String jndiName;

	@Value("#{biz['spring.datasource.driver-name']?:'org.postgresql.Driver'}")
	private String driverClassName;
	@Value("#{biz['spring.datasource.url']?:''}")
	private String dataSourceUrl;
	@Value("#{biz['spring.datasource.username']?:''}")
	private String dataSourceUsername;
	@Value("#{biz['spring.datasource.password']?:''}")
	private String dataSourcePassword;


	@Value("${test.enc.data:}")
	private String cmdLinePwd;

	@Value("${spring.app.enc.test:}")
	private String bootPropertiesPwd;

	@Value("#{app['app.prop.enc.test']?:''}")
	private String appPropertiesPwd;

	@Value("#{biz['biz.prop.enc.test']?:''}")
	private String bizPropertiesPwd;

	@Value("${biz.prop.enc.test:}")
	private String bizPropertiesPwdUsingProfile;



	@Bean(name = {"preDataSource"})
	@DependsOn(value= {"dbConfig"})
	public DataSource preDataSource() {
//		log.info("dataSourcePassword[{}]\n, cmdLinePwd[{}]\n, bootPropertiesPwd[{}]\n, appPropertiesPwd[{}]\n, bizPropertiesPwd[{}]\n, bizPropertiesPwdUsingProfile[{}]",dataSourcePassword, cmdLinePwd, bootPropertiesPwd, appPropertiesPwd, bizPropertiesPwd, bizPropertiesPwdUsingProfile);
//		log.error("테스트용........ㅌㅌ-!!xuㅌㅌ......");
		DriverManagerDataSource dataSource = null;
		try {
			JndiDataSourceLookup dataSourceLookup = new JndiDataSourceLookup();
			DataSource jndiDataSource = dataSourceLookup.getDataSource(this.jndiName);
			log.info("Looking for Jndi[{}] is Success...", this.jndiName);
			return jndiDataSource;
		} catch (Exception e) {
			dataSource = new DriverManagerDataSource();
			configureDataSource(dataSource);
			return dataSource;
		}
	}

	@Primary
	@Bean(name = {"dataSource","log4DataSource"}/*, destroyMethod = "close"*/)
	@DependsOn(value= {"preDataSource"})
	public DataSource log4DataSource(@Qualifier("preDataSource") DataSource dataSource) {
		Log4JdbcCustomFormatter log4JdbcCustomFormatter = new Log4JdbcCustomFormatter();
		log4JdbcCustomFormatter.setLoggingType(LoggingType.MULTI_LINE);
		log4JdbcCustomFormatter.setSqlPrefix("MASTER.SQL:::     ");
		
		Log4jdbcProxyDataSource log4DataSource = new Log4jdbcProxyDataSource(dataSource);
		log4DataSource.setLogFormatter(log4JdbcCustomFormatter);
		return log4DataSource;
	}

	@Primary
	@Bean(name = {"transactionManager"}) // DataSourceTransactionManager, PlatformTransactionManager
	public PlatformTransactionManager transactionManager(@Qualifier("dataSource") DataSource dataSource) {
		DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(dataSource);
		transactionManager.setGlobalRollbackOnParticipationFailure(false);
		return transactionManager;
	}

	@Bean
	public Advisor txAdviceAdvisor(@Qualifier("transactionManager") PlatformTransactionManager transactionManager) {
		AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();		pointcut.setExpression(
				new StringBuffer().append("execution(public * kr.co.itcall.jte.api..service.*Impl.*(..))")
				.append(" or ")
				.append("execution(public * kr.co.itcall.jte.common..service..*Impl.*(..))")
				.append(" or ")
				.append("execution(public * atos..service..*Service.*(..))")
				/*********************************************************************************
				 *		JOB으로 선언된 class들은 별도 Transaction으로 묶여있기 때문에
				 *		여기서 정의해주면 컨테이너에 이중으로 등록되는 에러가 발생한다.
				.append(" or ")
				.append("execution(public * kr.co.itcall.jte.batch..*Tasklet.*(..))")
				.append(" or ")
				.append("execution(public * kr.co.itcall.jte.batch..*Writer.*(..))")
				*********************************************************************************/
				.toString());
		return new DefaultPointcutAdvisor(pointcut, txAdvice(transactionManager));
	}

	public TransactionInterceptor txAdvice(PlatformTransactionManager transactionManager) {
		Properties props = new Properties();
		props.setProperty("add*", "PROPAGATION_REQUIRED,-java.lang.RuntimeException"); // RuntimeException 에서만 Rollback이 일어나는게 기본값임.
		props.setProperty("save*", "PROPAGATION_REQUIRED,-java.lang.RuntimeException");
		props.setProperty("insert*", "PROPAGATION_REQUIRED,-java.lang.RuntimeException");
		props.setProperty("set*", "PROPAGATION_REQUIRED,-java.lang.RuntimeException");
		props.setProperty("update*", "PROPAGATION_REQUIRED,-java.lang.RuntimeException");
		props.setProperty("remove*", "PROPAGATION_REQUIRED,-java.lang.RuntimeException");
		props.setProperty("del*", "PROPAGATION_REQUIRED,-java.lang.RuntimeException");
		props.setProperty("*", "PROPAGATION_NOT_SUPPORTED,readOnly");
		TransactionInterceptor txAdvice = new TransactionInterceptor(transactionManager, props);
		return txAdvice;
	}

	private void configureDataSource(DriverManagerDataSource dataSource) {

		log.info("configureDataSource = [{}]", dataSource);

		if(StringUtils.isEmpty(this.cmdDriverClassName)) {
			dataSource.setDriverClassName(this.driverClassName);
		}else {
			dataSource.setDriverClassName(this.cmdDriverClassName);
			log.info("Your type dbDriver[{}] from cmd-mode...", this.cmdDriverClassName);
		}
		if(StringUtils.isEmpty(this.cmdDataSourceUrl)) {
			dataSource.setUrl(this.dataSourceUrl);
		}else {
			dataSource.setUrl(this.cmdDataSourceUrl);
			log.info("Your type dbUrl[{}] from cmd-mode...", this.cmdDataSourceUrl);
		}
		if(StringUtils.isEmpty(this.cmdDataSourceUsername)) {
			dataSource.setUsername(this.dataSourceUsername);
		}else {
			dataSource.setUrl(this.cmdDataSourceUsername);
			log.info("Your type dbUsername[{}] from cmd-mode...", this.cmdDataSourceUsername);
		}
		if(StringUtils.isEmpty(this.cmdDataSourcePassword)) {
			dataSource.setPassword(this.dataSourcePassword);
		}else {
			dataSource.setPassword(this.cmdDataSourcePassword);
			log.info("Your type dbPassword[{}] from cmd-mode...", this.cmdDataSourcePassword);
		}
//		dataSource.setMaxActive(this.maxActive);
//		dataSource.setMaxIdle(this.maxIdle);
//		dataSource.setMinIdle(this.minIdle);
//		dataSource.setMaxWait(this.maxWait);
//		dataSource.setInitialSize(this.initialSize);
//		/*************************************************************
//		 * AltibaseDB의 경우 BLOB/CLOB 데이터 처리시 AutoCommit모드가 true일때 오류가 발생한다.
//		 * 특히 SqlSession을 가져와서 Open하여 사용할땐 꼭 옵션을  false를 사용해야 한다.
//		 *************************************************************/
//		dataSource.setDefaultAutoCommit(true); // 원래기본값이 true이고 false일 경우 꼭 commit을 업무단위에서 해야한다.
//		dataSource.setTestOnBorrow(false);
//		dataSource.setTestOnReturn(false);
	}
//	@Value("${datasource.initial-size:10}")
//	private int initialSize;
//	
//	@Value("${datasource.max-active:10}")
//	private int maxActive;
//	
//	@Value("${datasource.max-idle:10}")
//	private int maxIdle;
//	
//	@Value("${datasource.min-idle:10}")
//	private int minIdle;
//	
//	@Value("${datasource.max-wait:3000}")
//	private int maxWait;
}
