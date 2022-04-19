package kr.co.itcall.jte.pms.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.itcall.jte.pms.model.ExcelUploadVO;
import kr.co.itcall.jte.pms.model.PmsPartDtlModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderHistModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsPartDtlPk;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;
import kr.co.itcall.jte.rms.model.MasterVO;
import kr.co.itcall.jte.rms.model.PageVO;
import kr.co.itcall.jte.spring.config.exception.SystemException;

public interface PmsService {
	//WorkSpare, MainHistoty 검색(name)
	public List<Object[]> searchWorksNameListAll(String name) throws SystemException;
	//WorkSpare, MainHistoty 검색(Code)
	public List<Object[]> searchWorksCodeListAll(String code) throws SystemException;
	//WorkSpare 선택항목 상세조회(1건)
	public List<PmsTechOrderModel> orderListFindItem(PmsTechOrderModel pmsOrderModel) throws SystemException;
	//WorkSpare - Parts 검색(Parts_Name - plate_No, Parts_No - prod_std) 동적 쿼리를 위해 CriteriaBuilder를 사용 
	public List<PmsPartDtlModel> searchPartsListAll(MasterVO masterVO) throws SystemException;
	//WorkSpare - Parts 상세조회(1건)excelUploadForm
	public List<PmsPartDtlModel> getPartsItemDetail(PmsPartDtlPk dtlModel) throws SystemException;
	//WorkSpare - PmsOrder에 Parts 추가
	public String setPartsAppend(PmsTechOrderModel pmsOrderModel) throws SystemException;
	//WorkSpare - PmsOrder에 Parts 추가
	public String setPartsModify(PmsTechOrderModel pmsOrderModel) throws SystemException;
	//WorkSpare - PmsOrder에서 Parts 제거
	public String setPartsDelete(PmsTechOrderModel pmsOrderModel) throws SystemException;
	//WorkSpare - History 조회(상위탭 클릭)
	public List<PmsTechOrderHistModel> getHistoryParent(PmsTechOrderHistModel pmsTechOrderHistModel) throws SystemException;
	//WorkSpare - History 저장
	public String setHistoryAppend(PmsTechOrderHistModel historyModel)throws SystemException;
	
	public Map<String, List<PmsTechOrderHistModel>> getAllHistoryList(PmsTechOrderPk pmsTechOrderPk) throws SystemException;
	//Main_History - History 상세목록 조회 
	public List<PmsTechOrderHistModel> getMainHistoryDetail(@RequestBody PmsTechOrderHistModel pmsTechOrderHistModel) throws SystemException;
	
	public String setHisoryRhMod(Map<String, Object> map) throws SystemException;
	//Maintenance_List - GridView Data 조회 (Paging)
	public Map<String,Object> getGridOrderList(PageVO pageVO)throws SystemException;
	//PartsListForMaintenance - GridView Data 조회 (Paging)
	public Map<String,Object> getGridPartsForMainList(PageVO pageVO)throws SystemException;
	//SpareinStock - GridView Data 조회 (Paging)
	public Map<String,Object> getGridSpareStockList(PageVO pageVO)throws SystemException;
	//엑셀 데이터 insert/update(order)
	public String setExcelOrderSave(List<Map<String, String>> excelContent, ExcelUploadVO excelUploadVO) throws SystemException;
	//엑셀 데이터 insert/update(parts)
	public String setExcelPartsSave(List<Map<String, String>> excelContent, ExcelUploadVO excelUploadVO) throws SystemException;
	
}