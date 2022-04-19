package jin.mes.cform.qualMgt.toolQualMgt;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class KwangjinToolQualMgtDto extends BaseVo{
	
	private static final long serialVersionUID = -35429912271129479L;
	
	//공구관리
	private String toolMgtId;
	private String toolMgtGbn;
	private String toolMgtDesc;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String compId;
	private String compNm;
	private String compStdStr02;
	private String compNumber;
	private String isDel;
	
	//공구정보
	private String toolId;
	private String toolNm;
	private String toolType;
	private int toolPrice;
	private int toolLimit;
	private String toolDesc;
	private String isUse;
	
	//검사항목
	private String inspectId;
	private String questionId;
	private String questionValue;
	private String targetId;
	private String inspectDate;
	private String inspectorId;
	private String inspectorNm;
	private String category;
	
}
