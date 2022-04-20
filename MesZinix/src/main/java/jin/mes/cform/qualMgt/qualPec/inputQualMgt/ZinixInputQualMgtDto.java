package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.ZinixMtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixInputQualMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 1718511844707342363L;

	private String mtrlOfId;
	private String mtrlOfNm;
	private String mtrlOfDate;
	private int mtrlOfCost;
	private String mtrlOfState;
	private String mtrlOfDesc;
	private String createdAt;
	private String updatedAt;
	private String creatorId;
	private String creatorNm;
	private String updatorId;
	private String mtrlOfClaim;
	private String mtrlReceipt;
	private String receiptWay;
	private String receiptStatus;
	private String receiptUser;
	private String receiptUserNm;
	
	private String mtrlOrderId;
	private int mtrlOrderQty;
	private String mtrlOrderUser;
	private String mtrlOrderUserNm;
	private String mtrlChargeUser;
	private String mtrlChargeUserNm;
	private String mtrlQualSta;
	private String mtrlOrderDate;
	private int mtrlOrderCost;
	private int mtrlOrderDelivery;
	private String mtrlOrderState;
	private String mtrlOrderDesc;
	private String mtrlId;
	private String mtrlNm;
	private String mtrlDiv;
	private String mtrlMgtId;
	private String mtrlCost;
	private String compId;
	private String compNm;
	private int	badQty;
	
	private List<MsgViewModel> msgList;
	private List<ZinixMtrlOdplanMgtDto> mtrlOrderList;
}