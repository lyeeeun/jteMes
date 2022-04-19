package kr.co.itcall.jte.spring.user.service;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.itcall.jte.spring.config.security.type.RoleBaseCd;
import kr.co.itcall.jte.spring.user.model.RoleInfoVo;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import kr.co.itcall.jte.spring.user.repository.UserRepository;
import kr.co.itcall.jte.spring.user.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public void saveUser(UserInfoVo user, String[] roles) {
		String encodePassword = passwordEncoder.encode(user.getPassword());
		log.info("Password to encription raw[{}] >>> enc[{}]", user.getPassword(), encodePassword);
		user.setPassword(encodePassword);
		Set<RoleInfoVo> rolesSet = RoleBaseCd.getExistRoles(roles); // 존재하는 권한만 추가할 수 있다.
		user.setRoles(rolesSet);
		log.info("UserInfo[{}]", user);
		userRepository.save(user);
	}

	@Override
	public UserInfoVo findByUserId(String userId) {
		return userRepository.findByUserIdAndIsLockAndIsDel(userId, false, false);
	}

	@Override
	public UserInfoVo findByUserIdFromAll(String userId) {
		return userRepository.findByUserId(userId);
	}

	@Override
	public UserInfoVo findByUserIdAndIsLockAndIsDel(String userId, boolean isLock, boolean isDel) {
		return userRepository.findByUserIdAndIsLockAndIsDel(userId, isLock, isDel);
	}

}
