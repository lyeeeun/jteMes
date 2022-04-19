package jin.mes.cform.orderMgt.costMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewCostMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 3907490121620175123L;
	
	private String lotSeq;
	private String lotId;
	private String lotNm;
	private String lotType;
	private int lotPersonCost;
	private int lotMtrlCost;
	private String lotDesc;
	private String lotItemId;
	private String itemNm;
}
