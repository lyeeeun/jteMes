package jin.mes.form.basMgt.belngMgt.posInfo;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.co.itcall.jte.spring.user.model.PositionInfoVo;


public interface PosInfoRepository extends JpaRepository<PositionInfoVo, String>{
	
	/*
	 * @Modifying
	 * 
	 * @Query(value="DELETE FROM DeptInfoVo deptInfoVo " + "WHERE deptInfoVo.deptId = :deptId ") public void deleteByDeptId(@Param("deptInfoList") List<DeptInfoVo> deptInfoList);
	 */
}
