package jin.mes.form.basMgt.authMgt.grpAuth;

import java.awt.print.Pageable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.itcall.jte.spring.user.model.RoleInfoVo;

public interface RoleMgtRepository extends JpaRepository<RoleInfoVo, String>{

	
	@Modifying
	@Query(value="UPDATE RoleInfoVo role SET  role.roleId = :roleId, roleNm = :roleNm, description = :description "
			+ "WHERE role.roleId = :roleId ")
	public int updateByRoleId(@Param("roleId") String roleId, @Param("roleNm") String roleNm, @Param("description") String description);
	
	@Modifying
	@Query(value="DELETE FROM RoleInfoVo role "
			+ "WHERE role.roleId in :roleIds ")
	public void deleteByRoleIds(@Param("roleIds") List<String> roleIds);

}
