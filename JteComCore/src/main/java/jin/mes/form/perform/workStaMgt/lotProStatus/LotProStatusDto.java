package jin.mes.form.perform.workStaMgt.lotProStatus;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class LotProStatusDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	
	private String lotSeq;
	private String lotId;
	private String lotNm;
	private int lotShipQty;
	private int shipQty;
	private int lotQty;
	private float lotShipRate;
	private String lotPm;
	private String lotPmNm;
	private String lotState;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String itemId;
	private String itemNm;
	private String orderId;
}
