package jin.mes.cform.mtrl.itemShipMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinItemShipMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -7260027713579229002L;

	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	
	/*** 제품 정보 ***/
	// 제품 ID
	private String itemId;
	// 제품 명
	private String itemNm;
	// 제품 구분
	private String itemType;
	// 제품 단가
	private int itemPrice;
	// 제품 제조(생산) 인건비
	private int itemPersonCost;
	// 제품 방진구Φ
	private float itemStd01;
	// 제품 소재Φ
	private float itemStd02;
	// 제품 SUBΦ
	private float itemStd03;
	// 제품 무게
	private float itemStd04;
	// 제품 규격,소재05
	private float itemStd05;
	
	//예비필드(Str)
	private String itemStdStr01;
	private String itemStdStr02;
	private String itemStdStr03;
	private String itemStdStr04;
	private String itemStdStr05;
		
	// 비고
	private String itemDesc;
	
	/*** 개별 제품 정보 ***/
	// 개별 제품 ID(Lot ID, 관리자용 ID)
	private String itemMgtId;
	// 개별 제품 구분(Lot 생산, 관리자 입력)
	private String itemMgtType;
	// 제조일자(생산일자)
	private String itemMfgDate;
	// 재고
	private int itemStock;
	// 포장 수량
	private int itemPackageStock;
	// 비고
	private String description;
	private String itemMgtDesc;
	// 생성일
	private String createdAt;
	// 생성자
	private String creatorId;
	// 수정일
	private String updatedAt;
	// 수정자
	private String updatorId;
	// 사용 완료 여부
	private boolean isDel;
	
	/*** 개별 제품 수량 정보 ***/
	// 업무 구분
	private String itemQtyTarget;
	// 업무 코드
	private String itemQtyTargetCode;
	// 수량 정보
	private int itemQtyTotal;
	// 업무 비고
	private String itemQtyDesc;
	// 업무 프로그램 코드(작업 코드)
	private String itemQtyPgCd;
	// 업무 일자(작업 일자)
	private String itemQtyDate;
	// 업무 대상자(작업자)
	private String itemQtyUser; 
	// 업무 대상자 이름(작업자)
	private String itemQtyUserNm;
}
