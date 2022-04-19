package jin.mes.form.orderMgt.orderSheet.orderConfirm;


import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderConfirmDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	
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
	
	private String orderManagerNm;
	private String compNm;
	
	//원가정보
	private int orderCostBefore;
	private int orderCostAfter;
	
	//클레임정보
	private int claimCnt;
}
