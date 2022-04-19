package jin.mes.form.facilMgt.currentMountTool;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MountDto extends BaseVo{
	private static final long serialVersionUID = -7223763972842869911L;


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
	
	private String eqmtMgtId;
}
