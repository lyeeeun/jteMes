package kr.co.itcall.jte.common.code.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.itcall.jte.common.code.model.ComnCodeVo;

public interface ComnCodeRepository extends JpaRepository<ComnCodeVo, String> {

	static final String PAGEABLE_WHERE = " where upper(view.cdId) like upper(concat('%',:value,'%'))"
			+ " or upper(view.cdNm) like upper(concat('%',:value,'%'))";
	
//			viewCd, viewNm 필드 제거.
//			+ " or upper(view.viewCd) like upper(concat('%',:value,'%'))"  // 
//			+ " or upper(view.viewNm) like upper(concat('%',:value,'%'))";

//	public List<ComnCodeVo> findByCdIdContainingIgnoreCase(String cdId); // 두개 모두 동일한 메소드임.
	public List<ComnCodeVo> findByCdIdLikeIgnoringCase(String cdId);

	public List<ComnCodeVo> findByCdIdLikeIgnoringCaseAndCdNmLikeIgnoringCaseAndUseYn(String cdId, String cdNm, String useYn);

//	public List<ComnCodeVo> findByUpCdIdContainingIgnoreCase(String upCdId); // 관계로 들어가있어서 부모키로 조회는 안된다. (밑에도...)

//	// @Query("select c from cw_comn_cd c where lower(c.cd_name) like lower(concat('%', ?1,'%')) and c.grp_name = ?2")
//	@Query("select c from cw_comn_code c where lower(c.cd_nm) like lower(concat('%', :cdNm,'%')) and c.up_cd_nm = :upCdNm")
//	public List<ComnCodeVo> findByCdNmLike(@Param("cdNm") String cdNm, @Param("upCdNm") String upCdNm);

	public List<ComnCodeVo> findByUpCdId(String upCdId);

	@Query("select view from ComnCodeVo view where view.upCdId is null and use_yn = 'Y'")
	public List<ComnCodeVo> findByUpCdIdNull();

	/**
	 * Pageable Query
	 */
	@Query(value="select view from ComnCodeVo view" + PAGEABLE_WHERE
			, countQuery="select view from ComnCodeVo view" + PAGEABLE_WHERE)
	public Page<ComnCodeVo> searchPage(@Param("value") String value, Pageable pageable);

	@Query("select view from ComnCodeVo view where view.cdId = :cdId and use_yn = 'Y'")
	public List<ComnCodeVo> searchActivedComnCd(@Param("cdId") String cdId);
}
