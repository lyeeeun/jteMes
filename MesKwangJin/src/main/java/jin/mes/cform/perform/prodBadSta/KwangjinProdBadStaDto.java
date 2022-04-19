package jin.mes.cform.perform.prodBadSta;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinProdBadStaDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;

	// 품목 ID
	private String itemId;
	// 품목 명
	private String itemNm;
	// 품목 총 주문 수량
	private int itemOrderQty;
	// 품목 총 생산 수량
	private int itemAchieveQty;
	// 품목 총 달성율
	private float itemAchieveRate;
	// 품목 생산률
	private float itemTotalGoodRate;
	// 품목 남은 생산률
	private float itemTotalRemainRate;
	// 품목 불량 수량
	private int itemDefectQty;
	// 품목 불량률
	private float itemDefectRate;
	// 불량률 제외
	private float defectZeroRate;
	// 테스트 불량
	private float ZeroRate;
}
