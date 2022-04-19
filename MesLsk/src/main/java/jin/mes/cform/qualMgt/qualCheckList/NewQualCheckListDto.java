package jin.mes.cform.qualMgt.qualCheckList;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class NewQualCheckListDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -35429912271129479L;
	
	/*** 자주 검사 ***/
	private List<NewQualCheckListDto> insertInspectList;
	private List<NewQualCheckListDto> updateInspectList;
	
	private String inspectId;
	
	private String questionId;
	
	private String questionValue;
	
	private String targetId;
	
	private String inspectDate;
	
	private String inspectorId;
	
	private String inspectorNm;
	
	private String category;
	
	
}
