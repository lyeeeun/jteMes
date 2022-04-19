package kr.co.itcall.jte.spring.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.spring.user.model.UserInfoVo;

public interface UserRepository extends JpaRepository<UserInfoVo, String> {

	// @Query("select u from UserInfoVo u where u.userId = :userId")
	public UserInfoVo findByUserId(/* @Param("userId") */String userId);

	public UserInfoVo findByUserIdAndIsLockAndIsDel(String userId, boolean isLock, boolean isDel);
	
	public UserInfoVo findByUserIdAndIsDel(String userId, boolean isDel);
	
	@Modifying
	@Query("Update UserInfoVo u SET u.langCd = :langCd WHERE u.userId = :userId")
	public int updateLangCdByUserId(@Param("langCd") String langCd, @Param("userId") String userId);
	
	@Transactional
	@Modifying
	@Query(value="Update mb_user_info u SET u.fail_cnt = u.fail_cnt + 1 WHERE u.user_id = :userId", nativeQuery=true)
	public void updateFailCntByUserId(@Param("userId") String userId);
	
	@Transactional
	@Modifying
	@Query(value="Update mb_user_info u SET u.is_lock = true WHERE u.user_id = :userId", nativeQuery=true)
	public void updateIsLock(@Param("userId") String userId);

}
