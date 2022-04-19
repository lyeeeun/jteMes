package jin.mes.form.perform.processProgress;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ProcessProgressDto extends BaseVo{
	
	private static final long serialVersionUID = -7223763972842869911L;

	// 품목 ID
	private String itemId;
	// 품목 명
	private String itemNm;
	// 품목 총 주문 수량
	private int itemOrderQty;
	// 품목 총 불량 수량
	private int itemDefectQty;
	// 품목 공제량
	private int itemDeduction;
	// 품목 일일 목표량
	private int itemDayTarget;
	// 품목 작업 지시량
	private int itemAsmQty;
	// 품목 총 불량율
	private float itemDefectRate;
	// 품목 총 생산 수량
	private int itemAchieveQty;
	// 품목 총 달성율
	private float itemAchieveRate;
	// 품목 매출 점유율
	private float itemSalesShare;
	// 기간 검색
	private String startDate;
	private String endDate;
	
	// 월별 집계용
	private String monthDate;
	
	
}
