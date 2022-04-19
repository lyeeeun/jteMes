package jin.mes.form.basMgt.operMgt.compMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompMgtDto  extends BaseVo {/**
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
	
	private List<MsgViewModel> msgList;
	
	//rtl field
	private String mtrlId;
	private String toolId;
}
