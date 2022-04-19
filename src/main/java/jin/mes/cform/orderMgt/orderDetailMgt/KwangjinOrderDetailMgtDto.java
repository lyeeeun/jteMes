package jin.mes.cform.orderMgt.orderDetailMgt;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinOrderDetailMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 6271629318833370412L;
	
	private String orderId;
	private String orderNm;
	private String orderManager;
	private String orderStdt;
	private String orderEddt;
	private int orderCost;
	private String createdAt;
	private String updatedAt;
	private String creatorId;
	private String updatorId;
	private String description;
	private String orderState;
	private String compId;
	private int compStdStr02;
	private String compNumber;
	private String orderManagerNm;
	private String compNm;
	private int slipNum;
	private int shipQty;
	
	private String itemId;
	private String itemNm;
	private String itemStdStr01;
	private int itemStdStr02;
	private int lotQty;
	private String lotState;
	private String tieId;
	private List<KwangjinLotInfoDto> childLotList;
	private List<KwangjinOrderDetailMgtDto> orderTieList;
	
	//원가정보
	private int orderCostBefore;
	private int orderCostAfter;
	
	//클레임정보
	private int claimCnt;
}
