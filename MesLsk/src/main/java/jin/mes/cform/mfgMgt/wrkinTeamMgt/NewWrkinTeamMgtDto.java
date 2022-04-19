package jin.mes.cform.mfgMgt.wrkinTeamMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
@AllArgsConstructor
public class NewWrkinTeamMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 4012687141552534795L;
	
	//일괄등록 - 생산지시용
	public NewWrkinTeamMgtDto(String prodAsmId, String prodAsmNm, String prodAsmDate, int prodAsmQty, String prodAsmDesc, String prodAsmUser, String prodAsmEmj, 
			String prodAsmState, String creatorId, String deptId, String prodPlanId, String lotId) {
		this.prodAsmId = prodAsmId;
		this.prodAsmNm = prodAsmNm;
		this.prodAsmDate = prodAsmDate;
		this.prodAsmQty = prodAsmQty;
		this.prodAsmDesc = prodAsmDesc;
		this.prodAsmUser = prodAsmUser;
		this.prodAsmEmj = prodAsmEmj;
		this.prodAsmState = prodAsmState;
		this.creatorId = creatorId;
		this.deptId = deptId;
		this.prodPlanId = prodPlanId;
		this.lotId = lotId;
	}
	//일괄등록 - 작업지시용
	public NewWrkinTeamMgtDto(String prodAsmId, String prodPlanId, String lotId, String prodWorkId, String routingId, String eqmtMgtId, String prodWorkUser, int prodWorkQty, String prodWorkDesc, String prodWorkState) {
		this.prodAsmId = prodAsmId;
		this.prodPlanId = prodPlanId;
		this.lotId = lotId;
		this.prodWorkId = prodWorkId;
		this.routingId = routingId;
		this.eqmtMgtId = eqmtMgtId;
		this.prodWorkUser = prodWorkUser;
		this.prodWorkQty = prodWorkQty;
		this.prodWorkDesc= prodWorkDesc;
		this.prodWorkState= prodWorkState;
	}

	
	private String orderId;
	private String orderNm;
	private String lotId;
	private String lotNm;
	private String lotState;
	
	private String itemId;
	private String itemNm;
	private int itemDeduction;
	private int itemDayTarget;
	private int itemTotalStock;
	private float itemStd01;
	private float itemStd02;
	private float itemStd03;
	private float itemStd04;
	private float itemStd05;
	//예비필드(Str)
	private String itemStdStr01;
	private String itemStdStr02;
	private String itemStdStr03;
	private String itemStdStr04;
	private String itemStdStr05;
	
	private String itemUnit;
	private String itemMtrl;
	
	private String prodPlanId;
	private String prodPlanType;
	private int prodPlanYear;
	private int prodPlanMonth;
	private int prodPlanDay;
	private int prodPlanQty;
	private String prodPlanDesc;
	private String prodAsmId;
	private String prodAsmNm;
	private String prodAsmDate;
	private int prodAsmQty;
	private String prodAsmDesc;
	private String prodAsmUser;
	private String prodAsmUserNm;
	private String prodAsmEmj;
	private String prodAsmState;
	
	// LSK추가
	private String prodAsmWorker;
	private float prodAsmGood;
	private float prodAsmBad;
	private String callAsmModDt;
	private float callAsmGood;
	private float callAsmBad;
	private String callAsmFinDt;
	private String[] asgnStateList;
	
	
	private String createdAt;
	private String creatorId;	
	private String deptId;	
	private String deptNm;	
	private String prodWorkId;
	private String routingId;
	private int routingSeq;
	private String routingType;
	private String bomTarget;
	private String mtrlUse;
	private String eqmtMgtId;	
	private String eqmtMgtNm;
	private String placeId;
	private String placeNm;
	private String placeParent;
	private String prodWorkUser;
	private String prodWorkUserNm;
	private int prodWorkQty;
	private int prodWorkGood;
	private int prodWorkBad;
	private String qtyAction;
	private String prodWorkStart;
	private String prodWorkEnd;
	private String prodWorkDesc;
	private String prodWorkState;
	private String[] placeType;
	
	private String mtrlMgtId;
	private String mtrlNm;
	private String mtrlDiv;
	private int mtrUseInput;
	private int mtrlUseCnt;
	
	private String planAction;
	private String workAction;
	
	private String bulkStdt;
	private String bulkEddt;
}
