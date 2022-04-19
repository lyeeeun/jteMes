package kr.co.itcall.jte.spring.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.co.itcall.jte.spring.user.model.RoleInfoVo;

public interface RoleRepository extends JpaRepository<RoleInfoVo, String> {

	public RoleInfoVo findByRoleId(String roleId);

}
