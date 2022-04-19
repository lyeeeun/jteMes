package jin.mes.cform.ship.shipPlanMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinShipPlanMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8253792131157844557L;
	
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
			//부품 생산 재고량
			private int itemStock;
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
			//출하검사상태
			private String shipInspect;
			//출하납품상태
			private String shipDelivery;
			//생성일
			private String createdAt;
			//생성자
			private String creatorId;
			//수정일
			private String updatedAt;
			//수정자
			private String updatorId;
			
			private String shipId;
			
			private int shipQty;
			
}
