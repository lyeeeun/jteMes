package jin.mes.form.perform.workStaMgt.orderProStatus;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderProStatusDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	//수주 ID
	private String orderId;
	//품목 ID
	private String itemId;
	//품목 명
	private String itemNm;
	//Lot Id
	private String lotId;
	//Lot 명
	private String lotNm;
	//Lot Type
	private String lotType;
	//Lot 담당자(PM)
	private String lotPm;
	//주문 수량
	private int lotQty;
	//생산량
	private int lotAchieve;
	//불량수
	private int lotDefect;
	//남은 생산량
	private int lotRemain;
	//불량이 아닌 갯수(Chart 표현을 위해 사용)
	private int lotNotDefect;
	//달성율
	private float lotAchieveRate;
	//불량율
	private float lotDefectRate;
	//수주 총 수량
	private int lotTotalQty;
	//수주 총 생산량
	private int lotTotalGood;
	//수주 남은 생산량
	private int lotTotalRemain;
	//수주 총 달성율
	private float lotTotalGoodRate;
	//수주 총 미 달성율
	private float lotTotalRemainRate;
	
}
