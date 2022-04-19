package kr.co.itcall.jte.spring.user.service;

import kr.co.itcall.jte.spring.config.exception.SystemException;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;

public interface UserService {

	public void saveUser(UserInfoVo user, String[] roles);

	/**
	 * <pre>
	 * 1. 개요 : 사용자ID로 사용자정보를 가져온다.
	 * 2. 처리내용 : 정상적인 사용자를 대상으로만 가져온다.
	 * </pre>
	 * @Method : findByUserId
	 * @param userId
	 * @return
	 */
	public UserInfoVo findByUserId(String userId) throws SystemException;

	public UserInfoVo findByUserIdAndIsLockAndIsDel(String userId, boolean isLock, boolean isDel) throws SystemException;

	public UserInfoVo findByUserIdFromAll(String userId) throws SystemException;

}
