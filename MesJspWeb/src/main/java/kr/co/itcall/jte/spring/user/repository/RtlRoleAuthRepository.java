package kr.co.itcall.jte.spring.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.spring.user.model.RtlRoleAuth;
import kr.co.itcall.jte.spring.user.model.RtlRoleAuthId;

public interface RtlRoleAuthRepository extends JpaRepository<RtlRoleAuth, RtlRoleAuthId> {
	
	@Query(value = "insert into mb_rtl_role_auth(role_id,auth_id) values(:roleId,:authId)", nativeQuery=true)
	public void addRtlRoleAuth(@Param("roleId") String roleId, @Param("authId") String authId);
	
	@Transactional
	@Modifying
	@Query(value="DELETE FROM mb_rtl_role_auth"
			+ " WHERE role_id = :roleId AND auth_id = :authId", nativeQuery=true)
	public void delRtlRoleAuth(@Param("roleId") String roleId, @Param("authId") String authId);
	
	@Modifying
	@Query(value="DELETE FROM mb_rtl_role_auth"
			+ " WHERE role_id in :roleIds", nativeQuery=true)
	public void delRtlRoleAuthByRoleIds(@Param("roleIds") List<String> roleIds);
}
