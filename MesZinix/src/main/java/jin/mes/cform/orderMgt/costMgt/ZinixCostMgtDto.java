package jin.mes.cform.orderMgt.costMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixCostMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 3907490121620175123L;
	
	
	private String lotId;
	private String lotNm;
	private int lotQty;
	private String itemNm;
	private long  itemMtrlCost;
	private long predMtrlCost;
	private long presMtrlCost;
}
