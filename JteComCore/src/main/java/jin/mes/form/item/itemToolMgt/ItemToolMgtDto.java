package jin.mes.form.item.itemToolMgt;

import java.util.List;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemCompMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemToolMgtDto extends BaseVo{
	private static final long serialVersionUID = -7223763972842869911L;
	
	
	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	// 품목 ID
	private String itemId;
	// 품목 명
	private String itemNm;
	// 제품유형(완제품, 중간품)
	private String itemType;
	// 제품 단가
	private int itemPrice;
	// 제품 제조원가
	private int itemMtrlCost;
	// 제품 제조(생산) 인건비
	private int itemPersonCost;
	// 제품 길이
	private float itemStd01;
	// 제품 폭
	private float itemStd02;
	// 제품 두께
	private float itemStd03;
	// 제품 무게
	private float itemStd04;
	// 품목 규격, 소재05
	private float itemStd05;
	
	//예비필드(Str)
	private String itemStdStr01;
	private String itemStdStr02;
	private String itemStdStr03;
	private String itemStdStr04;
	private String itemStdStr05;
	private String itemStdStr06;
	
	// 총 수량
	private int itemTotalStock;
	// 일일 목표량
	private int itemDayTarget;
	// 생성일시
	private String createdAt;
	// 수정일시
	private String updatedAt;
	// 생성자 ID
	private String creatorId;
	// 수정자 ID
	private String updatorId;
	// 설명
	private String description;
	// 사용 여부
	private boolean isUse;
	// 단위
	private String itemUnit;
	// 재질
	private String itemMtrl;
	// 관련 업체 코드
	private String toolId;
	// 관련 업체 명
	private String toolNm;

	
	private List<ItemToolRtlDto> childToolMgtList;
}
