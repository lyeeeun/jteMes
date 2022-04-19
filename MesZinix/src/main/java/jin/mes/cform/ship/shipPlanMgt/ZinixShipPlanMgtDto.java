package jin.mes.cform.ship.shipPlanMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixShipPlanMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8253792131157844557L;
	
//	public ZinixShipPlanMgtDto(String shipPlanId, String shipPlanType, String shipPlanYear, String shipPlanMonth, String shipPlanDay, int shipPlanQty, String shipPlanDesc, String creatorId, String updatorId, String lotId) {
//		 this.shipPlanId = shipPlanId;
//		 this.shipPlanType = shipPlanType;
//		 this.shipPlanYear = shipPlanYear;
//		 this.shipPlanMonth = shipPlanMonth;
//		 this.shipPlanDay = shipPlanDay;
//		 this.shipPlanQty = shipPlanQty;
//		 this.shipPlanDesc = shipPlanDesc;
//		 this.creatorId = creatorId;
//		 this.updatorId = updatorId;
//		 this.lotId = lotId;
//	
//	}
	
	private String lotId;
	private String shipPlanId;
	private String shipPlanType;
	private String shipPlanYear;
	private String shipPlanMonth;
	private String shipPlanDay;
	private int shipPlanQty;
	private int pickPlanQty;
	private int shipTotalQty;
	private int pickTotalQty;
	private String itemId;
	private String itemMgtId;
	private String itemNm;
	private int itemStock;
	private String itemDesc;
	private int itemDeduction;
	private int itemDayTarget;
	private String shipPlanDesc;
	private String createdAt;
	private String creatorId;
	private String updatedAt;
	private String updatorId;
	
	
	private String shipId;
	private String shipPlanDate;
	private String shipDate;
	private String shipState;
	private int shipQty;
	private String shipType;
	private String shipUser;
	private String shipOrder;
	private String shipDesc;
	private String compId;
	private String compNm;
	private String compNumber;
	private String compAddrId;
	private String compAddrDetail;
	private int lotQty;
	private int lotSeq;
	private String orderId;
	private String orderNm;
	private int prsPackageQty;
	private String pkgWorkId;
	private String programId;
	
	private String[] calPrmt;
	private String calYear;
	private String calMonth;

	private int planQty01;
	private int planQty02;
	private int planQty03;
	private int planQty04;
	private int planQty05;
	private int planQty06;
	private int planQty07;
	private int planQty08;
	private int planQty09;
	private int planQty10;
	private int planQty11;
	private int planQty12;
	private int planQty13;
	private int planQty14;
	private int planQty15;
	private int planQty16;
	private int planQty17;
	private int planQty18;
	private int planQty19;
	private int planQty20;
	private int planQty21;
	private int planQty22;
	private int planQty23;
	private int planQty24;
	private int planQty25;
	private int planQty26;
	private int planQty27;
	private int planQty28;
	private int planQty29;
	private int planQty30;
	private int planQty31;
	
	private int pickPlanQty01;
	private int pickPlanQty02;
	private int pickPlanQty03;
	private int pickPlanQty04;
	private int pickPlanQty05;
	private int pickPlanQty06;
	private int pickPlanQty07;
	private int pickPlanQty08;
	private int pickPlanQty09;
	private int pickPlanQty10;
	private int pickPlanQty11;
	private int pickPlanQty12;
	private int pickPlanQty13;
	private int pickPlanQty14;
	private int pickPlanQty15;
	private int pickPlanQty16;
	private int pickPlanQty17;
	private int pickPlanQty18;
	private int pickPlanQty19;
	private int pickPlanQty20;
	private int pickPlanQty21;
	private int pickPlanQty22;
	private int pickPlanQty23;
	private int pickPlanQty24;
	private int pickPlanQty25;
	private int pickPlanQty26;
	private int pickPlanQty27;
	private int pickPlanQty28;
	private int pickPlanQty29;
	private int pickPlanQty30;
	private int pickPlanQty31;

}
