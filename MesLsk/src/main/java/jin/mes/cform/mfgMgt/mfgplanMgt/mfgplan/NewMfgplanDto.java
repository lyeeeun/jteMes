package jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewMfgplanDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = 4206838633226492241L;
	
	private String orderId; 
	private String orderNm; 
	private String orderStdt; 
	private String orderEddt; 
	private String lotId; 
	private String lotNm;
	private String itemId;
	private String itemNm;
	private float itemStd01;
	private float itemStd02;
	private float itemStd03;
	private float itemStd04;
	private float itemStd05;
	private String itemStdStr01;
	private String itemStdStr02;
	private String itemStdStr03;
	private String itemStdStr04;
	private String itemStdStr05;
	private String itemUnit;
	private String itemType;
	private int itemPrice;
	private String itemDesc;
	private int itemDeduction;
	private int itemDayTarget;
	private String lotState; 
	private int lotQty; 
	private String lotDesc; 
	private String lotCreatorId;
	private String lotCreatedAt;
	private String lotUpdatorId;
	private String lotUpdatedAt;
	private String prodPlanYear; 
	private String prodPlanMonth;
	private String prodPlanDay;
	private int planTotalQty;
	private int workTotalQty;
	private int planQty01;
	private int workQty01;
	private int planQty02;
	private int workQty02;
	private int planQty03;
	private int workQty03;
	private int planQty04;
	private int workQty04;
	private int planQty05;
	private int workQty05;
	private int planQty06;
	private int workQty06;
	private int planQty07;
	private int workQty07;
	private int planQty08;
	private int workQty08;
	private int planQty09;
	private int workQty09;
	private int planQty10;
	private int workQty10;
	private int planQty11;
	private int workQty11;
	private int planQty12;
	private int workQty12;
	private int planQty13;
	private int workQty13;
	private int planQty14;
	private int workQty14;
	private int planQty15;
	private int workQty15;
	private int planQty16;
	private int workQty16;
	private int planQty17;
	private int workQty17;
	private int planQty18;
	private int workQty18;
	private int planQty19;
	private int workQty19;
	private int planQty20;
	private int workQty20;
	private int planQty21;
	private int workQty21;
	private int planQty22;
	private int workQty22;
	private int planQty23;
	private int workQty23;
	private int planQty24;
	private int workQty24;
	private int planQty25;
	private int workQty25;
	private int planQty26;
	private int workQty26;
	private int planQty27;
	private int workQty27;
	private int planQty28;
	private int workQty28;
	private int planQty29;
	private int workQty29;
	private int planQty30;
	private int workQty30;
	private int planQty31;
	private int workQty31;
	
	private String[] calPrmt;
	private String calYear;
	private String calMonth;
	
}
