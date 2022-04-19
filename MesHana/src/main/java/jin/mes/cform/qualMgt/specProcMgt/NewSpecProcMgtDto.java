package jin.mes.cform.qualMgt.specProcMgt;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewSpecProcMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -5441519663983409996L;
	
	private String  		spcId;
	private String  		spcNm;
	private String  		spcPnmn;
	private String			spcCause;
	private String  		spcGoal;
	private String 			spcMeasure;
	private String  		spcResult;
	private String  		spcEffect;
	private String  		spcStandard;
	private String	 		spcManager;
	private String  		spcFile;
	private String  		spcUsers;
	private String			updatedAt;
	private String  		updatorId;
	private String			createdAt;
	private String			creatorId;
	private String			spcItem;
	private String			spcStartDt;
	private String			spcFinishDt;
	private String			spcStatus;
	private String			spcAlarm;
	private String			itemNm;
	
	
	private List<MsgViewModel> msgList;
	
	//첨부파일
	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;

}
