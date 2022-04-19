package jin.mes.form.orderMgt.orderSheet.deliveryStatus;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class LotDeliveryStaDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	
	private String orderId;
	private String orderNm;
	private String orderState;
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
	private String shipId;
	private String shipPlanState;
	private String shipCompleteDate;
	private String compId;
	private String compNm;
	private String shipQty;
	
	private List<LotDeliveryStaDto> lotDeliveryStaList;
	
}
