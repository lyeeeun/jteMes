package jin.mes.form.qualMgt.specProcMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;

public class SpecProcMgtUserDto extends BaseVo {
		
	private String spcId;
	private String userId;
	
	private List<MsgViewModel> msgList;
}
