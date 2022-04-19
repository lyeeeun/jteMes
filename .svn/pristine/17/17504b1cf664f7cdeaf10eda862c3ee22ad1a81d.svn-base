package jin.mes.form.basMgt.belngMgt.posInfo;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

import kr.co.itcall.jte.common.mvc.CustomQueryDslSupport;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.spring.user.model.PositionInfoVo;
import kr.co.itcall.jte.spring.user.model.QPositionInfoVo;

@Service
public class PosInfoService extends CustomQueryDslSupport{
	
	//생성자
	public PosInfoService() {
		super(PositionInfoVo.class);
	}
	
	@Resource
	PosInfoRepository posInfoRepository;
	
	/**<pre>
	 * 1. 개요 : 직급 Base 조회(grid)
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : getPositionList
	 * @param pageVO
	 * @return Page<PositionInfoVo>
	 */
	public Page<PositionInfoVo> getPositionList(KendoPageVO pageVO){
		//QureyDsl Factory 생성
		JPAQueryFactory query = new JPAQueryFactory(this.getEntityManager());
		//QureyDsl 객체
		final QPositionInfoVo positionInfoVo = QPositionInfoVo.positionInfoVo;
		
		//최종 조회될 query를 받기위한 type 
		QueryResults<PositionInfoVo> queryResults = null;
		
		//페이징 관련  세팅
		Pageable pageable = PageRequest.of(pageVO.getPage()-1, pageVO.getRows());
		
		try {
			//동적처리를 위한 PathBuilder
			PathBuilder<QueryResults> entityPath = new PathBuilder<>(QueryResults.class, "positionInfoVo");
		
			//Select FROM 부분
			JPAQuery<PositionInfoVo> jpaQuery = query.selectFrom(positionInfoVo);
			
			//동적처리를 위한 Builder(where)
			BooleanBuilder builder = new BooleanBuilder();
			
			if (!StringUtils.isEmpty(pageVO.getDynamicValue())) {
				for(int i = 0; i < pageVO.getDynamicValue().size(); i++) {
					if(!StringUtils.isEmpty(pageVO.getDynamicValue())) {
						String field = Expressions.stringPath(entityPath,pageVO.getDynamicField().get(i)).toString();
						if (field.equals("positionInfoVo.isUse")) {//isUse 예외처리
							builder.and(positionInfoVo.isUse.eq(Boolean.valueOf(pageVO.getDynamicValue().get(i))));
						}else {
							builder.and(Expressions.stringPath(entityPath,pageVO.getDynamicField().get(i)).eq(pageVO.getDynamicValue().get(i)));
						}
					}
				}
				if (!StringUtils.isEmpty(builder)) {
					jpaQuery = jpaQuery.where(builder);
				}
			}
			
			//SearchGubun,SearchText 부분 공통으로 묶음
			this.dynamicSearch(pageVO, jpaQuery, entityPath);
			
			//multi-sort부분 공통으로 묶음
			this.multiSort(pageVO, jpaQuery, entityPath);
			
			//페이징 조회
			queryResults = jpaQuery 
					.offset(pageable.getOffset()).limit(pageable.getPageSize())
					.fetchResults();
		}catch(Exception ex){
			ex.printStackTrace();
		}	
		return new PageImpl<>(queryResults.getResults(), pageable, queryResults.getTotal());
	}
	
	/**<pre>
	 * 1. 개요 : 직급 Base 입력, 수정(grid)
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : setPositionSave
	 * @param posInfoVo
	 * @return
	 */
	@Transactional
	public void setPositionSave(PositionInfoVo posInfoVo){
		try {
			posInfoRepository.save(posInfoVo);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}

	/**<pre>
	 * 1. 개요 : 직급 Base 삭제(grid) 
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : setPositionDelete
	 * @param posInfoVo
	 */
	@Transactional
	public void setPositionDelete(List<PositionInfoVo> posInfoVo){
		posInfoRepository.deleteAll(posInfoVo);
	}
}
