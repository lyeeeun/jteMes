package kr.co.itcall.jte.pms.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.pms.model.PmsTechOrderHistModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;

public interface PmsTechOrderHistRepository extends JpaRepository<PmsTechOrderHistModel, Long> {
	
	//히스토리 조회  - parentId가 null인것만 조회(Engine)
	@Query(value="SELECT hist FROM PmsTechOrderHistModel hist WHERE hist.pmsTechOrderPk = :pmsTechOrderPk "
			+ "AND hist.parentId IS NULL "
			+ "AND hist.isRecently = true "
			+ "ORDER BY hist.engineId ASC")
	public List<PmsTechOrderHistModel> searchHistoryParent(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk);
	//히스토리 조회  - parentId가 null이 아닌것만 조회(Cyliender)
	@Query(value="SELECT hist FROM PmsTechOrderHistModel hist WHERE hist.pmsTechOrderPk = :pmsTechOrderPk "
			+ "AND hist.parentId = :engineId "
			+ "AND hist.isRecently = true "
			+ "ORDER BY hist.engineId ASC")
	public List<PmsTechOrderHistModel> searchHistoryChild(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk, @Param("engineId") String engineId);
	
	//
//	@Query(value="SELECT hist FROM PmsTechOrderHistModel hist WHERE hist.pmsTechOrderPk = :pmsTechOrderPk "
//			+ "AND (hist.engineId = :engineId OR hist.parentId = :engineId) "
//			+ "AND hist.isRecently = true "
//			+ "ORDER BY hist.parentId DESC, hist.engineId ASC")
//	public List<PmsTechOrderHistModel> searchHistoryParentAll(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk, @Param("engineId") String engineId);
	//
//	@Query(value="SELECT hist FROM PmsTechOrderHistModel hist WHERE hist.pmsTechOrderPk = :pmsTechOrderPk "
//			+ "AND hist.engineId = :engineId "
//			+ "AND hist.parentId = :parentId "
//			+ "AND hist.isRecently = true "
//			+ "ORDER BY hist.parentId DESC, hist.engineId ASC")
//	public List<PmsTechOrderHistModel> searchHistoryLastNode(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk,
//			@Param("parentId") String parentId, @Param("engineId") String engineId);
	//
	@Query(value="SELECT hist FROM PmsTechOrderHistModel hist "
			+ "WHERE hist.seqNo IN (SELECT max(eng.seqNo) FROM PmsTechOrderHistModel eng "
			+ "WHERE eng.pmsTechOrderPk  = :pmsTechOrderPk "
			+ "AND eng.parentId IS NULL "
			+ "GROUP BY (eng.pmsTechOrderPk, eng.engineId)) "
			+ "ORDER BY hist.engineId ASC")
	public List<PmsTechOrderHistModel> getParentListAll(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk);
	//
	@Query(value="SELECT hist FROM PmsTechOrderHistModel hist "
			+ "WHERE hist.seqNo IN (SELECT max(cyl.seqNo) FROM PmsTechOrderHistModel cyl "
			+ "WHERE cyl.pmsTechOrderPk  = :pmsTechOrderPk "
			+ "AND cyl.parentId IS NOT NULL "
			+ "GROUP BY (cyl.pmsTechOrderPk, cyl.engineId)) "
			+ "ORDER BY hist.parentId ASC,hist.engineId ASC")
	public List<PmsTechOrderHistModel> getChildListAll(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk);
	
	//Mainhistory - 히스토리 상세조회(parent를 구분하지 않음) 1개
	@Query(value="SELECT hist FROM PmsTechOrderHistModel hist "
			+ "WHERE hist.pmsTechOrderPk = :pmsTechOrderPk "
			+ "AND hist.engineId in (:engineId) "
			+ "AND hist.isRecently = true")
	public List<PmsTechOrderHistModel> findByPmsTechOrderHistModel(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk, @Param("engineId") String engineId);
	
	//Mainhistory - 히스토리 상세조회(parent를 구분하지 않음) 복수
	@Query(value="SELECT hist FROM PmsTechOrderHistModel hist "
			+ "WHERE hist.pmsTechOrderPk = :pmsTechOrderPk "
			+ "AND hist.engineId in (:engineList) "
			+ "AND hist.isRecently = true")
	public List<PmsTechOrderHistModel> findByPmsTechOrderHistModel(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk, @Param("engineList") String[] engineList);
	
	//isRecently faluse(사용안함) 처리 - (Engine, Cyliender 별  최신 등록된 1개의 history만 isRecently값을 true로 준다.)
	@Modifying
	@Transactional
	@Query(value="UPDATE PmsTechOrderHistModel hist SET hist.isRecently = false "
			+ "WHERE hist.pmsTechOrderPk  = :pmsTechOrderPk "
			+ "AND hist.parentId = :engineId "
			+ "AND hist.isRecently = true")
	public void updateRecentlyAll(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk, @Param("engineId") String engineId);
	
	//Runhour 수정
	@Modifying
	@Transactional
	@Query(value = "UPDATE PmsTechOrderHistModel hist SET hist.atFixedHour = :atFixedHour "
			+ "WHERE hist.pmsTechOrderPk = :pmsTechOrderPk "
			+ "AND hist.engineId = :engineId "
			+ "AND hist.atFixedDate BETWEEN :fromDate AND :toDate "
			+ "AND hist.isRecently = true")
	public void updatehistoryRunhour(@Param("pmsTechOrderPk") PmsTechOrderPk pmsTechOrderPk, @Param("engineId") String engineId, @Param("atFixedHour") int atFixedHour,
			@Param("fromDate") LocalDateTime fromDate, @Param("toDate") LocalDateTime toDate);
}
