package jin.mes.cform.orderMgt.claimMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinClaimMgtDto extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = 8579583011697189465L;
	
	private String claimId;
	private String claimNm;
	private int claimQty;
	private int claimCnt;
	private String claimState;
	private String claimDesc;
	private String claimCause;
	private String claimResult;
	private String compId;
	private String compNm;
	private String compStdStr02;
	private String compNumber;
	private String creatorId;
	private String createdAt;
	private String lotId;
	
	private String searchStartDate;
	private String searchEndDate;

}
