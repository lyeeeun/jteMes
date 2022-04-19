package jin.mes.cform.ship.shipMgt;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinShipMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 7161704239680756321L;
	
	//Order ID
	private String orderId;
	//수주명
	private String orderNm;
	//Lot ID
	private String lotId;
	//Lot명
	private String lotNm;
	//Lot 수량
	private int lotQty;
	//Lot 상태
	private String lotState;
	//부품 코드
	private String itemId;
	//부품개별코드
	private String itemMgtId;
	//부품명
	private String itemNm;
	//출하코드
	private String shipPlanId;
	//출하계획량
	private int shipPlanQty;
	//출하계획비고
	private String shipPlanDesc;
	//출하계획일
	private String shipPlanDate;
	//출하상태
	private String shipPlanState;
	//생성일
	private String createdAt;
	//생성자
	private String creatorId;
	//수정일
	private String updatedAt;
	//수정자
	private String updatorId;
	//사용자ID
	private String userId;
	//사용자명
	private String userNm;
	// 출하 ID
	private String shipId;
	// 출하 상태
	private String shipState;
	// 출하 검사 상태
	private String shipInspect;
	// 출하 수량
	private int shipQty;
	
	private String shipDesc;
	
	private String shipWorker;
	
	private String shipCompleteDate;

	private String shipTransport;
	
	private String shipDelivery;
	
	private String compId;
	
	private String compNm;

	
}
