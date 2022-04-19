package jin.mes.cform.ship.shipPlanMgt;

import java.util.List;

import jin.mes.form.basMgt.routing.routingMgt.RoutingRtlToolDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewShipPlanMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8253792131157844557L;

	/*** 출하 정보 ***/
	// 출하 ID
	private String shipId;
	// 출하(납품) 예정일자
	private String shipPlanDate;
	// 출하(납품) 일자
	private String shipDate;
	// 출하 상태
	private String shipState;
	// 출하 수량
	private int shipQty;
	// 출하 총 수량
	private int shipTotalQty;
	// 배송 방법
	private String shipType;
	// 배송 기사
	private String shipUser;
	// 운송장 번호
	private String shipOrder;
	// 비고
	private String shipDesc;
	// 업체 ID
	private String compId;
	// 업체 명
	private String compNm;
	// 업체 연락처
	private String compNumber;
	// 업체 주소 ID
	private String compAddrId;
	// 업체 주소
	private String compAddrDetail;
	// Lot ID
	private String lotId;
	// 주문 수량
	private int lotQty;
	// Lot Seq
	private int lotSeq;
	// 품목 ID
	private String itemId;
	// 품목 명
	private String itemNm;
	// 수주 ID
	private String orderId;
	// 수주 명
	private String orderNm;
	// 포장 수량
	private int prsPackageQty;
	// 포장 작업 ID
	private String pkgWorkId;
	// 프로그램 ID
	private String programId;

}
