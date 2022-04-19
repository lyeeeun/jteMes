package kr.co.itcall.jte.pms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.itcall.jte.pms.model.PmsPartDtlModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsPartDtlPk;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;

public interface PmsPartDtlRepository extends JpaRepository<PmsPartDtlModel, PmsPartDtlPk> {
	
	public List<PmsPartDtlModel> findByPmsPartDtlPk(PmsPartDtlPk pmsPartDtlPk);
}
