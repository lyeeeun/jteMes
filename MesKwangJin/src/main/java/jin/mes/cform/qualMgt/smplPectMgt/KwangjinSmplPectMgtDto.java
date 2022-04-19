package jin.mes.cform.qualMgt.smplPectMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinSmplPectMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 5094545477879116880L;

	
	private String prodAsmId;
	private String prodAsmNm;
	private String prodAsmDate;
	private int prodAsmQty;
	private String prodAsmDesc;
	private String prodAsmUser;
	private String prodAsmState;
	private String routingId;
	private String routingSeq;
	private String routingType;
	private String eqmtMgtId;
	private String eqmtMgtNm;
	private String bomId;
	private String bomNm;
	private String bomTarget;
	private String bomTargetCnt;
	private String prodWorkId;
	private String prodWorkUser;
	private String prodWorkUserNm;
	private int prodWorkQty;
	private int prodWorkGood;
	private int prodWorkBad;
	private String prodWorkStart;
	private String prodWorkEnd;
	private String prodWorkStatus;
	
	private String orderId;
	private String lotId;
	private String lotNm;
	private String lotType;
	private int lotQty;
	private int lotOriginalQty;
	private String lotPm;
	private String lotPmNm;
	private String lotState;
	private String createdAt;
	private String creatorId;
	private String updatedAt;
	private String updatorId;
	private String itemId;
	private String itemNm;
	private String itemMgtId;
	
	private String badId;
	private String badCode;
	private int badQty;
	private String badFile;
	private String chkUser;
	private String chkDate;
	private String badTarget;
	private String badTargetCode;
	private String badDesc;
	private int itemBadTotal;
	private String searchStartDate;
	private String searchEndDate;
	
	//타프로그램 연결
	private String badTargetNm;
	private String chkUserNm;
	private String badPgCd;
	private String badPgNm;
	private String badPgUser;
	private String badPgUserNm;
	private String badPgDate;
}
