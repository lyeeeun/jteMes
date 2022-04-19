package jin.mes.form.basMgt.belngMgt.divInfo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.itcall.jte.spring.user.model.DeptInfoVo;


public interface DivInfoRepository extends JpaRepository<DeptInfoVo, String>{
	
	/*
	 * @Modifying
	 * 
	 * @Query(value="DELETE FROM DeptInfoVo deptInfoVo " + "WHERE deptInfoVo.deptId = :deptId ") public void deleteByDeptId(@Param("deptInfoList") List<DeptInfoVo> deptInfoList);
	 */
}
