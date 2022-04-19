package jin.mes.form.basMgt.operMgt.toolMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.operMgt.compMgt.CompAddrDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ToolMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = 6325091346976973529L;
	
	private String toolId; 
	private String toolNm;
	private String toolDc;
	private String toolType; 
	private int toolPrice; 
	private int toolLimit; 
	private String toolDesc;
	private boolean isUse;
	private String creatorId;
	private String createdAt; 
	private String updatorId;
	private String updatedAt;
	
	//예비
	private float toolStd01;
	private float toolStd02;
	private float toolStd03;
	private float toolStd04;
	private float toolStd05;
	private String toolStdStr01;
	private String toolStdStr02;
	private String toolStdStr03;
	private String toolStdStr04;
	private String toolStdStr05;

	private List<ToolCompMgtDto> childCompMgtList;
	
	
	private List<MsgViewModel> msgList;	
}
