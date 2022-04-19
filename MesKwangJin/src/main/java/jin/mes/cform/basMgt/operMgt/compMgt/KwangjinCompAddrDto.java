package jin.mes.cform.basMgt.operMgt.compMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinCompAddrDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -7158834583000997708L;
	
	private String compId;
	private String compAddrId; 
	private String compAddrDetail; 
	private String compAddrUser;
	private String compAddrNumber; 
	private String compDesc;
	private String createdAt; 
	private String updatedAt; 
	private String creatorId; 
	private String updatorId; 
	private boolean isUse;
	
	private List<MsgViewModel> msgList;
	
}
