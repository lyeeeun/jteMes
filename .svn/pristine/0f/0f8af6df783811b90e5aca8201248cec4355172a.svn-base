package kr.co.itcall.jte.pms.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;

public interface PmsTechOrderRepository extends JpaRepository<PmsTechOrderModel, PmsTechOrderPk> {
	static final String WROKS_SEARCH="SELECT o.pms_cd_01, o.pms_cd_02,o.pms_cd_03,o.pms_cd_04,o.pms_cd_05, o.desc_tech from pms_tech_order o "; 
	
	//WorkSpare 검색(Code) native 쿼리사용 - 기존 쿼리와 비슷하게 사용가능
	@Query(value = WROKS_SEARCH + "WHERE UPPER(o.desc_tech) LIKE UPPER(CONCAT('%',:name,'%'))", nativeQuery=true)
	public List<Object[]> searchWorksNameListAll(@Param("name") String name);
	
	//WorkSpare 검색(Name) native 쿼리사용 - 기존 쿼리와 비슷하게 사용가능
	@Query(value = WROKS_SEARCH + "WHERE UPPER(o.pms_cd_01) LIKE UPPER(CONCAT('%',:code,'%'))"
			+ "OR UPPER(o.pms_cd_02) LIKE UPPER(CONCAT('%',:code,'%'))"
			+ "OR UPPER(o.pms_cd_03) LIKE UPPER(CONCAT('%',:code,'%'))"
			+ "OR UPPER(o.pms_cd_04) LIKE UPPER(CONCAT('%',:code,'%'))"
			+ "OR UPPER(o.pms_cd_05) LIKE UPPER(CONCAT('%',:code,'%'))", nativeQuery=true)
	public List<Object[]> searchOrderCodeListAll(@Param("code") String code);
	
	public List<PmsTechOrderModel> findByPmsTechOrderPk(PmsTechOrderPk pmsTechOrderPk);
	
	@Query(value = "SELECT ord.pms_cd_01,ord.pms_cd_02,ord.pms_cd_03,ord.pms_cd_04,ord.pms_cd_05, "
			+ "ord.desc_tech, ord.need_plate_info_json, part.* FROM pms_tech_order ord "
			+ "LEFT OUTER JOIN pms_tech_order_relate_part_dtl rel "
			+ "ON (ord.pms_cd_01 = rel.pms_cd_01 AND ord.pms_cd_02 = rel.pms_cd_02 AND ord.pms_cd_03 = rel.pms_cd_03 "
			+ "AND ord.pms_cd_04 = rel.pms_cd_04 AND ord.pms_cd_05 = rel.pms_cd_05) "
			+ "LEFT OUTER JOIN pms_part_dtl part "
			+ "ON (part.plate_no = rel.plate_no) ",nativeQuery =true)
	public Page<Map<String,String>> searchNativeOrderList(Pageable pageable);
}
