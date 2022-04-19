package kr.co.itcall.jte.spring.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.itcall.jte.spring.user.model.UserInfoVo;

public interface UserRepository extends JpaRepository<UserInfoVo, String> {

	// @Query("select u from UserInfoVo u where u.userId = :userId")
	public UserInfoVo findByUserId(/* @Param("userId") */String userId);

	public UserInfoVo findByUserIdAndIsLockAndIsDel(String userId, boolean isLock, boolean isDel);

	@Modifying
	@Query("Update UserInfoVo u SET u.langCd = :langCd WHERE u.userId = :userId")
	public int updateLangCdByUserId(@Param("langCd") String langCd, @Param("userId") String userId);

}
