package jin.mes.form.mtrl.mtrlOdMgt.mtrlOdRecord;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MtrlOdRecordDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	
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

	
	private List<MsgViewModel> msgList;
	private List<MtrlOdplanMgtDto> mtrlOrderList;

}
