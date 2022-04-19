package kr.co.itcall.jte.pms.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.itcall.jte.pms.model.PmsPartDtlModel;
import kr.co.itcall.jte.pms.model.PmsTechOrderModel;
import kr.co.itcall.jte.pms.model.support.PmsPartDtlPk;
import kr.co.itcall.jte.pms.model.support.PmsTechOrderPk;
import kr.co.itcall.jte.pms.repository.PmsPartDtlRepository;
import kr.co.itcall.jte.pms.repository.PmsTechOrderHistRepository;
import kr.co.itcall.jte.pms.repository.PmsTechOrderRepository;
import kr.co.itcall.jte.rms.model.MasterVO;

@Service
public class PmsTestServiceImpl implements PmsTestService{
	@PersistenceContext
	EntityManager entityManager;
	
	@Autowired
	PmsPartDtlRepository partDetail;
	
	@Autowired
	PmsTechOrderHistRepository orderHistory;
	
	@Autowired
	PmsTechOrderRepository orderList;
	
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
			
			//기본키로 검색
			pmsFindOrderOne = orderList.findByPmsTechOrderPk(pmsTechOrderPk);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pmsFindOrderOne;
	}

	/* 
	 * Parts 검색(Parts_Name - plate_No, Parts_No - prod_std) 동적 쿼리를 위해 CriteriaBuilder를 사용 
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
				predicates.add(criteriaBuilder.like(root.get("pmsPartDtlPk").get(masterVO.getSearchGubun()), "%"+masterVO.getSearchText()+"%")); 
				}else if(masterVO.getSearchGubun().equals("prodStd")) {
					predicates.add(criteriaBuilder.like(root.get(masterVO.getSearchGubun()), "%"+masterVO.getSearchText()+"%")); 
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
	 * Parts 상세조회(1건)
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
	 *  PmsOrder에 Parts 추가 
	 *  */
	@Override
	public String setPartsAppend(PmsTechOrderModel pmsOrderModel) {
		String strResult = "ERROR";
		try {
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
			
			//추가할 Parts가 order에 없으면 추가 수행
			if(!strResult.equals("EXIST")) {
				baseOrderModel.getPartDtlList().add(searchResult.get(0));
				orderList.save(baseOrderModel);
				strResult = "SUCCESS";
			}
		}catch(Exception e) {
			strResult = "ERROR";
		}
		return strResult;
	}
	
	/*
	 *  PmsOrder에 Parts 삭제 
	 *  */
	@Override
	public String setPartsDelete(PmsTechOrderModel pmsOrderModel) {
		String strResult = "ERROR";
		try {
			//기본키 세팅
			PmsTechOrderPk pmsTechOrderPk = new PmsTechOrderPk("Columbia", "Axia", "Termonorte", "20H35DFV",
					pmsOrderModel.getPmsTechOrderPk().getPmsCd01(),pmsOrderModel.getPmsTechOrderPk().getPmsCd02(),
					pmsOrderModel.getPmsTechOrderPk().getPmsCd03(),pmsOrderModel.getPmsTechOrderPk().getPmsCd04(),pmsOrderModel.getPmsTechOrderPk().getPmsCd05());
			
			//기존 Order 목록 조회
			PmsTechOrderModel baseOrderModel = orderList.findByPmsTechOrderPk(pmsTechOrderPk).get(0);
			
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
			
			//삭제할 Parts를 제외한 Parts 정보를 담은 변수를 세팅한다.
			baseOrderModel.setPartDtlList(BaseDtlList);
			
			//저장한다.
			orderList.save(baseOrderModel);
			strResult = "SUCCESS";
		}catch(Exception e) {
			strResult = "ERROR";
		}
		return strResult;
	}
}
