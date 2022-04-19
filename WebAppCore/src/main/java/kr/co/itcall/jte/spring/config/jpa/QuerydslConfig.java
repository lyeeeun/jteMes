package kr.co.itcall.jte.spring.config.jpa;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.querydsl.jpa.impl.JPAQueryFactory;




/**<pre>
 * <p>Descriptions : Querydsl을 사용하기 위한 configuration</p>
 * </pre>
 * @author  : jkkim@jintech2ng.co.kr
 * @Date    : 2019. 12. 23.
 * @Version : 
 */
@Configuration
public class QuerydslConfig {
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@Bean
	public JPAQueryFactory jpaQuery() { 
		return new JPAQueryFactory(entityManager);
	}

}
