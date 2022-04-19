package jin.mes.form.tool.toolMainRecord;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ToolMainRecordDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;

	//공구정보
	private String toolId;
	private String toolNm;
	//공구관리
	private String toolMgtId;
	private String toolMgtPurchase;
	private String toolMgtState;
	private int toolMgtLimit;
	private int toolMgtUse;
	private String toolMgtVerif;
	private String toolMgtGbn;
	private String toolMgtDesc;
	private String compId;
	private String compNm;

	//공구정비이력
	private String toolMtncId;
	private String toolMtncStart;
	private String toolMtncEnd;
	private String toolMtncUser;
	private int toolMtncCost;
	private String toolMtncDesc;
	private String toolMtncUserNm;
	
	//공통
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
}
