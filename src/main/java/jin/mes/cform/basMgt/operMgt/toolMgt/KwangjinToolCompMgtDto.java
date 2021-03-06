package jin.mes.cform.basMgt.operMgt.toolMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompAddrDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinToolCompMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = 6325091346976973529L;
	
	private String compId;
	private String compNm;
	private String compInitials;
	private String compManagr; 
	private String compNumber; 
	private String compType; 
	private String compAddr;
	private String createdAt; 
	private String updatedAt; 
	private String creatorId; 
	private String updatorId;
	private String description; 
	private boolean isUse;
	
	//예비
	private String compStd01;
	private String compStd02;
	private String compStd03;
	private String compStd04;
	private String compStd05;
	private String compStdStr01;
	private String compStdStr02;
	private String compStdStr03;
	private String compStdStr04;
	private String compStdStr05;
	
	private List<KwangjinCompAddrDto> childAddrList;
	
	private List<MsgViewModel> msgList;
	
	//rtl field
	private String mtrlId;
	private String toolId;
}
