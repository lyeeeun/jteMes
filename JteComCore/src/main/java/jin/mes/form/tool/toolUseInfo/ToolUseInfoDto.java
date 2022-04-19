package jin.mes.form.tool.toolUseInfo;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ToolUseInfoDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;

	//공구정보
	private String toolId;
	private String toolNm;
	private String toolType;
	private int toolPrice;
	private int toolLimit;
	private String toolDesc;
	private boolean isUse;
	private boolean isDel;
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

	//공구 사용정보
	private int toolUseQty;
	private String toolUseStart;
	private String toolUseEnd;
	private String toolUseDesc;
	private String prodWorkId;
	private String lotId;

	//공통
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
}
