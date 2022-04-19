package kr.co.itcall.jte.spring.user.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import kr.co.itcall.jte.spring.user.model.RoleInfoVo;

public interface RoleRepository extends JpaRepository<RoleInfoVo, String> {

	public RoleInfoVo findByRoleId(String roleId);

	@Query("SELECT role FROM RoleInfoVo role")
	public List<Object> findByAllwithoutJoin();
//
//	@Query(value = "SELECT * FROM mb_role_info", nativeQuery = true)
//	public List<Object> selectAllwithoutJoin();

}
