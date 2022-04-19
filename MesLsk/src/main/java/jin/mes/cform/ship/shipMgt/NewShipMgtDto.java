package jin.mes.cform.ship.shipMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewShipMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 7161704239680756321L;
	
	// 출하 ID
	private String shipId;
	// 출하 상태
	private String shipState;
	// 출하 수량
	private int shipQty;
	// 수주 ID
	private String orderId;
	// 수주 상태
	private String orderState;
	// Lot ID
	private String lotId;
	// Lot Seq
	private int lotSeq;
	// Lot 상태
	private String lotState;
	// 품목
	private String itemId;
	// 프로그램ID
	private String programId;
	
	
	
}
