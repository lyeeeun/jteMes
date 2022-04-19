package kr.co.itcall.jte.common.mvc;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.impl.JPAQuery;


/**<pre>
 * <b>kr.co.itcall.jte.common.mvc</b>
 * <b>CustomQueryDslSupport.java</b>
 * <p>Descriptions : queryDsl 공통 부분</p>
 * </pre>
 * 
 * @author  : rlawhdrn456@jintech2ng.co.kr
 * @Date    : 2020. 1. 7.
 * @Version : 
 */
public abstract class CustomQueryDslSupport extends QuerydslRepositorySupport{

	public CustomQueryDslSupport(Class<?> domainClass) {
		super(domainClass);
	}
	
	/**<pre>
	 * 1. 개요 : multi-sort 관련 공통 소스(kendoGrid의 최적화 되어 있음) 
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : multiSort
	 * @param pageVO
	 * @param jpaQuery
	 * @param entityPath
	 */
	public void multiSort(KendoPageVO pageVO, JPAQuery<?> jpaQuery, PathBuilder<?> entityPath){
			if(!StringUtils.isEmpty(pageVO.getSort())) {
				
				//sort부분이 json타입으로 넘어와 파싱하는작업 - json말고 다른 방법이 있으면 변경 가능.
				ObjectMapper mapper = new ObjectMapper();
//				List<HashMap<String, String>> map = mapper.readValue(pageVO.getSort().replaceAll("&quot;", "\""),List.class);
//				for(HashMap<String,String> sortMap : map) {
				//반복문으로 orderBy할당
				for(int i = 0; i < pageVO.getSort().size(); i++) {
					String[] sortSplit = pageVO.getSort().get(i).split(" ");
					
					if(sortSplit[1].equals("desc")) {
						jpaQuery = jpaQuery.orderBy(new OrderSpecifier<>(Order.DESC, Expressions.stringPath(entityPath, sortSplit[0])));
					}else {
						jpaQuery = jpaQuery.orderBy(new OrderSpecifier<>(Order.ASC, Expressions.stringPath(entityPath,sortSplit[0])));
					}
				};
				
			}else {
				//sort문이 없다면 기본 updatedAt으로 orderBy - table에 updatedAt이 없다면 에러 발생할지도..
				jpaQuery = jpaQuery.orderBy(new OrderSpecifier<>(Order.DESC, Expressions.stringPath(entityPath,"updatedAt")));
			}
	}
	
	/**<pre>
	 * 1. 개요 : SearchGubun,SearchText 부분 동적 처리관련 부분
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : dynamicSearch
	 * @param pageVO
	 * @param jpaQuery
	 * @param entityPath
	 */
	public void dynamicSearch(KendoPageVO pageVO, JPAQuery<?> jpaQuery, PathBuilder<?> entityPath) {
		//동적처리를 위한 Builder(where)
		BooleanBuilder builder = new BooleanBuilder();
		
		if (!StringUtils.isEmpty(pageVO.getSearchGubun())) {
			builder.and(Expressions.stringPath(entityPath,pageVO.getSearchGubun()).like("%"+pageVO.getSearchText()+"%"));
		}
		
		if (!StringUtils.isEmpty(builder)) {
			jpaQuery = jpaQuery.where(builder);
		}
	}
	
}
