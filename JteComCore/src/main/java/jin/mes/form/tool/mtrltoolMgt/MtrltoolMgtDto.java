package jin.mes.form.tool.mtrltoolMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class MtrltoolMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -35429912271129479L;

	//사용이력
	public MtrltoolMgtDto(String prodWorkId,String toolId, String toolMgtId, String eqmtMgtId, String eqipPosition, String lotId, int toolUseQty, String toolUseStart, String toolUseEnd, String toolUseDesc) {
		this.prodWorkId = prodWorkId;
		this.toolId = toolId;
		this.toolMgtId = toolMgtId;
		this.eqmtMgtId = eqmtMgtId;
		this.eqipPosition = eqipPosition;
		this.lotId = lotId;
		this.toolUseQty = toolUseQty;
		this.toolUseStart = toolUseStart;
		this.toolUseEnd = toolUseEnd;
		this.toolUseDesc = toolUseDesc;
	}
	
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

	//공구정비이력
	private String toolMtncId;
	private String toolMtncStart;
	private String toolMtncEnd;
	private String toolMtncUser;
	private int toolMtncCost;
	private String toolMtncDesc;
	private String toolMtncUserNm;
	
	//공구 사용정보
	private int toolUseQty;
	private String toolUseStart;
	private String toolUseEnd;
	private String toolUseDesc;
	private String prodWorkId;
	private String lotId;
	
	//설비 공구 장착 상태
	private String eqmtMgtId;
	private String eqipId;
	private String eqipNm;
	private String eqipPosition;
	
	//품목-공구-설비
	private String itemId;
	private String eqmtId;

	//공통
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	//다국어
	private List<MsgViewModel> msgList;
	
	//Alarm 발송 기준 (검증기간)
	private int pInterval;
}