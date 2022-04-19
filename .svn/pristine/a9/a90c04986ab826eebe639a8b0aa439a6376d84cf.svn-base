package jin.mes.form.basMgt.authMgt.grpAuth;

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
import kr.co.itcall.jte.spring.user.model.QRoleInfoVo;
import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import kr.co.itcall.jte.spring.user.model.RtlRoleAuth;
import kr.co.itcall.jte.spring.user.repository.RtlRoleAuthRepository;

/**
 * <pre>
 * <b>jin.mes.form.operMgt.roleMgt</b>
 * <b>RoleMgtServiceImpl.java</b>
 * <p>Descriptions : 권한그룹 서비스
 *    1.queryDsl과 기본 jpa를 사용하였다.
 *    2.CustomQueryDslSupport를 extends를 사용한다.(공통사용되는 queryDsl 부분 따로 정리) 
 * </p>
 * </pre>
 * 
 * @author : rlawhdrn456@jintech2ng.co.kr
 * @Date : 2020. 1. 7.
 * @Version :
 */
@Service
public class RoleMgtServiceImpl extends CustomQueryDslSupport {

	// 생성자
	public RoleMgtServiceImpl() {
		super(RoleInfoVo.class);
	}

	@Resource
	RoleMgtRepository roleMgtRepository;
	
	@Resource
	RtlRoleAuthRepository rtlRoleAuthRepository;

	/* @Override */
	/**
	 * <pre>
	 * 1. 개요 : 그룹코드 조회(grid)
	 * 2. 처리내용 :
	 * </pre>
	 * 
	 * @Method : getRoleGrp
	 * @param pageVO
	 * @return
	 */
	public Page<RoleInfoVo> getRoleGrp(KendoPageVO pageVO) {
		
		// QureyDsl Factory 생성
		JPAQueryFactory query = new JPAQueryFactory(this.getEntityManager());
		// QureyDsl 객체
		final QRoleInfoVo roleInfo = QRoleInfoVo.roleInfoVo;

		// 최종 조회될 query를 받기위한 type
		QueryResults<RoleInfoVo> queryResults = null;

		// 페이징 관련 세팅
		Pageable pageable = PageRequest.of(pageVO.getPage() - 1, pageVO.getRows());
		try {
			// 동적처리를 위한 PathBuilder
			PathBuilder<QRoleInfoVo> entityPath = new PathBuilder<>(QRoleInfoVo.class, "roleInfoVo");

			// Select FROM 부분
			JPAQuery<RoleInfoVo> jpaQuery = query.selectFrom(roleInfo);

			//동적처리를 위한 Builder(where)
			BooleanBuilder builder = new BooleanBuilder();
			
			if (!StringUtils.isEmpty(pageVO.getDynamicValue())) {
				for(int i = 0; i < pageVO.getDynamicValue().size(); i++) {
					if (!StringUtils.isEmpty(pageVO.getDynamicValue())) {
						builder.and(Expressions.stringPath(entityPath,pageVO.getDynamicField().get(i)).eq(pageVO.getDynamicValue().get(i)));
					}
				}
				if (!StringUtils.isEmpty(builder)) {
					jpaQuery = jpaQuery.where(builder);
				}
			}
			// SearchGubun,SearchText 부분 공통으로 묶음
			this.dynamicSearch(pageVO, jpaQuery, entityPath);

			// multi-sort부분 공통으로 묶음
			this.multiSort(pageVO, jpaQuery, entityPath);

			// 페이징 조회
			queryResults = jpaQuery.offset(pageable.getOffset()).limit(pageable.getPageSize()).fetchResults();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return new PageImpl<>(queryResults.getResults(), pageable, queryResults.getTotal());
	}

	//
	/**
	 * <pre>
	 * 1. 개요 : 그룹코드 입력(gird)
	 * 2. 처리내용 :
	 * </pre>
	 * 
	 * @Method : setRoleGrpInsert
	 * @param roleInfoVo
	 * @return
	 */
	@Transactional
	public RoleInfoVo setRoleGrpInsert(RoleInfoVo roleInfoVo) {
		RoleInfoVo roInfoVo2 = null;
		try {
			roInfoVo2 = roleMgtRepository.save(roleInfoVo);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return roInfoVo2;
	}

	/**
	 * <pre>
	 * 1. 개요 : 그룹코드 수정(gird)
	 * 2. 처리내용 :
	 * </pre>
	 * 
	 * @Method : setRoleGrpUpdate
	 * @param roleInfoVo
	 * @return
	 */
	@Transactional
	public int setRoleGrpUpdate(RoleInfoVo roleInfoVo) {
		int resultInt =-3;
		try {
			resultInt = roleMgtRepository.updateByRoleId(roleInfoVo.getRoleId(), roleInfoVo.getRoleNm(),roleInfoVo.getDescription());	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultInt;
	}
	
	/**
	 * <pre>
	 * 1. 개요 : 그룹코드 삭제(gird)
	 * 2. 처리내용 :
	 * </pre>
	 * 
	 * @Method : setRoleGrpDelete
	 * @param roleInfoVo
	 */
	@Transactional
	public void setRoleGrpDelete(List<String> roleIds) {
		try {
			rtlRoleAuthRepository.delRtlRoleAuthByRoleIds(roleIds);
			
			roleMgtRepository.deleteByRoleIds(roleIds);	
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}


	/* @Override */
	/**
	 * <pre>
	 * 1. 개요 : 그룹코드 조회(grid)
	 * 2. 처리내용 :
	 * </pre>
	 * 
	 * @Method : getRoleGrp
	 * @param pageVO
	 * @return
	 */
	public Page<RoleInfoVo> getRoleGrpAuth(KendoPageVO pageVO) {
		// QureyDsl Factory 생성
		JPAQueryFactory query = new JPAQueryFactory(this.getEntityManager());
		// QureyDsl 객체
		final QRoleInfoVo roleInfo = QRoleInfoVo.roleInfoVo;

		// 최종 조회될 query를 받기위한 type
		QueryResults<RoleInfoVo> queryResults = null;

		// 페이징 관련 세팅
		Pageable pageable = PageRequest.of(pageVO.getPage() - 1, pageVO.getRows());

		try {
			// 동적처리를 위한 PathBuilder
			PathBuilder<QRoleInfoVo> entityPath = new PathBuilder<>(QRoleInfoVo.class, "roleInfoVo");

			// Select FROM 부분
			JPAQuery<RoleInfoVo> jpaQuery = query.selectFrom(roleInfo);

			//동적처리를 위한 Builder(where)
			BooleanBuilder builder = new BooleanBuilder();
			
			if (!StringUtils.isEmpty(pageVO.getDynamicValue())) {
				for(int i = 0; i < pageVO.getDynamicValue().size(); i++) {
					if (!StringUtils.isEmpty(pageVO.getDynamicValue())) {
						builder.and(Expressions.stringPath(entityPath,pageVO.getDynamicField().get(i)).eq(pageVO.getDynamicValue().get(i)));
					}
				}
				if (!StringUtils.isEmpty(builder)) {
					jpaQuery = jpaQuery.where(builder);
				}
			}
			// SearchGubun,SearchText 부분 공통으로 묶음
			this.dynamicSearch(pageVO, jpaQuery, entityPath);

			// multi-sort부분 공통으로 묶음
			this.multiSort(pageVO, jpaQuery, entityPath);

			// 페이징 조회
			queryResults = jpaQuery.offset(pageable.getOffset()).limit(pageable.getPageSize()).fetchResults();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return new PageImpl<>(queryResults.getResults(), pageable, queryResults.getTotal());
	}
}
