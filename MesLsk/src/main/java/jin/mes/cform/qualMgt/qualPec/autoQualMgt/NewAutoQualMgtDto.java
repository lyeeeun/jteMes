package jin.mes.cform.qualMgt.qualPec.autoQualMgt;

import java.util.List;

import jin.mes.cform.qualMgt.qualCheckList.NewQualCheckListDto;
import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class NewAutoQualMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -35429912271129479L;

	private String itemId;
	
	private String itemNm;
	
	private String inspDate;
	
	private float innerDia;
	
	private float outerDia;
	
	private float externalDia;
	
	private float electricPart;
	
	private float distance;
	
	private Boolean passYn;
	
}
