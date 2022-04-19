package jin.mes.form.perform.prodStaMgt.workProdStaMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class WorkProdStaMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	
	// 품목 ID
	private String itemId;
	// 품목 명
	private String itemNm;
	// 작업자 아이디
	private String itemQtyUser; 
	// 작업자 명
	private String itemQtyUserNm;
	// 품목 총 주문 수량
	private int itemOrderQty;
	// 품목 총 불량 수량
	private int itemDefectQty;
	// 품목 총 불량율
	private float itemDefectRate;
	// 품목 총 생산 수량
	private int itemAchieveQty;
	// 품목 총 달성율
	private float itemAchieveRate;
}
