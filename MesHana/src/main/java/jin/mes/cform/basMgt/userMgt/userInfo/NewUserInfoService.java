package jin.mes.cform.basMgt.userMgt.userInfo;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

import jin.mes.cform.basMgt.userMgt.userAuth.NewUserAuthDto;
import jin.mes.common.cache.CacheUtil;
import kr.co.itcall.jte.common.mvc.CustomQueryDslSupport;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import kr.co.itcall.jte.spring.user.model.QUserInfoVo;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.spring.user.repository.UserRepository;

@Service
public class NewUserInfoService extends CustomQueryDslSupport {

	public NewUserInfoService() {
		super(UserInfoVo.class);
	}
	
	@Resource
	NewUserInfoMapper newUserMapper;
	
	@Resource
	UserRepository userRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	private static final String PW_DEFAULT= "1q2w3e~!@";
	
	public PageInfo<NewUserInfoDto> getUserList(NewUserInfoDto newUserInfo, PageRequestVo pageRequestVo){
		List<NewUserInfoDto> userList = null;
		int rowCount = 0;

		// Page Setting
		newUserInfo.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newUserInfo.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newUserMapper.selectUserListCount(newUserInfo);
			if (rowCount > 0) {
				//List
				userList = newUserMapper.selectUserList(newUserInfo);
			}
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (userList == null) {
			userList = new ArrayList<NewUserInfoDto>();
		}
		return new PageInfo<NewUserInfoDto>(userList, pageRequestVo, rowCount);
	}
	
	
	public List<NewUserAuthDto> getUserRoleList(NewUserAuthDto newUserAuthDto){
		List<NewUserAuthDto> userAuthList = null;
		try {
			userAuthList = newUserMapper.selectUserRoleList(newUserAuthDto);
		} catch (Exception e) {
			throw new BusinessException("수주조회 에러입니다. : " + e.getMessage());
		}
		if (userAuthList == null) {
			userAuthList = new ArrayList<NewUserAuthDto>();
		}
		return userAuthList;
	}
	
	
	public Page<UserInfoVo> getPopUserList(KendoPageVO pageVO) {
		// QureyDsl Factory 생성
		JPAQueryFactory query = new JPAQueryFactory(this.getEntityManager());
		// QureyDsl 객체
		final QUserInfoVo newUserInfo = QUserInfoVo.userInfoVo;
			  
		// 최종 조회될 query를 받기위한 type
		QueryResults<UserInfoVo> queryResults = null;

		// 페이징 관련 세팅
		Pageable pageable = PageRequest.of(pageVO.getPage() - 1, pageVO.getRows());

		try {
			// 동적처리를 위한 PathBuilder
			PathBuilder<QUserInfoVo> entityPath = new PathBuilder<>(QUserInfoVo.class, "userInfoVo");

			// Select FROM 부분
			JPAQuery<UserInfoVo> jpaQuery = query.selectFrom(newUserInfo).where(newUserInfo.isLock.eq(false).and(newUserInfo.isDel.eq(false)));

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
	
	@Transactional
	public int setUserSave(NewUserInfoDto newUserInfoDto){
		int resultInt = -1;
		try {
			newUserInfoDto.setCreatorId(JteUtils.getUserId());
			newUserInfoDto.setUpdatorId(JteUtils.getUserId());
			
			if(newUserInfoDto.getAction().equals("C")) {//사용자 등록
				//초기 패스워드 세팅
				newUserInfoDto.setPassword(passwordEncoder.encode(CacheUtil.getCode("pw_set",PW_DEFAULT).getCdVal()));
				
				//사용자입력
				resultInt = newUserMapper.insertUserInfo(newUserInfoDto);
				//권한입력
				if(resultInt > 0)
					resultInt = newUserMapper.insertUserRole(newUserInfoDto);
			}else if(newUserInfoDto.getAction().equals("U")){//사용자 변경
				//사용자수정
				resultInt = newUserMapper.updateUserInfo(newUserInfoDto);
				//권한삭제
				if(resultInt > 0)
					resultInt = newUserMapper.deleteUserRole(newUserInfoDto);
				//권한입력
				if(resultInt >= 0)
					resultInt = newUserMapper.insertUserRole(newUserInfoDto);
			}else if(newUserInfoDto.getAction().equals("PW")){//패스워드 초기화
				//패스워드 변경
				String userPw = "";
				if(newUserInfoDto.getPassword() == null || newUserInfoDto.getPassword().equals("")) {
					userPw = CacheUtil.getCode("pw_set",PW_DEFAULT).getCdVal();
				}else {
					userPw = newUserInfoDto.getPassword();
				}
				newUserInfoDto.setPassword(passwordEncoder.encode(userPw));
				//사용자수정
				resultInt = newUserMapper.updateUserInfo(newUserInfoDto);
			}else if(newUserInfoDto.getAction().equals("LOCK")){//사용자 잠금/해제
				if(newUserInfoDto.isLock()) {
					newUserInfoDto.setFailCnt(0);
					newUserInfoDto.setLock(false);
				}else {
					newUserInfoDto.setLock(true);
				}
				//사용자수정	
				resultInt = newUserMapper.updateUserInfo(newUserInfoDto);
			}else if(newUserInfoDto.getAction().equals("MYCFG")) {//사용자 설정 변경(사용자)
				String userPw = "";
				String pwPrev = "";
				UserInfoVo userVo = null;
				
				if(newUserInfoDto.getPasswordPrev() != null && !newUserInfoDto.getPasswordPrev().equals("") && newUserInfoDto.getPassword() != null && !newUserInfoDto.getPassword().equals("")) {
					pwPrev = passwordEncoder.encode(newUserInfoDto.getPasswordPrev());
					userVo =  userRepository.findByUserId(newUserInfoDto.getUserId());
					
					if(passwordEncoder.matches(newUserInfoDto.getPasswordPrev(), userVo.getPassword())) {
						newUserInfoDto.setPassword(passwordEncoder.encode(newUserInfoDto.getPassword()));
					}else {
						throw new Exception("패스워드가 일치하지 않습니다.");
					}
				}
				
				//사용자수정
				resultInt = newUserMapper.updateUserInfo(newUserInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("사용자 입력 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}

}
