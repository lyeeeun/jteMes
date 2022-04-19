package jin.mes.cform.qualMgt.specProcMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper=false)
public class NewSpecProcUserDto extends BaseVo {
		

	private static final long serialVersionUID = -4227703660740846767L;
	private String spcId;
	private String userId;
	private String userNm;
	
	private List<MsgViewModel> msgList;
}
