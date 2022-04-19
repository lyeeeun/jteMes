package jin.mes.form.item.itemStockMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class ItemStockMgtDto extends BaseVo{
	
	private static final long serialVersionUID = -7223763972842869911L;

	//수량관리(품목관리)
	public ItemStockMgtDto(String itemId, String itemMgtId, String itemMgtType, String itemMfgDate, int itemStock, int itemPackageStock,String description) {
		this.itemId = itemId;
		this.itemMgtId = itemMgtId;
		this.itemMgtType = itemMgtType;
		this.itemMfgDate = itemMfgDate;
		this.itemStock =  itemStock;
		this.itemPackageStock = itemPackageStock;
		this.description = description;
	}
	
	//사용기록
	public ItemStockMgtDto(String itemId, String itemMgtId, int itemQtyTotal, String itemQtyTarget, String itemQtyTargetCode, String itemQtyDate, String itemQtyUser) {
		this.itemId = itemId;
		this.itemMgtId = itemMgtId;
		this.itemQtyTotal = itemQtyTotal;
		this.itemQtyTarget = itemQtyTarget;
		this.itemQtyTargetCode = itemQtyTargetCode;
		this.itemQtyDate =  itemQtyDate;
		this.itemQtyUser = itemQtyUser;
	}
		
	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	
	/*** 품목 정보 ***/
	// 품목 ID
	private String itemId;
	// 품목 명
	private String itemNm;
	// 품목 구분
	private String itemType;
	// 품목 총 수량
	private int itemTotalStock;
	// 제품 단가
	private int itemPrice;
	// 제품 제조(생산) 인건비
	private int itemPersonCost;
	// 품목 방진구Φ
	private float itemStd01;
	// 품목 소재Φ
	private float itemStd02;
	// 품목 SUBΦ
	private float itemStd03;
	// 품목 무게
	private float itemStd04;
	// 품목 규격,소재05
	private float itemStd05;
	
	//예비필드(Str)
	private String itemStdStr01;
	private String itemStdStr02;
	private String itemStdStr03;
	private String itemStdStr04;
	private String itemStdStr05;
		
	//규격
	private String itemStandard;
	// 단위
	private String itemUnit;
	// 재질
	private String itemMtrl;
	// 비고
	private String itemDesc;
	
	/*** 개별 품목 정보 ***/
	// 개별 품목 ID(Lot ID, 관리자용 ID)
	private String itemMgtId;
	// 개별 품목 구분(Lot 생산, 관리자 입력)
	private String itemMgtType;
	// 제조일자(생산일자)
	private String itemMfgDate;
	// 재고
	private int itemStock;
	// 포장 수량
	private int itemPackageStock;
	// 비고
	private String description;
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
	
	/*** 개별 품목 수량 정보 ***/
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
