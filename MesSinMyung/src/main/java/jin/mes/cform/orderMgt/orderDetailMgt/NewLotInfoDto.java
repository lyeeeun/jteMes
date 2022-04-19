package jin.mes.cform.orderMgt.orderDetailMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import kr.co.itcall.jte.spring.user.model.UserInfoVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewLotInfoDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -4815989333935166990L;/**
	 * 
	 */
	
	private int lotSeq;
	private String lotId;
	private String lotNm;
	private String lotCode;
	private String lotType;
	private int lotQty;
	private int lotMtrlCost;
	private int lotMtrlCostAfter;
	private int lotPersonCost;
	private int lotPersonCostAfter;
	private String lotPm;
	private String lotPmNm;
	private String lotState;
	private String lotDesc;
	private String createdAt;
	private String creatorId;
	private String updatedAt;
	private String updatorId;
	private String itemId;
	private String itemNm;
	private int itemDeduction;
	private String claimId;
	private String orderId;
	
	private String orderNm;     
	private String orderManager;
	private String orderStdt;
	private String orderEddt;
	private int orderCost;
	private String compId;
	private String orderState;
	private String description;
	
	//LOT 채번을 위한 업체 약어
	private String compInitials;
	
	//자재등록을 위함
	private String mtrlId;
	private String mtrlNm;
	private String mtrlMgtId;
	private int mtrlQty;
	private String compNm;
	private String mtrlDiv;
	private String mtrlDesc;
}
