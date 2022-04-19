package jin.mes.form.perform.prodStaMgt.facilProdMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class FacilProdMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	
	// 설비 ID
	private String eqmtMgtId;
	// 설비명
	private String eqmtMgtNm;
	// 품목 ID
	private String itemId;
	// 품목 명
	private String itemNm;
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
