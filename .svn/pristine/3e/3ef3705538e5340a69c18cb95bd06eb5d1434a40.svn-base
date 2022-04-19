package jin.mes.form.perform.performOrderGrid;

import java.math.BigDecimal;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PerformOrderGridDto extends BaseVo{
	
	private static final long serialVersionUID = -7223763972842869911L;
	//수주 ID
	private String orderId;
	//수주 명
	private String orderNm;
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
	
	/*** 진행 정보 팝업 관련 ***/
	//라우팅 ID
	private String routingId;
	//작업자 명
	private String userNm;
	//작업 지시량
	private int prodWorkQty;
	//생산량
	private int prodWorkGood;
	//불량 수
	private int prodWorkBad;
	//달성율
	private float prodWorkGoodRate;
	//불량율
	private float prodWorkBadRate;
	//작업상태
	private String workState;
}
