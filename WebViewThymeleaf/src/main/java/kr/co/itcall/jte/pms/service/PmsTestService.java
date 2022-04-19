package kr.co.itcall.jte.pms.service;

import java.util.List;
import java.util.Map;

import kr.co.itcall.jte.pms.model.PmsPartDtlModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsPartDtlPk;
import kr.co.itcall.jte.rms.model.MasterVO;
import kr.co.itcall.jte.spring.config.exception.SystemException;

public interface PmsTestService {
	//WorkSpare 검색(name)
	public List<Object[]> searchWorksNameListAll(String name) throws SystemException;
	//WorkSpare 검색(Code)
	public List<Object[]> searchWorksCodeListAll(String code) throws SystemException;
	//WorkSpare 선택항목 상세조회(1건)
	public List<PmsTechOrderModel> orderListFindItem(PmsTechOrderModel pmsOrderModel) throws SystemException;
	//Parts 검색(Parts_Name - plate_No, Parts_No - prod_std) 동적 쿼리를 위해 CriteriaBuilder를 사용 
	public List<PmsPartDtlModel> searchPartsListAll(MasterVO masterVO) throws SystemException;
	//Parts 상세조회(1건)
	public List<PmsPartDtlModel> getPartsItemDetail(PmsPartDtlPk dtlModel) throws SystemException;
	//PmsOrder에 Parts 추가
	public String setPartsAppend(PmsTechOrderModel pmsOrderModel) throws SystemException;
	//PmsOrder에서 Parts 제거
	public String setPartsDelete(PmsTechOrderModel pmsOrderModel) throws SystemException;
}