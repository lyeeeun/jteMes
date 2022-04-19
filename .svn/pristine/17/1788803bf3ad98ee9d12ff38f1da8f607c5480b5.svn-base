package jin.mes.form.qualMgt.qualPec.finalQualMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class FinalQualMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -35429912271129479L;
	
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
		
	// 단위
	private String itemUnit;
	// 재질
	private String itemMtrl;
	// 공제량
	private int itemDeduction;
	
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

	/*** 다국어 ***/
	
	private List<MsgViewModel> msgList;
}
