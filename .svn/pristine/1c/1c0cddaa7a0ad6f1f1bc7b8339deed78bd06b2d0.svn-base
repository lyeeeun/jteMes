package jin.mes.form.basMgt.authMgt.authInfo;

import java.util.List;
import java.util.Map;

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
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.CaseBuilder;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

import kr.co.itcall.jte.common.mvc.CustomQueryDslSupport;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import kr.co.itcall.jte.spring.user.model.QRoleInfoVo;
import kr.co.itcall.jte.spring.user.model.QRtlRoleAuth;
import kr.co.itcall.jte.spring.user.repository.RtlRoleAuthRepository;


/**<pre>
 * <b>jin.mes.form.operMgt.authInfo</b>
 * <b>AuthInfoServiceImpl.java</b>
 * <p>Descriptions : 권한베이스 서비스
 *    1.queryDsl과 기본 jpa를 사용하였다.
 *    2.CustomQueryDslSupport를 extends를 사용한다.(공통사용되는 queryDsl 부분 따로 정리) 
 * </p>
 * </pre>

 * @author  : rlawhdrn456@jintech2ng.co.kr
 * @Date    : 2020. 1. 7.
 * @Version : 
 */
@Service
public class AuthInfoServiceImpl extends CustomQueryDslSupport {
	
	//생성자
	public AuthInfoServiceImpl() {
		super(AuthInfoModel.class);
	}
	
	@Resource
	AuthInfoRepository authInfoRepository;
	
	@Resource
	RtlRoleAuthRepository rtlRoleAuthRepository;
	
	/**<pre>
	 * 1. 개요 : 권한 Base 조회(grid)
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : getAuthList
	 * @param pageVO
	 * @return Page<AuthInfoModel>
	 */
	public Page<AuthInfoModel> getAuthList(KendoPageVO pageVO){
		//QureyDsl Factory 생성
		JPAQueryFactory query = new JPAQueryFactory(this.getEntityManager());
		//QureyDsl 객체
		final QAuthInfoModel authInfoModel = QAuthInfoModel.authInfoModel;
		
		//최종 조회될 query를 받기위한 type 
		QueryResults<AuthInfoModel> queryResults = null;
		
		//페이징 관련  세팅
		Pageable pageable = PageRequest.of(pageVO.getPage()-1, pageVO.getRows());
		
		try {
			//동적처리를 위한 PathBuilder
			PathBuilder<QAuthInfoModel> entityPath = new PathBuilder<>(QAuthInfoModel.class, "authInfoModel");
		
			//Select FROM 부분
			JPAQuery<AuthInfoModel> jpaQuery = query.selectFrom(authInfoModel);
			
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
	 * 1. 개요 : 권한 Base 입력, 수정(grid)
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : setAuthSave
	 * @param authInfoModel
	 * @return
	 */
	@Transactional
	public AuthInfoModel setAuthSave(AuthInfoModel authInfoModel){
		return authInfoRepository.save(authInfoModel);
	}

	@Transactional
	public void setAuthUpdate(AuthInfoModel authInfoModel){
		authInfoRepository.updateAuthInfo(authInfoModel);
	}
	
	/**<pre>
	 * 1. 개요 : 권한 Base 삭제(grid)
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : setAuthDelete
	 * @param authInfoModel
	 */
	@Transactional
	public String setAuthDelete(List<Map<String, Object>> authList){
		String strResult = "";
		try {
			//for(AuthInfoModel authInfoModel : authList) {
			for(int i=0; i<authList.size(); i++) {
				authInfoRepository.deleteByAuthId((String)authList.get(i).get("authId"));
			}
			strResult = "SUCCESS";
		} catch (Exception e) {
			strResult = "ERROR";
			throw new BusinessException(e.getMessage());
		}
		return strResult;
	}
	
	/**<pre>
	 * 1. 개요 : 권한그룹에 포함된  Base만 조회(서브grid)
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : getGrpAuthList
	 * @param pageVO
	 * @return Page<AuthInfoModel>
	 */
	public Page<AuthInfoModel> getGrpAuthList(KendoPageVO pageVO){ 
		//QureyDsl Factory 생성 
		JPAQueryFactory query = new JPAQueryFactory(this.getEntityManager()); 
		
		//QureyDsl 객체 final 
		QAuthInfoModel authInfoModel = QAuthInfoModel.authInfoModel;
		QRoleInfoVo roleInfoVO = QRoleInfoVo.roleInfoVo;
		QRtlRoleAuth rtlRoleAuth = QRtlRoleAuth.rtlRoleAuth;
		
		//최종 조회될 query를 받기위한 type 
		QueryResults<AuthInfoModel> queryResults = null;
	
		//페이징 관련 세팅 
		Pageable pageable = PageRequest.of(pageVO.getPage()-1, pageVO.getRows());
	
		try { 
			//동적처리를 위한 PathBuilder 
			PathBuilder<QAuthInfoModel> entityPath = new PathBuilder<>(QAuthInfoModel.class, "authInfoModel");
		
			
			//		   SELECT bas.*, role_id AS is_use FROM mb_auth_bas bas
			//		   LEFT OUTER JOIN mb_rtl_role_auth rtl
			//		   ON bas.auth_id = rtl.auth_id AND rtl.role_id = 'role_guest'
					   
					   
			//Select FROM 부분 
			JPAQuery<AuthInfoModel> jpaQuery = query.select(
					Projections.fields(AuthInfoModel.class,
							authInfoModel.authId,authInfoModel.reqSvcUri,authInfoModel.description,
							new CaseBuilder()
							.when(rtlRoleAuth.roleInfo.roleId.isNull())
							.then(false)
							.otherwise(true).as("isUse"))
					)
					.from(authInfoModel)
					.leftJoin(rtlRoleAuth)
					.on(rtlRoleAuth.authInfo.authId.eq(authInfoModel.authId).and(rtlRoleAuth.roleInfo.roleId.eq(pageVO.getDynamicValue().get(0))));
		
					BooleanBuilder builder = new BooleanBuilder(); 
						
			//		for(int i = 0; i < pageVO.getDynamicValue().size(); i++) { 
			//			if (!StringUtils.isEmpty(pageVO.getDynamicValue())) { 
			//				//builder.and(roleInfo.roleId.eq(pageVO.getDynamicValue().get(i))); 
			//				builder.and(Expressions.stringPath(entityPath2,pageVO.getDynamicField().get(i)).eq(pageVO.getDynamicValue().get(i)));
			//			} 
			//		} 
			
			if (!StringUtils.isEmpty(builder)) { 
				jpaQuery = jpaQuery.where(builder); 
			}
			
			//SearchGubun,SearchText 부분 공통으로 묶음 
			this.dynamicSearch(pageVO, jpaQuery, entityPath);
		
			//multi-sort부분 공통으로 묶음 
			this.multiSort(pageVO, jpaQuery, entityPath);
		
			//페이징 조회 
			queryResults = jpaQuery .offset(pageable.getOffset()).limit(pageable.getPageSize()) .fetchResults(); 
		}catch(Exception ex){ 
			ex.printStackTrace(); 
		} 
		return new PageImpl<>(queryResults.getResults(), pageable, queryResults.getTotal()); 
	}
	
	/**<pre>
	 * 1. 개요 : 권한그룹 - 권한base 추가/제거
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method : setGrpAuthInclude
	 * @param roleId
	 * @param authId
	 * @param isInclude
	 */
	public void setGrpAuthInclude(String roleId, String authId, String isInclude) {
		try {
			if(isInclude.equals("false")) {
				rtlRoleAuthRepository.addRtlRoleAuth(roleId, authId);
			}else if(isInclude.equals("true")) {
				rtlRoleAuthRepository.delRtlRoleAuth(roleId, authId);
			}
		}catch(Exception ex){ 
			ex.printStackTrace(); 
		} 
	}
	
//	public Page<AuthInfoModel> getGrpAuthList(KendoPageVO pageVO){ 
//	//QureyDsl Factory 생성 
//		JPAQueryFactory query = new JPAQueryFactory(this.getEntityManager()); 
//		
//		//QureyDsl 객체 final 
//		QAuthInfoModel authInfoModel = QAuthInfoModel.authInfoModel; 
//		
//		QRtlRoleAuth rtlRoleAuth = QRtlRoleAuth.rtlRoleAuth;
//	
//	//최종 조회될 query를 받기위한 type 
//		QueryResults<AuthInfoModel> queryResults = null;
//	
//	//페이징 관련 세팅 
//		Pageable pageable = PageRequest.of(pageVO.getPage()-1, pageVO.getRows());
//	
//	try { 
//		//동적처리를 위한 PathBuilder 
//		PathBuilder<QAuthInfoModel> entityPath = new PathBuilder<>(QAuthInfoModel.class, "authInfoModel");
//		PathBuilder<QRtlRoleAuth> entityPath2 = new PathBuilder<>(QRtlRoleAuth.class, "rtlRoleAuth");
//	
//	
//	//Select FROM 부분 
//		JPAQuery<AuthInfoModel> jpaQuery = query.selectFrom(authInfoModel)
//				.rightJoin(rtlRoleAuth)
//				.on(rtlRoleAuth.authInfo.authId.eq(authInfoModel.authId));
//	
//				BooleanBuilder builder = new BooleanBuilder(); 
//				
//		for(int i = 0; i < pageVO.getDynamicValue().size(); i++) { 
//			if (!StringUtils.isEmpty(pageVO.getDynamicValue())) { 
//				//builder.and(roleInfo.roleId.eq(pageVO.getDynamicValue().get(i))); 
//				builder.and(Expressions.stringPath(entityPath2,pageVO.getDynamicField().get(i)).eq(pageVO.getDynamicValue().get(i)));
//			} 
//		} 
//		
//		if (!StringUtils.isEmpty(builder)) { 
//			jpaQuery = jpaQuery.where(builder); 
//		}
//		
//	//SearchGubun,SearchText 부분 공통으로 묶음 
//		this.dynamicSearch(pageVO, jpaQuery, entityPath);
//	
//	//multi-sort부분 공통으로 묶음 
//		this.multiSort(pageVO, jpaQuery, entityPath);
//	
//	//페이징 조회 
//		queryResults = jpaQuery .offset(pageable.getOffset()).limit(pageable.getPageSize()) .fetchResults(); 
//	}catch(Exception ex){ 
//		ex.printStackTrace(); 
//	} 
//	return new PageImpl<>(queryResults.getResults(), pageable, queryResults.getTotal()); 
//	}
	
}
