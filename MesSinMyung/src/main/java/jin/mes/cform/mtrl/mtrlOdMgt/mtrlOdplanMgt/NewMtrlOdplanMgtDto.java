package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewMtrlOdplanMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -777235282626913477L;
	
	private String mtrlOrderId;
	private int mtrlOrderQty;
	private String mtrlOrderUser;
	private String mtrlOrderUserNm;
	private String mtrlOrderDate;
	private int mtrlOrderCost;
	private int mtrlOrderDelivery;
	private String mtrlOrderState;
	private String mtrlOrderDesc;
	private String createdAt;
	private String updatedAt;
	private String creatorId;
	private String creatorNm;
	private String updatorId;
	private String mtrlId;
	private String mtrlNm;
	private String mtrlDiv;
	private String mtrlMgtId;
	private String mtrlCost;
	private String compId;
	private String compNm;
	private String mtrlOfId;
	private String mtrlOfNm;
	private String mtrlOfDate;
	private int	badQty;
	
	private List<MsgViewModel> msgList;	

}
