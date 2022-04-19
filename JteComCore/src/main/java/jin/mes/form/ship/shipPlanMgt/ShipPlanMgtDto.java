package jin.mes.form.ship.shipPlanMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ShipPlanMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8253792131157844557L;
	
			//출고계획 ID
			private String rlesPlanId;
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
			//출고 계획량
			private int rlesPlanQty;
			//출고 상태
			private String rlesPlanState;
			//출고 계획 수량 합계
			private int rlesPlanTotal;
			//출고 계획 필요 수량 
			private int rlesPlanNeed;
			//출고 예정 수량 합계
			private int rlesExceptQty;
			//출고완료수량
			private int rlesMgtQty;
			//출고 완료 수량 합계
			private int rlesWorkQty;
			//출고완료 재고수량
			private int rlesStockQty;
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
			//출하 계획 수량 합계
			private int shipPlanTotal;
			//출하 계획 필요 수량 
			private int shipPlanNeed;
			//출하 예정 수량 합계
			private int shipExceptQty;
			//출하 완료 수량 합계
			private int shipEndQty;
			//생성일
			private String createdAt;
			//생성자
			private String creatorId;
			//수정일
			private String updatedAt;
			//수정자
			private String updatorId;
}
