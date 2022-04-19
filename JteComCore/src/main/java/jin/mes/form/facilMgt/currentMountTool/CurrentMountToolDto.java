package jin.mes.form.facilMgt.currentMountTool;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CurrentMountToolDto extends BaseVo{
	private static final long serialVersionUID = -7223763972842869911L;

	private String eqmtMgtId;
	private String eqmtMgtGbn;
	private int eqmtMgtMtnc;
	private String eqmtMgtNm;
	private String eqmtMgtPurchase;
	private String eqmtMgtVerif;
	private String eqmtMgtDesc;
	private String eqmtMgtFile;
	private boolean isUse;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String placeId;
	private String placeNm;
	private String compId;
	private String compNm;
	private int dayTarget;
	
	//첨부파일
	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;
	
	//예비
	private float eqmtMgtStd01;
	private float eqmtMgtStd02;
	private float eqmtMgtStd03;
	private float eqmtMgtStd04;
	private float eqmtMgtStd05;
	private String eqmtMgtStdStr01;
	private String eqmtMgtStdStr02;
	private String eqmtMgtStdStr03;
	private String eqmtMgtStdStr04;
	private String eqmtMgtStdStr05;
	
	private String toolId; 

	private List<MountDto> childToolList;
}

