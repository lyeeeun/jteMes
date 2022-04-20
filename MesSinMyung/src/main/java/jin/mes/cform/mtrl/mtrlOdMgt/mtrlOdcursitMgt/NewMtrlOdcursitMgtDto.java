package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdcursitMgt;

import java.util.List;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.NewMtrlOdplanMgtDto;
import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewMtrlOdcursitMgtDto extends BaseVo{/**
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
	
	private List<MsgViewModel> msgList;
	private List<NewMtrlOdplanMgtDto> mtrlOrderList;
}