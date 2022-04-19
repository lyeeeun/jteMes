package jin.mes.cform.mtrl.itemRecevingMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class KwangjinItemRecevingHisDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -6603586253138827269L;
	
	public KwangjinItemRecevingHisDto(String itemId, String itemMgtId, int itemQtyTotal, String itemQtyTarget, String itemQtyTargetCode, String itemQtyDate, String itemQtyUser) {
		this.itemId = itemId;
		this.itemMgtId = itemMgtId;
		this.itemQtyTotal = itemQtyTotal;
		this.itemQtyTarget = itemQtyTarget;
		this.itemQtyTargetCode = itemQtyTargetCode;
		this.itemQtyDate =  itemQtyDate;
		this.itemQtyUser = itemQtyUser;
	}
		
	private int firstIndex;
	private int lastIndex;

	// 제품 ID
	private String itemId;
	// 제품 명
	private String itemNm;
	// 개별 제품 ID(Lot ID, 관리자용 ID)
	private String itemMgtId;
	// 개별 제품 구분(Lot 생산, 관리자 입력)
	private String itemMgtType;
	// 제조일자(생산일자)
	private String itemMfgDate;
	// 재고
	private int itemStock;
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
	// 생성일
	private String createdAt;
	// 생성자
	private String creatorId;
	// 수정일
	private String updatedAt;
	// 수정자
	private String updatorId;
	
}
