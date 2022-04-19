package kr.co.itcall.jte.spring.user.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import jin.mes.form.basMgt.authMgt.authInfo.AuthInfoModel;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.spring.user.repository.RoleRepository;
import kr.co.itcall.jte.spring.user.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserService/* Impl implements UserService */ {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired private RoleRepository roleRepository;

//	@Override
	public void saveUser(UserInfoVo user, String[] roles) {
		String encodePassword = passwordEncoder.encode(user.getPassword());
		log.info("Password to encription raw[{}] >>> enc[{}]", user.getPassword(), encodePassword);
		user.setPassword(encodePassword);
		Set<RoleInfoVo> rolesSet = new HashSet<RoleInfoVo>();
		roleRepository.findAll().stream().filter(r-> Arrays.asList(roles).contains(r.getRoleId())).forEach(r-> rolesSet.add(r)); // collect(Collectors.toSet()); // RoleBaseCd.getExistRoles(roles); // 존재하는 권한만 추가할 수 있다.
//		user.setRoles(rolesSet);
		log.info("UserInfo[{}]", user);
		userRepository.save(user);
	}

//	@Override
	public UserInfoVo findByUserId(String userId) {
		return userRepository.findByUserIdAndIsLockAndIsDel(userId, false, false);
	}

//	@Override
    @Transactional
	public UserInfoVo findByUserIdFromAll(String userId) {
		UserInfoVo userInfoVO= userRepository.findByUserId(userId);
		
		List<String> roleGrpIds = new ArrayList<String>();
		Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
		List<AuthInfoModel> authInfoList = new ArrayList<AuthInfoModel>();
		List<String> authIdList = new ArrayList<String>();
//		for (RoleInfoVo role : user.getRoles()) {
//			for (AuthInfoModel authInfo : role.getAuthInfos()) {
//				grantedAuthorities.add(new SimpleGrantedAuthority(authInfo.getAuthId()));
//				authInfoList.add(authInfo);
//				authIdList.add(authInfo.getAuthId());
//			}
//			// grantedAuthorities.add(new SimpleGrantedAuthority(role.getRoleId()));
//		}

		/********
		 * 중복권한그룹을 소유한 케이스인 경우. 해당 중복된 기본권한들은 한 개만 추춣하여 세션에 저장한다.
		 */
		if(!StringUtils.isEmpty(userInfoVO)) {
			userInfoVO.getRoles().stream().filter(r-> !StringUtils.isEmpty(r)).forEach(r-> {
				r.getAuthInfos().stream().filter(a-> !StringUtils.isEmpty(a)).forEach(a-> {
					if(!authIdList.contains(a.getAuthInfo().getAuthId())) {
						grantedAuthorities.add(new SimpleGrantedAuthority(a.getAuthInfo().getAuthId()));
						authInfoList.add(a.getAuthInfo());
						authIdList.add(a.getAuthInfo().getAuthId());
					}
				});
				roleGrpIds.add(r.getRoleId());
			});
		}
		
		
		return userInfoVO;
	}

//	@Override
	public UserInfoVo findByUserIdAndIsLockAndIsDel(String userId, boolean isLock, boolean isDel) {
		return userRepository.findByUserIdAndIsLockAndIsDel(userId, isLock, isDel);
	}

	public int setLangCdByUserId(Locale locale) {
		return setLangCdByUserId(locale, JteUtils.getUserId());
	}
	public int setLangCdByUserId(Locale locale, String userId) {
		return userRepository.updateLangCdByUserId(locale.getLanguage(), JteUtils.getUserId());
	}

}
