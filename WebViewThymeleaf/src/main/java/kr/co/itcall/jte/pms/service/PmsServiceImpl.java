package kr.co.itcall.jte.pms.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.CriteriaUpdate;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import kr.co.itcall.jte.pms.model.ExcelUploadVO;
import kr.co.itcall.jte.pms.model.OrderTableSqlMappingDTO;
import kr.co.itcall.jte.pms.model.PmsPartDtlModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderHistModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsPartDtlPk;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;
import kr.co.itcall.jte.pms.repository.PmsPartDtlRepository;
import kr.co.itcall.jte.pms.repository.PmsTechOrderHistRepository;
import kr.co.itcall.jte.pms.repository.PmsTechOrderRepository;
import kr.co.itcall.jte.rms.model.ElasticVO;
import kr.co.itcall.jte.rms.model.MasterVO;
import kr.co.itcall.jte.rms.model.PageVO;
import kr.co.itcall.jte.rms.service.ElasticService;

@Service
public class PmsServiceImpl implements PmsService{
//	@PersistenceUnit
//	EntityManagerFactory emf;
	
	@PersistenceContext
	EntityManager entityManager;
	
	@Autowired
	PmsPartDtlRepository partDetail;
	
	@Autowired
	PmsTechOrderHistRepository orderHistory;
	
	@Autowired
	PmsTechOrderRepository orderList;
	
	@Autowired
	ElasticService elasticService;
	
	private static final String[] STR_CYL_LIST = {"A01","A02","A03","A04","A05","A06","A07","A08","A09","A10","B01","B02","B03","B04","B05","B06","B07","B08","B09","B10"};
	private static final String[] STR_ENG_LIST = {"engine01","engine02","engine03","engine04","engine05","engine06","engine07","engine08","engine09","engine10"};
	private static final String KEY_RUNNINGHOUR = "EA0054";
	
	/*  
	 * WorkSpare 검색(Name - desc_tech)
	 * */
	@Override
	public List<Object[]> searchWorksNameListAll(String name){
		return orderList.searchWorksNameListAll(name);
	}
	
	/*  
	 * WorkSpare 검색(Code = pms_cd_01,pms_cd_02, ...)
	 * */
	@Override
	public List<Object[]> searchWorksCodeListAll(String code){
		return orderList.searchOrderCodeListAll(code);
	}
	
	/* 
	 * WorkSpare 상세조회 (1건)
	 * */
	@Override
	public List<PmsTechOrderModel> orderListFindItem(PmsTechOrderModel pmsOrderModel) {
		List<PmsTechOrderModel> pmsFindOrderOne = new ArrayList<PmsTechOrderModel>();
		try {
			//기본키 세팅
			PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
				pmsOrderModel.getPmsTechOrderPk().getPmsCd01(),pmsOrderModel.getPmsTechOrderPk().getPmsCd02(),
				pmsOrderModel.getPmsTechOrderPk().getPmsCd03(),pmsOrderModel.getPmsTechOrderPk().getPmsCd04(),pmsOrderModel.getPmsTechOrderPk().getPmsCd05()
			);
			
			//RMS RunningHour 가져오기
			Map<String,Map> rhMap = getRmsRunningHour();
			
			//기본키로 검색
			pmsFindOrderOne = orderList.findByPmsTechOrderPk(pmsTechOrderPk);
			
			//RunningHour, overhaul 계산
			for(int i=0; i < pmsFindOrderOne.get(0).getPmsTechOrderHistList().size(); i++) {
				PmsTechOrderHistModel histModel = pmsFindOrderOne.get(0).getPmsTechOrderHistList().get(i);
				int runTime = Integer.parseInt(rhMap.get(histModel.getEngineId()).get(KEY_RUNNINGHOUR).toString()) - histModel.getRunningHour();
				int remainTime = histModel.getAtFixedHour() - runTime;
				pmsFindOrderOne.get(0).getPmsTechOrderHistList().get(i).setRunAlarm(remainTime);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pmsFindOrderOne;
	}

	/* 
	 * WorkSpare - Parts 검색(Parts_Name - plate_No, Parts_No - prod_std) 동적 쿼리를 위해 CriteriaBuilder를 사용 
	 * */
	@Override
	public List<PmsPartDtlModel> searchPartsListAll(MasterVO masterVO) {

		// CriteriaBuilder 인스턴스를 작성한다.
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();

		// CriteriaQuery 인스턴스를 생성한다. Board 제네릭 형식으로...
		CriteriaQuery<PmsPartDtlModel> criteriaQuery = criteriaBuilder.createQuery(PmsPartDtlModel.class);

		// Root는 영속적 엔티티를 표시하는 쿼리 표현식이다. SQL의 FROM 과 유사함
		Root<PmsPartDtlModel> root = criteriaQuery.from(PmsPartDtlModel.class);

		List<Predicate> predicates = new ArrayList<Predicate>();
		
		// SQL의 WHERE절이다. 조건부는 CriteriaBuilder에 의해 생성
		predicates.add(criteriaBuilder.equal(root.get("pmsPartDtlPk").get("nationId"), "Columbia"));
		predicates.add(criteriaBuilder.equal(root.get("pmsPartDtlPk").get("companyId"), "Axia"));
		predicates.add(criteriaBuilder.equal(root.get("pmsPartDtlPk").get("areaId"), "Termonorte"));
		predicates.add(criteriaBuilder.equal(root.get("pmsPartDtlPk").get("engineModel"), "20H35DFV"));
		
		//동적으로 가능하다.
		if(masterVO.getSearchGubun() != null) { 
			if(masterVO.getSearchGubun().equals("plateNo")) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.upper(root.get("pmsPartDtlPk").get(masterVO.getSearchGubun())), "%"+masterVO.getSearchText().toUpperCase()+"%")); 
				}else if(masterVO.getSearchGubun().equals("prodStd")) {
					predicates.add(criteriaBuilder.like(criteriaBuilder.upper(root.get(masterVO.getSearchGubun())), "%"+masterVO.getSearchText().toUpperCase()+"%")); 
			} 
		}
		
		criteriaQuery.where(criteriaBuilder.and(predicates.toArray(new Predicate[0])));

		// ORDER BY절. CriteriaQuery로 생성
		//criteriaQuery.orderBy(criteriaBuilder.desc(root.get("boardIdx")));

		//TypedQuery는 실행 결과를 리턴하는 타입이다.
		TypedQuery<PmsPartDtlModel> boardListQuery = entityManager.createQuery(criteriaQuery);

		List<PmsPartDtlModel> boardList = boardListQuery.getResultList();

		return boardList;
	}
	
	/* 
	 * WorkSpare -Parts 상세조회(1건)
	 * */
	@Override
	public List<PmsPartDtlModel> getPartsItemDetail(PmsPartDtlPk dtlModel) {
		List<PmsPartDtlModel> searchResult = new ArrayList<PmsPartDtlModel>();
		try {
			searchResult = partDetail.findByPmsPartDtlPk(dtlModel);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return searchResult;
	}

	/*
	 *  WorkSpare - PmsOrder에 Parts 추가 
	 *  */
	@Override
	@Transactional
	public String setPartsAppend(PmsTechOrderModel pmsOrderModel) {
		String strResult = "ERROR";
				
		try {
			//RMS RunningHour 가져오기
			Map<String,Map> rhMap = getRmsRunningHour();
			
			//기본키 세팅
			PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
					pmsOrderModel.getPmsTechOrderPk().getPmsCd01(),pmsOrderModel.getPmsTechOrderPk().getPmsCd02(),
					pmsOrderModel.getPmsTechOrderPk().getPmsCd03(),pmsOrderModel.getPmsTechOrderPk().getPmsCd04(),pmsOrderModel.getPmsTechOrderPk().getPmsCd05());
			
			//기존 Order 목록 조회
			PmsTechOrderModel baseOrderModel = orderList.findByPmsTechOrderPk(pmsTechOrderPk).get(0);
			
			//추가할 Parts 조회
			List<PmsPartDtlModel> searchResult = partDetail.findByPmsPartDtlPk(pmsOrderModel.getPartDtlList().get(0).getPmsPartDtlPk());
			
			//추가할 Parts가 order에 존재하는지 체크
			for(int i = 0; i< baseOrderModel.getPartDtlList().size(); i++) {
				if(baseOrderModel.getPartDtlList().get(i).equals(searchResult.get(0))) {
					strResult = "EXIST";
					break;
				}
			}
			
			//추가할 Parts가 order에 없으면 추가 수행(각 실행문 위치가 중요함)
			if(!strResult.equals("EXIST")) {
				//History 생성(Cyilender)
				if(pmsOrderModel.getPmsUnit().equals("Cyl") == true && getOrderUnitExist(baseOrderModel.getNeedPlateInfoJson(),"Cyl") == false) {
					
					List<PmsTechOrderHistModel> cylHistoryList = new ArrayList<PmsTechOrderHistModel>();
					for(PmsTechOrderHistModel engHistoryModel : baseOrderModel.getPmsTechOrderHistList()) {
						//혹시라도 history가 존재하면 모두 미사용처리
						PmsTechOrderHistModel recentModel = new PmsTechOrderHistModel();
						orderHistory.updateRecentlyAll(baseOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId());
						
						for(String strCyl: STR_CYL_LIST) {
							//Engine RunningHour
							int engRH = Integer.parseInt(rhMap.get(engHistoryModel.getEngineId()).get(KEY_RUNNINGHOUR).toString());
							
							cylHistoryList.add(new PmsTechOrderHistModel(baseOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId(),
									strCyl,"Initial creation",LocalDateTime.now(),baseOrderModel.getGapRunHour(), engRH, true));
						}
						
					}
					orderHistory.saveAll(cylHistoryList);
				}
				
				//dtl Append
				baseOrderModel.getPartDtlList().add(searchResult.get(0));
				
				//field(pmsQty, pmsUnit) Append
				Gson gson = new Gson();
				Map<String, Map> addInfoMap = new HashMap<String, Map>();
				addInfoMap = getOrderAddInfo(baseOrderModel.getNeedPlateInfoJson());
				addInfoMap.put(pmsOrderModel.getPartDtlList().get(0).getPmsPartDtlPk().getPlateNo(), convertAddInfotoMap(pmsOrderModel.getPmsQty(),pmsOrderModel.getPmsUnit()));
				baseOrderModel.setNeedPlateInfoJson(gson.toJson(addInfoMap));
				
				//saveQuery
				orderList.save(baseOrderModel);
				strResult = "SUCCESS";
			}
		}catch(Exception e) {
			strResult = "ERROR";
		}
		return strResult;
	}
	
	/*
	 *  WorkSpare -PmsOrder에 Parts 수정 
	 *  수정은 pmsQty와 Unit만 수정된다.
	 *  */
	@Override
	@Transactional
	public String setPartsModify(PmsTechOrderModel pmsOrderModel) {
		String strResult = "ERROR";
		try {
			
			//RMS RunningHour 가져오기
			Map<String,Map> rhMap = getRmsRunningHour();
			
			//기본키 세팅
			PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
					pmsOrderModel.getPmsTechOrderPk().getPmsCd01(),pmsOrderModel.getPmsTechOrderPk().getPmsCd02(),
					pmsOrderModel.getPmsTechOrderPk().getPmsCd03(),pmsOrderModel.getPmsTechOrderPk().getPmsCd04(),pmsOrderModel.getPmsTechOrderPk().getPmsCd05());
			
			//기존 Order 목록 조회
			PmsTechOrderModel baseOrderModel = orderList.findByPmsTechOrderPk(pmsTechOrderPk).get(0);
			
			//history 삭제를 위해 
			String beforeInfoJson = baseOrderModel.getNeedPlateInfoJson();
			
			//History 생성(Cyilender)
			if(pmsOrderModel.getPmsUnit().equals("Cyl") == true && getOrderUnitExist(baseOrderModel.getNeedPlateInfoJson(),"Cyl") == false) {
				List<PmsTechOrderHistModel> cylHistoryList = new ArrayList<PmsTechOrderHistModel>();
				for(PmsTechOrderHistModel engHistoryModel : baseOrderModel.getPmsTechOrderHistList()) {
					//혹시라도 history가 존재하면 모두 미사용처리
					orderHistory.updateRecentlyAll(baseOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId());
					
					for(String strCyl: STR_CYL_LIST) {
						//Engine RunningHour
						int engRH = Integer.parseInt(rhMap.get(engHistoryModel.getEngineId()).get(KEY_RUNNINGHOUR).toString());
						
						cylHistoryList.add(new PmsTechOrderHistModel(baseOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId(),
								strCyl,"Initial creation",LocalDateTime.now(),baseOrderModel.getGapRunHour(), engRH, true));
					}
				}
				orderHistory.saveAll(cylHistoryList);
			}
			
			Gson gson = new Gson();
			Map<String, Map> addInfoMap = getOrderAddInfo(baseOrderModel.getNeedPlateInfoJson()); 
			addInfoMap.put(pmsOrderModel.getPartDtlList().get(0).getPmsPartDtlPk().getPlateNo(), convertAddInfotoMap(pmsOrderModel.getPmsQty(),pmsOrderModel.getPmsUnit()));
			
			baseOrderModel.setNeedPlateInfoJson(gson.toJson(addInfoMap));
			
			PmsTechOrderModel resultOrder = orderList.save(baseOrderModel);
			
			//Cyilender가 사라진 경우 History False 처리
			if(getOrderUnitExist(beforeInfoJson,"Cyl") == true  && getOrderUnitExist(resultOrder.getNeedPlateInfoJson(),"Cyl") == false) {
				for(PmsTechOrderHistModel engHistoryModel : resultOrder.getPmsTechOrderHistList()) {
					orderHistory.updateRecentlyAll(baseOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId());
				}
			}
			strResult = "SUCCESS";
		}catch(Exception e) {
			strResult = "ERROR";
		}
		return strResult;
	}
	
	/*
	 *  WorkSpare -PmsOrder에 Parts 삭제 
	 *  */
	@Override
	@Transactional
	public String setPartsDelete(PmsTechOrderModel pmsOrderModel) {
		String strResult = "ERROR";
		try {
			//기본키 세팅
			PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
					pmsOrderModel.getPmsTechOrderPk().getPmsCd01(),pmsOrderModel.getPmsTechOrderPk().getPmsCd02(),
					pmsOrderModel.getPmsTechOrderPk().getPmsCd03(),pmsOrderModel.getPmsTechOrderPk().getPmsCd04(),pmsOrderModel.getPmsTechOrderPk().getPmsCd05());
			
			//기존 Order 목록 조회
			PmsTechOrderModel baseOrderModel = orderList.findByPmsTechOrderPk(pmsTechOrderPk).get(0);
			
			//history 삭제를 위해 
			String beforeInfoJson = baseOrderModel.getNeedPlateInfoJson();
			
			//삭제할 Parts 조회
			List<PmsPartDtlModel> searchResult = partDetail.findByPmsPartDtlPk(pmsOrderModel.getPartDtlList().get(0).getPmsPartDtlPk());
			
			//삭제할 Parts 를 제외한 그 외 Parts를 저장하기 위한 변수
			List<PmsPartDtlModel> BaseDtlList = new ArrayList<PmsPartDtlModel>(); 

			//삭제할 Parts 를 제외한 그 외 Parts를 변수에 저장한다
			for(int i = 0; i< baseOrderModel.getPartDtlList().size(); i++) {
				if(!baseOrderModel.getPartDtlList().get(i).equals(searchResult.get(0))) {
					BaseDtlList.add(baseOrderModel.getPartDtlList().get(i));
				}
			}
			
			//pmsQty,pmsUnit (삭제 기존정보 불러옴 > 기존 정보에서 삭제 될 PlateNo를 찾아 해당 필드  제거 > Json으로 Convert하여 Model에 저장) 
			Map<String, Map> addInfoMap = getOrderAddInfo(baseOrderModel.getNeedPlateInfoJson()); 
			addInfoMap.remove(searchResult.get(0).getPmsPartDtlPk().getPlateNo());
			Gson gson = new Gson();
			baseOrderModel.setNeedPlateInfoJson(gson.toJson(addInfoMap));
			
			//삭제할 Parts를 제외한 Parts 정보를 담은 변수를 세팅한다.
			baseOrderModel.setPartDtlList(BaseDtlList);
			
			//저장한다(삭제).
			PmsTechOrderModel resultOrder = orderList.save(baseOrderModel);
			
			//Cyilender가 사라진 경우 History False 처리(baseOrderModel 기존에 Cyliender가 있고 삭제 진행 후  resultOrder에 Cyl가 없는 경우 history false)
			if(getOrderUnitExist(beforeInfoJson,"Cyl") == true && getOrderUnitExist(resultOrder.getNeedPlateInfoJson(),"Cyl") == false) {
				for(PmsTechOrderHistModel engHistoryModel : resultOrder.getPmsTechOrderHistList()) {
					orderHistory.updateRecentlyAll(baseOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId());
				}
			}
			strResult = "SUCCESS";
		}catch(Exception e) {
			strResult = "ERROR";
		}
		return strResult;
	}
	/* 
	 * Workspare - history tab(선택 탭의 상세정보와 자식 탭의 정보를 불러온다.)
	 */
	@Override
	public List<PmsTechOrderHistModel> getHistoryParent(PmsTechOrderHistModel pmsTechOrderHistModel){
		List<PmsTechOrderHistModel>  pmsFindHistoryList = new ArrayList<PmsTechOrderHistModel>();
		try {
			//기본키 세팅
			PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
					pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd01(),pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd02(),
					pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd03(),pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd04(),pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd05()
			);
			
			//RMS RunningHour 가져오기
			Map<String,Map> rhMap = getRmsRunningHour();
			
			if(pmsTechOrderHistModel.getParentId() == null) {
				//기본키로 검색
				pmsFindHistoryList= orderHistory.searchHistoryParent(pmsTechOrderPk);
			}else {
				//기본키로 검색
				pmsFindHistoryList= orderHistory.searchHistoryChild(pmsTechOrderPk,pmsTechOrderHistModel.getParentId());
			}
			//RunningHour, overhaul 계산
			for(int i=0; i < pmsFindHistoryList.size(); i++) {
				PmsTechOrderHistModel histModel = pmsFindHistoryList.get(i);
				String engineModel = "";
				if(histModel.getParentId() != null) {
					engineModel = histModel.getParentId();
				}else {
					engineModel = histModel.getEngineId();
				}
				int runTime = Integer.parseInt(rhMap.get(engineModel).get(KEY_RUNNINGHOUR).toString()) - histModel.getRunningHour();
				int remainTime = histModel.getAtFixedHour() - runTime;
				pmsFindHistoryList.get(i).setRunTime(runTime);
				pmsFindHistoryList.get(i).setRunAlarm(remainTime);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pmsFindHistoryList;
	}	
	//history저장
	@Override
	@Transactional
	public String setHistoryAppend(PmsTechOrderHistModel historyModel){
		String strResult = "ERROR";
		try {
			PmsTechOrderHistModel pmsFindHistoryList = new PmsTechOrderHistModel();
			//기본키 세팅
			PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
					historyModel.getPmsTechOrderPk().getPmsCd01(),historyModel.getPmsTechOrderPk().getPmsCd02(),
					historyModel.getPmsTechOrderPk().getPmsCd03(),historyModel.getPmsTechOrderPk().getPmsCd04(),historyModel.getPmsTechOrderPk().getPmsCd05()
			);
			
			//Order 목록 조회
			PmsTechOrderModel baseOrderModel = orderList.findByPmsTechOrderPk(pmsTechOrderPk).get(0);
			
			//이전 hitsory  Recently false 처리
			// CriteriaBuilder 인스턴스를 작성한다.
			CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();

			// CriteriaUpdate 인스턴스를 생성한다. Board 제네릭 형식으로...
			CriteriaUpdate<PmsTechOrderHistModel> criteriaUpdate = criteriaBuilder.createCriteriaUpdate(PmsTechOrderHistModel.class);
			
			// Root는 영속적 엔티티를 표시하는 쿼리 표현식이다. SQL의 FROM 과 유사함
			Root root = criteriaUpdate.from(PmsTechOrderHistModel.class);

			//Set
			criteriaUpdate.set("isRecently", false);

			// SQL의 WHERE절이다. 조건부는 CriteriaBuilder에 의해 생성
			List<Predicate> predicates = new ArrayList<Predicate>();
			predicates.add(criteriaBuilder.equal(root.get("pmsTechOrderPk"), pmsTechOrderPk));
			predicates.add(criteriaBuilder.equal(root.get("isRecently"), true));
			
			//완성되면 주석다세요
			if(historyModel.getMultiSave() == null) {
				predicates.add(criteriaBuilder.equal(root.get("engineId"), historyModel.getEngineId()));
				if(historyModel.getParentId() != null) { 
					predicates.add(criteriaBuilder.equal(root.get("parentId"),historyModel.getParentId()));
				}
			}else{
				switch(historyModel.getMultiSave()) {
				case "All" :
					break;
				case "Eng" :
					predicates.add(root.get("engineId").in(historyModel.getParentList()));
					break;
				case "Cyl" :
					predicates.add(root.get("engineId").in(historyModel.getEngineList()));
					break;
				default:
					throw new Exception("더 많이 많이");
				}
			}
			
			criteriaUpdate.where(criteriaBuilder.and(predicates.toArray(new Predicate[0])));

			// ORDER BY절. CriteriaQuery로 생성
			//criteriaQuery.orderBy(criteriaBuilder.desc(root.get("boardIdx")));

			//TypedQuery는 실행 결과를 리턴하는 타입이다.
			entityManager.createQuery(criteriaUpdate).executeUpdate();

			
			//추가정보 매핑
			historyModel.setPmsTechOrderPk(pmsTechOrderPk);
			historyModel.setRecently(true);
			
			if(historyModel.getAtFixedHour() == 0) {
				historyModel.setAtFixedHour(baseOrderModel.getGapRunHour());
			}
			
			//RMS RunningHour 가져오기
			Map<String,Map> rhMap = getRmsRunningHour();
			
			String engineModel = "";
			//완성하면 주석다세요.
			if(historyModel.getEngineId() != null) {//단일 신청
				if(historyModel.getParentId() != null) {
					engineModel = historyModel.getParentId();
				}else {
					engineModel = historyModel.getEngineId();
				}
				historyModel.setRunningHour(Integer.parseInt(rhMap.get(engineModel).get(KEY_RUNNINGHOUR).toString()));
				//history 저장
				orderHistory.save(historyModel);
			}else {
				List<PmsTechOrderHistModel> historyList = new ArrayList<PmsTechOrderHistModel>();
				switch(historyModel.getMultiSave()) {
				case "All" :
					for(String parentId : historyModel.getParentList()) {
						PmsTechOrderHistModel tempHistoryParent = new PmsTechOrderHistModel(historyModel.getPmsTechOrderPk(),parentId, historyModel.getLastWorkNoti(),
								historyModel.getAtFixedDate(), historyModel.getAtFixedHour(), Integer.parseInt(rhMap.get(parentId).get(KEY_RUNNINGHOUR).toString()), true);
						historyList.add(tempHistoryParent);
						for(String childId : historyModel.getEngineList()) {
							PmsTechOrderHistModel tempHistoryChild = new PmsTechOrderHistModel(historyModel.getPmsTechOrderPk(), parentId, childId, historyModel.getLastWorkNoti(),
									historyModel.getAtFixedDate(), historyModel.getAtFixedHour(), Integer.parseInt(rhMap.get(parentId).get(KEY_RUNNINGHOUR).toString()), true);
							historyList.add(tempHistoryChild);
						}
					}
					break;
				case "Eng" :
					for(String parentId : historyModel.getParentList()) {
						PmsTechOrderHistModel tempHistory = new PmsTechOrderHistModel(historyModel.getPmsTechOrderPk(),parentId, historyModel.getLastWorkNoti(),
								historyModel.getAtFixedDate(), historyModel.getAtFixedHour(), Integer.parseInt(rhMap.get(parentId).get(KEY_RUNNINGHOUR).toString()), true);
						historyList.add(tempHistory);
					}
					break;
				case "Cyl" :
					for(String parentId : historyModel.getParentList()) {
						for(String childId : historyModel.getEngineList()) {
							PmsTechOrderHistModel tempHistory = new PmsTechOrderHistModel(historyModel.getPmsTechOrderPk(), parentId, childId, historyModel.getLastWorkNoti(),
									historyModel.getAtFixedDate(), historyModel.getAtFixedHour(), Integer.parseInt(rhMap.get(parentId).get(KEY_RUNNINGHOUR).toString()), true);
							historyList.add(tempHistory);
						}
					}
					break;
				default:
					throw new Exception("더 많이 많이");
				}
				//history 저장
				orderHistory.saveAll(historyList);
			}
			
			strResult = "SUCCESS";
		}catch(Exception e) {
			strResult = "ERROR";
		}
		return strResult;
	}
	
	/* 
	 * Main_History - HistoryCode Search(eng01, eng02.. , A01,A02...) 
	 * */
	@Override
	public Map<String, List<PmsTechOrderHistModel>> getAllHistoryList(PmsTechOrderPk pmsTechOrderPk){
		//기본키 세팅
		pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
				pmsTechOrderPk.getPmsCd01(),pmsTechOrderPk.getPmsCd02(),
				pmsTechOrderPk.getPmsCd03(),pmsTechOrderPk.getPmsCd04(),pmsTechOrderPk.getPmsCd05());
		
		Map<String, List<PmsTechOrderHistModel>> map = new HashMap<String, List<PmsTechOrderHistModel>>();
		
		//RunningHour 검색
		Map<String,Map> rhMap = getRmsRunningHour();
		
		//Engine History 검색
		List<PmsTechOrderHistModel> histModelList = orderHistory.getParentListAll(pmsTechOrderPk);
		
		//RunningHour, overhaul 계산
		for(int i=0; i < histModelList.size(); i++) {
			PmsTechOrderHistModel histModel = histModelList.get(i);
			
			int runTime = Integer.parseInt(rhMap.get(histModel.getEngineId()).get(KEY_RUNNINGHOUR).toString()) - histModel.getRunningHour();
			int remainTime = histModel.getAtFixedHour() - runTime;
			histModelList.get(i).setRunAlarm(remainTime);
		}
		map.put("parent", histModelList);
		
		
		List<PmsTechOrderHistModel> childHistModelList = new ArrayList<>();
		
		//Cyliender History 검색
		histModelList = orderHistory.getChildListAll(pmsTechOrderPk);
		
		for(int i = 0 ; i < histModelList.size(); i++) {
			List<PmsTechOrderHistModel> childHistAll = orderHistory.findByPmsTechOrderHistModel(pmsTechOrderPk,histModelList.get(i).getEngineId());
			for(int j = 0 ; j < childHistAll.size(); j++) {
				
				//RunningHour, overhaul 계산
				PmsTechOrderHistModel histModel = childHistAll.get(j);
				int runTime =  Integer.parseInt(rhMap.get(histModel.getParentId()).get(KEY_RUNNINGHOUR).toString()) - histModel.getRunningHour();
				int remainTime = histModel.getAtFixedHour() - runTime;
				
				histModel.setRunAlarm(remainTime);
				
				if(childHistModelList.size() != i) {
					if(childHistModelList.get(i).getRunAlarm() > remainTime) {
						childHistModelList.add(i, histModel);
					}
				}else {
					childHistModelList.add(i, histModel);
				}
			}
			
		}
		//RunningHour, overhaul 계산
//		for(int i=0; i < histModelList.size(); i++) {
//			PmsTechOrderHistModel histModel = histModelList.get(i);
//			int runTime = histModel.getRunningHour() - Integer.parseInt(rhMap.get(histModel.getParentId()).get("EA0054").toString());
//			int remainTime = histModel.getAtFixedHour() - runTime;
//			histModelList.get(i).setRunAlarm(remainTime);
//			
//		}
		
		map.put("child", histModelList);
		
		return map;
	}
	
	/* 
	 * Main_History - History 상세목록 조회 
	 * */
	@Override
	public List<PmsTechOrderHistModel> getMainHistoryDetail(PmsTechOrderHistModel pmsTechOrderHistModel){
		// TODO Auto-generated method stub
		
		PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
				pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd01(),pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd02(),
				pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd03(),pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd04(),pmsTechOrderHistModel.getPmsTechOrderPk().getPmsCd05()
		);
		
		//RunningHour 검색
		Map<String,Map> rhMap = getRmsRunningHour();
		
		List<PmsTechOrderHistModel> histModelList;
		if(pmsTechOrderHistModel.getEngineId() != null) {
			histModelList = orderHistory.findByPmsTechOrderHistModel(pmsTechOrderPk,pmsTechOrderHistModel.getEngineId());
		}else {
			histModelList = orderHistory.findByPmsTechOrderHistModel(pmsTechOrderPk,pmsTechOrderHistModel.getEngineList());
		}
		
		//RunningHour, overhaul 계산
		for(int i=0; i < histModelList.size(); i++) {
			PmsTechOrderHistModel histModel = histModelList.get(i);
			String engineModel = "";
			if(histModel.getParentId() == null) {
				engineModel = histModel.getEngineId(); 
			}else {
				engineModel = histModel.getParentId();
			}
			int runTime = Integer.parseInt(rhMap.get(engineModel).get(KEY_RUNNINGHOUR).toString()) - histModel.getRunningHour();
			int remainTime = histModel.getAtFixedHour() - runTime;
			histModelList.get(i).setRunTime(runTime);
			histModelList.get(i).setRunAlarm(remainTime);
		}
		return histModelList;
	}

	/* 
	 * Main_History - History 수정 
	 * */
	@Override
	@Transactional
	public String setHisoryRhMod(Map<String, Object> map) {
		String strResult = "ERROR";
		try {
			
			PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
					map.get("pmsCd01").toString(),map.get("pmsCd02").toString(),
					map.get("pmsCd03").toString(),map.get("pmsCd04").toString(),map.get("pmsCd05").toString()
			);
			LocalDateTime fromDate= LocalDateTime.of(Integer.parseInt(map.get("fromDate").toString().split("-")[0]),
					Integer.parseInt(map.get("fromDate").toString().split("-")[1]),
					Integer.parseInt(map.get("fromDate").toString().split("-")[2])
					,0,0,0);
			
			LocalDateTime toDate= LocalDateTime.of(Integer.parseInt(map.get("toDate").toString().split("-")[0]),
					Integer.parseInt(map.get("toDate").toString().split("-")[1]),
					Integer.parseInt(map.get("toDate").toString().split("-")[2])
					,23,59,59);
			orderHistory.updatehistoryRunhour(pmsTechOrderPk, map.get("engineId").toString(), Integer.parseInt(map.get("atFixedHour").toString()),fromDate, toDate);
			
			strResult = "SUCCESS";
		}catch(Exception e) {
			strResult = "ERROR";
		}
		return strResult;
	}
	
	//Maintenance_List - GridView Data 조회 (Paging)
	public Map<String,Object> getGridOrderList(PageVO pageVO){
		Map<String,Object> mapResult = new HashMap<String, Object>();
		
		String listSelect = "SELECT ord.pms_cd_01 pmsCd01,ord.pms_cd_02 pmsCd02,ord.pms_cd_03 pmsCd03,ord.pms_cd_04 pmsCd04,ord.pms_cd_05 pmsCd05, "
				+ "ord.desc_tech descTech, ord.desc_order descOrder, ord.gap_run_hour gapRunHour, ord.need_plate_info_json needPlateInfoJson ";
		String countSelect = "SELECT count(*) ";
				
		String whereSql = "";
		if(pageVO.getSearchGubun() != null) {
			whereSql = "WHERE UPPER("+pageVO.getSearchGubun()+") LIKE UPPER(:searchText) ";
		}
		
		String orderSql = "order by ord.updated_at desc ";
		if(pageVO.getSort()!= null) {
			orderSql = "order by "+pageVO.getSort() +" "+pageVO.getOrder();
		}
		
		String listSql = listSelect + "FROM pms_tech_order ord " + whereSql + orderSql;
		
		Query listQuery= entityManager.createNativeQuery(listSql,"MaintenanceList");
		
		String countSql = countSelect + "FROM pms_tech_order ord " + whereSql;
		
		Query countQuery= entityManager.createNativeQuery(countSql);
		
		if(pageVO.getSearchGubun() != null) {
			listQuery.setParameter("searchText", "%"+pageVO.getSearchText()+"%");
			countQuery.setParameter("searchText", "%"+pageVO.getSearchText()+"%");
		}
		
		List<OrderTableSqlMappingDTO> partsList = listQuery.setFirstResult((pageVO.getPage()-1)*pageVO.getRows()).setMaxResults(pageVO.getRows()).getResultList();
		
		List<Object[]> TotalCount= countQuery.getResultList();
		
		mapResult.put("total", TotalCount.get(0));
		mapResult.put("rows", partsList);
		return mapResult;
	}
	
	//PartsListForMaintenance - GridView Data 조회 (Paging)
	public Map<String,Object> getGridPartsForMainList(PageVO pageVO){
		//방법 1
//		entityManager = emf.createEntityManager();
//		entityManager.getTransaction().begin();
//			
//		List<Object[]> results = entityManager.createNativeQuery("SELECT ord.desc_tech, rel.*, part.prod_std "
//				+ "FROM pms_tech_order ord "
//				+ "LEFT JOIN pms_tech_order_relate_part_dtl rel "
//				+ "ON (ord.pms_cd_01 = rel.pms_cd_01 AND ord.pms_cd_02 = rel.pms_cd_02 AND ord.pms_cd_03 = rel.pms_cd_03 "
//				+ "AND ord.pms_cd_04 = rel.pms_cd_04 AND ord.pms_cd_05 = rel.pms_cd_05) "
//				+ "LEFT JOIN pms_part_dtl part "
//				+ "ON (part.plate_no = rel.plate_no) limit 10").getResultList();
//
//		entityManager.getTransaction().commit();
//		entityManager.close();
		
		
		//방법 2
		
		Map<String,Object> mapResult = new HashMap<String, Object>();
		
		String listSelect = "SELECT ord.pms_cd_01 pmsCd01,ord.pms_cd_02 pmsCd02,ord.pms_cd_03 pmsCd03,ord.pms_cd_04 pmsCd04,ord.pms_cd_05 pmsCd05, "
				+ "ord.desc_tech descTech, ord.need_plate_info_json needPlateInfoJson, "
				+ "part.plate_no plateNo,part.prod_std prodStd ";
		String countSelect = "SELECT count(*) ";
				
		String whereSql = "";
		if(pageVO.getSearchGubun() != null) {
			whereSql = "WHERE UPPER("+pageVO.getSearchGubun()+") LIKE UPPER(:searchText) ";
		}
		
		String orderSql = "order by ord.updated_at desc ";
		if(pageVO.getSort()!= null) {
			orderSql = "order by "+pageVO.getSort() +" "+pageVO.getOrder();
		}
		
		String listSql = listSelect + "FROM pms_tech_order ord "
				+ "LEFT OUTER JOIN pms_tech_order_relate_part_dtl rel "
				+ "ON (ord.pms_cd_01 = rel.pms_cd_01 AND ord.pms_cd_02 = rel.pms_cd_02 AND ord.pms_cd_03 = rel.pms_cd_03 "
				+ "AND ord.pms_cd_04 = rel.pms_cd_04 AND ord.pms_cd_05 = rel.pms_cd_05) "
				+ "LEFT OUTER JOIN pms_part_dtl part "
				+ "ON (part.plate_no = rel.plate_no) "+whereSql+orderSql;
		
		Query listQuery= entityManager.createNativeQuery(listSql,"partListForMaintenance");
		
		String countSql = countSelect + "FROM pms_tech_order ord "
				+ "LEFT OUTER JOIN pms_tech_order_relate_part_dtl rel "
				+ "ON (ord.pms_cd_01 = rel.pms_cd_01 AND ord.pms_cd_02 = rel.pms_cd_02 AND ord.pms_cd_03 = rel.pms_cd_03 "
				+ "AND ord.pms_cd_04 = rel.pms_cd_04 AND ord.pms_cd_05 = rel.pms_cd_05) "
				+ "LEFT OUTER JOIN pms_part_dtl part "
				+ "ON (part.plate_no = rel.plate_no) "+whereSql;
		
		Query countQuery= entityManager.createNativeQuery(countSql);
		
		if(pageVO.getSearchGubun() != null) {
			listQuery.setParameter("searchText", "%"+pageVO.getSearchText()+"%");
			countQuery.setParameter("searchText", "%"+pageVO.getSearchText()+"%");
		}
		
		List<OrderTableSqlMappingDTO> partsList = listQuery.setFirstResult((pageVO.getPage()-1)*pageVO.getRows()).setMaxResults(pageVO.getRows()).getResultList();
		
		List<Object[]> TotalCount= countQuery.getResultList();
		
		mapResult.put("total", TotalCount.get(0));
		mapResult.put("rows", partsList);
		return mapResult;
		
		//방법 3
//		Sort sort = new Sort(Direction.DESC, "updated_at");
//		if(pageVO.getSort()!= null) {
//			if("asc".equals(pageVO.getOrder().toLowerCase())) {
//				sort = new Sort(Direction.ASC, pageVO.getSort());
//			}else if("desc".equals(pageVO.getOrder().toLowerCase())){
//				sort = new Sort(Direction.DESC, pageVO.getSort());
//			}
//		}
//
//		Pageable pageable = PageRequest.of(pageVO.getPage()-1, pageVO.getRows(), sort);
//		return orderList.searchNativeOrderList(pageable);
	}
	
	//SpareinStock - GridView Data 조회 (Paging)
	public Map<String,Object> getGridSpareStockList(PageVO pageVO){
		Map<String,Object> mapResult = new HashMap<String, Object>();
		// CriteriaBuilder 인스턴스를 작성한다.
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();

		// CriteriaQuery 인스턴스를 생성한다. Board 제네릭 형식으로...
		CriteriaQuery<PmsPartDtlModel> criteriaQuery = criteriaBuilder.createQuery(PmsPartDtlModel.class);
		
		//Count Query
		CriteriaQuery<Long> countQuery = criteriaBuilder.createQuery(Long.class);
		countQuery.select(criteriaBuilder.count(countQuery.from(PmsPartDtlModel.class)));
		
		// Root는 영속적 엔티티를 표시하는 쿼리 표현식이다. SQL의 FROM 과 유사함
		Root<PmsPartDtlModel> root = criteriaQuery.from(PmsPartDtlModel.class);
		List<Predicate> predicates = new ArrayList<Predicate>();
		
		// SQL의 WHERE절이다. 조건부는 CriteriaBuilder에 의해 생성
		predicates.add(criteriaBuilder.equal(root.get("pmsPartDtlPk").get("nationId"), "Columbia"));
		predicates.add(criteriaBuilder.equal(root.get("pmsPartDtlPk").get("companyId"), "Axia"));
		predicates.add(criteriaBuilder.equal(root.get("pmsPartDtlPk").get("areaId"), "Termonorte"));
		predicates.add(criteriaBuilder.equal(root.get("pmsPartDtlPk").get("engineModel"), "20H35DFV"));
		
		//동적으로 가능하다.
		if(pageVO.getSearchGubun() != null) { 
			if(pageVO.getSearchGubun().contains(".")) {
				String[] gubun = pageVO.getSearchGubun().split("\\.");
				predicates.add(criteriaBuilder.like(criteriaBuilder.upper(root.get(gubun[0]).get(gubun[1])), "%"+pageVO.getSearchText().toUpperCase()+"%"));
			}else if(pageVO.getSearchGubun().equals("amtCount")){//예외처리 int
				predicates.add(criteriaBuilder.equal(root.get(pageVO.getSearchGubun()), pageVO.getSearchText()));
			}else if(pageVO.getSearchGubun().equals("stockYn")){//예외처리 charcter
				predicates.add(criteriaBuilder.equal(criteriaBuilder.upper(root.get(pageVO.getSearchGubun())), pageVO.getSearchText().toUpperCase().charAt(0)));
			}else {
				predicates.add(criteriaBuilder.like(criteriaBuilder.upper(root.get(pageVO.getSearchGubun())), "%"+pageVO.getSearchText().toUpperCase()+"%"));
			}
		}
		
		criteriaQuery.where(criteriaBuilder.and(predicates.toArray(new Predicate[0])));
		countQuery.where(criteriaBuilder.and(predicates.toArray(new Predicate[0])));
		
		// ORDER BY절. CriteriaQuery로 생성
		criteriaQuery.orderBy(criteriaBuilder.desc(root.get("updatedAt")));
		if(pageVO.getSort()!= null) {
			if("asc".equals(pageVO.getOrder().toLowerCase())) {
				if(pageVO.getSort().contains(".")) {
					String[] gubun = pageVO.getSort().split("\\.");
					criteriaQuery.orderBy(criteriaBuilder.asc(root.get(gubun[0]).get(gubun[1])));
				}else {
					criteriaQuery.orderBy(criteriaBuilder.asc(root.get(pageVO.getSort())));
				}
			}else if("desc".equals(pageVO.getOrder().toLowerCase())){
				criteriaQuery.orderBy(criteriaBuilder.desc(root.get(pageVO.getSort())));
			}
		}
 
		
		//TypedQuery는 실행 결과를 리턴하는 타입이다.
		TypedQuery<PmsPartDtlModel> spareListQuery = entityManager.createQuery(criteriaQuery).setFirstResult((pageVO.getPage()-1)*pageVO.getRows()).setMaxResults(pageVO.getRows());

		List<PmsPartDtlModel> spareList = spareListQuery.getResultList();
		Long TotalCount = entityManager.createQuery(countQuery).getSingleResult();
		
		mapResult.put("total", TotalCount);
		mapResult.put("rows", spareList);
		return mapResult;
//		Sort sort = new Sort(Direction.DESC, "updatedAt");
//		if(pageVO.getSort()!= null) {
//			if("asc".equals(pageVO.getOrder().toLowerCase())) {
//				sort = new Sort(Direction.ASC, pageVO.getSort());
//			}else if("desc".equals(pageVO.getOrder().toLowerCase())){
//				sort = new Sort(Direction.DESC, pageVO.getSort());
//			}
//		}
//		
//		return partDetail.findAll(PageRequest.of(pageVO.getPage()-1, pageVO.getRows(),sort));
	}
	//엑셀 데이터 insert/update(order)
	@Override
	public String setExcelOrderSave(List<Map<String, String>> excelContent, ExcelUploadVO excelUploadVO){
		String strResult = "ERROR";
		
		//저장할 OrderModel List
		List<PmsTechOrderModel> saveOrderList = new ArrayList<PmsTechOrderModel>();
		
		//저장공간
		List<PmsTechOrderHistModel> insertHistList = new ArrayList<PmsTechOrderHistModel>();
		
		//RMS RunningHour 가져오기
		Map<String,Map> rhMap = getRmsRunningHour();
		
		try {

			//엑셀형식이 order한개에 parts가 여러개인 형태라 데이터 형식을 맞춰줌
			//저장공간
			List<Map<String, String>> excelRowList = new ArrayList<Map<String,String>>();
			
			//첫번째 parts에서만 row를 읽고, 두번째 parts에서 부터는 첫번재 row에 plateNo,pmsQty,pmsUnit 정보만 추가해준다.
			for(Map<String, String> excelRow: excelContent){
				if(excelRow.get("pmsCd01").equals("")) {
					Map<String, String> rowTemp = excelRowList.get(excelRowList.size()-1);
					if(!excelRow.get("plateNo").equals("")) {
						excelRowList.get(excelRowList.size()-1).put("plateNo", rowTemp.get("plateNo")+","+excelRow.get("plateNo"));
						excelRowList.get(excelRowList.size()-1).put("pmsQty", rowTemp.get("pmsQty")+","+excelRow.get("pmsQty"));
						excelRowList.get(excelRowList.size()-1).put("pmsUnit", rowTemp.get("pmsUnit")+","+excelRow.get("pmsUnit"));
					}
				}else {
					excelRowList.add(excelRow);
				}
			}
			
			//로우 만큼 반복
			for(Map<String, String> excelRow: excelRowList){
				
				String[] plateNo = excelRow.get("plateNo").split(",");
				String[] pmsQty = excelRow.get("pmsQty").split(",");
				String[] pmsUnit = excelRow.get("pmsUnit").split(",");
				
				//기본키 세팅
				PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk(excelUploadVO.getNationId(),excelUploadVO.getCompanyId()
						,excelUploadVO.getAreaId(),excelUploadVO.getEngineModel(),excelRow.get("pmsCd01"),excelRow.get("pmsCd02")
						,excelRow.get("pmsCd03"),String.valueOf((int)Float.parseFloat(excelRow.get("pmsCd04"))),excelRow.get("pmsCd05"));
				
				//데이터가 있는지 조회
				List<PmsTechOrderModel> pmsTechOrderSelect = orderList.findByPmsTechOrderPk(pmsTechOrderPk);
				
		
				
				PmsTechOrderModel pmsTechOrderModel;
				
				//데이터가 없으면 insert 있으면 update
				if(pmsTechOrderSelect.size() == 0) {//insert
				
					//Order데이터 매핑
					pmsTechOrderModel = new PmsTechOrderModel(pmsTechOrderPk, excelRow.get("descTech"), excelRow.get("descOrder")
							, excelRow.get("gapRunHour").equals("") ? 0 : (int)Float.parseFloat(excelRow.get("gapRunHour"))
							, excelRow.get("descEtc"));
					
					//★☆추후 삭제 필요!
					pmsTechOrderModel.setNeedPlateCount(0);
					
					//해당 order에 등록된 parts 가 있으면 parts 추가
					if(plateNo.length > 0 && !plateNo[0].equals("")) {
						//NeedPlateInfoJson 저장공간
						Gson gson = new Gson();
						Map<String, Map> addInfoMap = new HashMap<String, Map>();
						
						//Parts 수만큼 반복
						for(int i = 0; i < plateNo.length; i++) {
							//parts 조회 (!!등록되지 않은 parts는 조회가 되지 않기 때문에 에러가 발생)
							PmsPartDtlPk pmsPartDtlPk =  new PmsPartDtlPk(excelUploadVO.getNationId(),excelUploadVO.getCompanyId()
									,excelUploadVO.getAreaId(),excelUploadVO.getEngineModel(),plateNo[i]);
							strResult = plateNo[i];
							PmsPartDtlModel pmsPartDtlModel = partDetail.findByPmsPartDtlPk(pmsPartDtlPk).get(0);
							strResult = "ERROR";
							pmsTechOrderModel.getPartDtlList().add(pmsPartDtlModel);
							
							//NeedPlateInfoJson 생성
							addInfoMap.put(plateNo[i], convertAddInfotoMap((int)Float.parseFloat(pmsQty[i]),pmsUnit[i]));
						}
						//NeedPlateInfoJson 저장
						pmsTechOrderModel.setNeedPlateInfoJson(gson.toJson(addInfoMap));
					}
					
					//최초 히스토리 추가(eng01,eng02, ....)
					
					String cylExist = "";
					
					//히스토리 생성 For 문
					for(String strEng: STR_ENG_LIST) {
						//Engine RunningHour
						int engRH = Integer.parseInt(rhMap.get(strEng).get(KEY_RUNNINGHOUR).toString());
						
						//Engine 수 만큼 히스토리 생성  
						insertHistList.add(new PmsTechOrderHistModel(pmsTechOrderPk, strEng,
								"Initial creation",LocalDateTime.now(),pmsTechOrderModel.getGapRunHour(),engRH,true));
					}
					
					if(excelRow.get("pmsUnit").contains("Cyl")) {
						cylExist = "EXIST";
					}
					
					//Parts 중 Cyl이 있다면 Cyl 히스토리도 생성
					if(cylExist.equals("EXIST")) {
						for(String strEng: STR_ENG_LIST) {
							//Engine RunningHour
							int engRH = Integer.parseInt(rhMap.get(strEng).get(KEY_RUNNINGHOUR).toString());
							
							for(String strCyl: STR_CYL_LIST) {
							insertHistList.add(new PmsTechOrderHistModel(pmsTechOrderPk,strEng, strCyl,
									"Initial creation",LocalDateTime.now(),pmsTechOrderModel.getGapRunHour(), engRH, true));
							}
						}
					}
					//order에 history 입력
					pmsTechOrderModel.setPmsTechOrderHistList(insertHistList);
				}else {//update
					
					//조회한 데이터에 엑셀데이터 입력(수정사항이 있을수도 있기 때문)
					pmsTechOrderModel =  pmsTechOrderSelect.get(0);
					pmsTechOrderModel.setOrderExcelMapping(excelRow.get("descTech"), excelRow.get("descOrder")
							, excelRow.get("gapRunHour").equals("") ? 0 : (int)Float.parseFloat(excelRow.get("gapRunHour"))
							, excelRow.get("descEtc"));
					
					//조회한 데이터에 등록되어 있던 parts 조회
					List<PmsPartDtlModel> basePartsList = pmsTechOrderModel.getPartDtlList();
					
					//history비교를 위해 기존  pmsQty, pmsUnit 저장
					String beforeInfoJson = pmsTechOrderModel.getNeedPlateInfoJson();
					//Map<String, Map> beforeInfoMap = getOrderAddInfo(pmsTechOrderModel.getNeedPlateInfoJson());
					
					
					//조회한 데이터에 등록되어 있던 pmsQty, pmsUnit 조회
					Gson gson = new Gson();
					Map<String, Map> addInfoMap = getOrderAddInfo(pmsTechOrderModel.getNeedPlateInfoJson());
					
					/* 
					 * 기존에 등록되어 있던 prats와 신규등록 될 parts 를 비교
					 * - parts가 중복되면 pmsQty,Unit만 modify
					 * - parts가 중복되지 않으면 parts, pmsQty, Unit append
					 * */ 
					if(plateNo.length > 0 && !plateNo[0].equals("")) {//신규등록 될 parts가 없으면 수행하지 않는다.
						for(int i =0; i< plateNo.length;i++) {
							
							//입력된 parts 정보 조회
							PmsPartDtlPk pmsPartDtlPk =  new PmsPartDtlPk(excelUploadVO.getNationId(),excelUploadVO.getCompanyId()
									,excelUploadVO.getAreaId(),excelUploadVO.getEngineModel(),plateNo[i]);
							PmsPartDtlModel pmsPartDtlModel = partDetail.findByPmsPartDtlPk(pmsPartDtlPk).get(0);
							
							//기존 parts, 신규 parts 비교하여 parts modify or append
							if(basePartsList.size() > 0) {
								String partsExist = "";
								for(int j = 0; j < basePartsList.size(); j++) {
									if(basePartsList.get(j).getPmsPartDtlPk().getPlateNo().equals(plateNo[i])) {
										partsExist = "EXIST";
									}
								}
								if(!partsExist.equals("EXIST")) {
									pmsTechOrderModel.getPartDtlList().add(pmsPartDtlModel);
								}
							}else {
								pmsTechOrderModel.getPartDtlList().add(pmsPartDtlModel);
							}
							
							//NeedPlateInfoJson append(pateNo가 중복되면 modify, 중복되지 않으면 append)
							addInfoMap.put(plateNo[i], convertAddInfotoMap((int)Float.parseFloat(pmsQty[i]),pmsUnit[i]));
						}
					}
					//order에 변경된 NeedPlateInfoJson 적용
					pmsTechOrderModel.setNeedPlateInfoJson(gson.toJson(addInfoMap));

					//기존에 cyl History가 생성되지 않고 추가 될 parts에 cyl 생성
					List<PmsTechOrderHistModel> cylHistoryList = new ArrayList<PmsTechOrderHistModel>();
					List<PmsTechOrderHistModel> parentHistory = orderHistory.getParentListAll(pmsTechOrderPk);
					
					if(getOrderUnitExist(beforeInfoJson,"Cyl") == false && getOrderUnitExist(pmsTechOrderModel.getNeedPlateInfoJson(),"Cyl") == true) {
						for(PmsTechOrderHistModel engHistoryModel : parentHistory) {
							//혹시라도 history가 존재하면 모두 미사용처리
							orderHistory.updateRecentlyAll(pmsTechOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId());
							
							for(String strCyl: STR_CYL_LIST) {
								//Engine RunningHour
								int engRH = Integer.parseInt(rhMap.get(engHistoryModel.getEngineId()).get(KEY_RUNNINGHOUR).toString());
								
								insertHistList.add(new PmsTechOrderHistModel(pmsTechOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId(),
										strCyl,"Initial creation",LocalDateTime.now(),pmsTechOrderModel.getGapRunHour(), engRH, true));
							}
							
						}
						pmsTechOrderModel.getPmsTechOrderHistList().addAll(cylHistoryList);
					//Cyilender가 사라진 경우 History False 처리
					}else if(getOrderUnitExist(beforeInfoJson,"Cyl") == true && getOrderUnitExist(pmsTechOrderModel.getNeedPlateInfoJson(),"Cyl") == false) {
						for(PmsTechOrderHistModel engHistoryModel : parentHistory) {
							orderHistory.updateRecentlyAll(pmsTechOrderModel.getPmsTechOrderPk(),engHistoryModel.getEngineId());
						}
					}
				}
				//order 저장
				saveOrderList.add(pmsTechOrderModel);
			}
			orderList.saveAll(saveOrderList);
			orderHistory.saveAll(insertHistList);
			strResult = "SUCCESS";
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return strResult;
	}
	
	//엑셀 데이터 insert/update(parts)
	@Override
	public String setExcelPartsSave(List<Map<String, String>> excelContent, ExcelUploadVO excelUploadVO){
		String strResult = "ERROR";
		List<PmsPartDtlModel> partsList = new ArrayList<PmsPartDtlModel>();
		try {
			for(Map<String, String> excelRow: excelContent){
				PmsPartDtlPk pmsPartDtlPk = new PmsPartDtlPk(excelUploadVO.getNationId(),excelUploadVO.getCompanyId()
						,excelUploadVO.getAreaId(),excelUploadVO.getEngineModel(),excelRow.get("plateNo"));
			
	//			PmsPartDtlModel pmspartDtlModel = partDetail.findByPmsPartDtlPk(pmsPartDtlPk).get(0);
	//			if(pmspartDtlModel == null) {}
			
				PmsPartDtlModel pmspartDtlModel = new PmsPartDtlModel(pmsPartDtlPk, excelRow.get("platePart"), excelRow.get("siteCd"), excelRow.get("drawNo")
						, excelRow.get("typeCd"), excelRow.get("materialNo"), excelRow.get("ucode") , excelRow.get("prodStd")
						, excelRow.get("engineAmt").equals("") ? 0 : (int)Float.parseFloat(excelRow.get("engineAmt")),excelRow.get("amtUnit")
						, excelRow.get("stockYn").equals("") ? 'N' : excelRow.get("stockYn").charAt(0)
						, excelRow.get("limitTime").equals("") ? 0 : (int)Float.parseFloat(excelRow.get("limitTime")));
			
				partsList.add(pmspartDtlModel);
			}
			partDetail.saveAll(partsList);
			strResult = "SUCCESS";
		}catch(Exception e) {
			e.printStackTrace();
			strResult = "ERROR";
		}
		
		return strResult;
	}
	
	//WorkSpare -OrderModel CUD용
	//2개의 파라미터를 Map에 넣어줌(order - pmsQty, order - pmsUnit)
	public Map<String, String> convertAddInfotoMap(int pmsQty, String pmsUnit) {
		Map<String , String> addInfoMap = new HashMap<String , String>();
		addInfoMap.put("pmsQty", Integer.toString(pmsQty));
		addInfoMap.put("pmsUnit", pmsUnit);
		return addInfoMap;
	}
	
	//WorkSpare -OrderModel CUD용
	//String타입 JSON을 Map<String,Map>으로 변경
	public Map<String,Map> getOrderAddInfo(String addInfoJson) {
		Gson gson = new Gson();
		Map<String,Map> map = new HashMap<String, Map>();
		if((Map<String, Map>)gson.fromJson(addInfoJson, Map.class) != null) {
			map = (Map<String, Map>)gson.fromJson(addInfoJson, Map.class);
		}
		return map;
	}
	
	//WarkSpare - OrderTable에서 addInfoJson(pmsQty,pmsUnit)필드에 특정 unit이 있는지 체크
	public boolean getOrderUnitExist(String addInfoJson, String unit) {
		boolean unitExist = false;
		if(addInfoJson != null) {
			Gson gson = new Gson();
			Map<String,Map> map = new HashMap<String, Map>();
			map = (Map<String, Map>)gson.fromJson(addInfoJson, Map.class);
			for(String addInfoValue : map.keySet()) {
				if(map.get(addInfoValue).get("pmsUnit").equals(unit)) {
					unitExist = true;
				}
			}
		}
		return unitExist;
	}
	
	//RmsRunningHour 가져오기(현재시간, index01~10)
	public Map<String, Map> getRmsRunningHour(){
		Map<String,Map> rhMap = new HashMap<String, Map>();
		try {
			//RunningHour 필드
			String[] rhFieldName = {KEY_RUNNINGHOUR};
			
			ElasticVO elasticVO = new ElasticVO();
			String localTime = LocalDateTime.now().minusHours(14).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss",Locale.KOREA));
			//elasticVO.setStartTime("2019-08-01 09:00:00");
			elasticVO.setStartTime(localTime);
			elasticVO.setField1(rhFieldName);
			elasticVO.setIndex(STR_ENG_LIST);
			rhMap = elasticService.GetData_RunningHour(elasticVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		return rhMap;
	}
}
