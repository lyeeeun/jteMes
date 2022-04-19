package jin.mes.cform.basMgt.operMgt.compMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixCompMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = 7378676037183249286L;

	
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
	
	private List<ZinixCompAddrDto> childAddrList;
	
	private List<MsgViewModel> msgList;
	
	//rtl field
	private String mtrlId;
	private String toolId;
	private int mtrlPrice; // 업체 별 자재 단가
}
