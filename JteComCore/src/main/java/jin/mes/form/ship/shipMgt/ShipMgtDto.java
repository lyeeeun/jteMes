package jin.mes.form.ship.shipMgt;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ShipMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 7161704239680756321L;
	
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
	private String rlesPlanTotal;
	//출하 계획 수량 합계
	private String shipPlanTotal;
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
	//출하 예정 수량 합계
	private int shipExceptQty;
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
	
	private String compId;
	
	private String compNm;

	
}
