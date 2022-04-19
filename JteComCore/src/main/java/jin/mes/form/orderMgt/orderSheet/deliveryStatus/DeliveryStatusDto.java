package jin.mes.form.orderMgt.orderSheet.deliveryStatus;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryStatusDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	
	private String orderId;
	private String orderNm;
	private String orderManager;
	private String orderStdt;
	private String orderEddt;
	private int orderCost;
	private String description;
	private String orderState;
	private String orderManagerNm;
	private int lotSeq;
	private String lotId;
	private String lotNm;
	private String lotState;
	private String lotQty;
	private String lotPm;
	private String lotPmNm;
	private String lotDesc;
	private String createdAt;
	private String creatorId;
	private String updatedAt;
	private String updatorId;
	private String itemId;
	private String itemNm;
	private String compId;
	private String compNm;
	private String shipId;
	private String shipStartDate;
	private String shipQty;
	private String shipState;
	
	private List<DeliveryStatusDto> deliveryStaList;
	
}
