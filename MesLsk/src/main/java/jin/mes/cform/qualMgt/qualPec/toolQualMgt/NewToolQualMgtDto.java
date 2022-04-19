package jin.mes.cform.qualMgt.qualPec.toolQualMgt;

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
public class NewToolQualMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -35429912271129479L;

	private String itemId;
	
	private String itemNm;
	
	private String placeId;
	
	private String placeNm;
	
	private String eqmtMgtId;
	
	private String eqmtMgtNm;
	
	private String toolMgtId;
	
	private String inspectStandard;
	
	private int toolChange;
	
	private String questionId;
	
	private String toolInspId;
	
	private String stateValue;
	
	private float beforeValue;
	
	private float afterValue;
	
	private String inspectDate;
	
	private String inspectorId;
	
	private String inspectorNm;

	private List<NewToolQualMgtDto> toolInspectList;
	
}
