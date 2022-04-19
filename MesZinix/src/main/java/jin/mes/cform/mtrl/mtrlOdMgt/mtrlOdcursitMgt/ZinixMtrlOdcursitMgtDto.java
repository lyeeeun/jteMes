package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.ZinixMtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixMtrlOdcursitMgtDto extends BaseVo{/**
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
	
	private List<MsgViewModel> msgList;
	private List<ZinixMtrlOdplanMgtDto> mtrlOrderList;
}
