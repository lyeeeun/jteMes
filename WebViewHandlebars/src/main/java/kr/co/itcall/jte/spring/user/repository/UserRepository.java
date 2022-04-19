package kr.co.itcall.jte.spring.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.co.itcall.jte.spring.user.model.UserInfoVo;

public interface UserRepository extends JpaRepository<UserInfoVo, Long> {

	// @Query("select u from UserInfoVo u where u.userId = :userId")
	public UserInfoVo findByUserId(/* @Param("userId") */String userId);

	public UserInfoVo findByUserIdAndIsLockAndIsDel(String userId, boolean isLock, boolean isDel);

}
