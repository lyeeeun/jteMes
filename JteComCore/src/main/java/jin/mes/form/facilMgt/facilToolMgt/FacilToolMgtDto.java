package jin.mes.form.facilMgt.facilToolMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class FacilToolMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -7224933457364209129L;
		//공구장착상태
		private String eqmtMgtId;
		private String eqmtMgtNm;
		private String eqipId;
		private String eqipNm;
		private String eqipPosition;
		private String creatorId;
		private String createdAt;
		private String updatorId;
		private String updatedAt;
		private boolean	isDel;
		private String toolMgtId;
		
		//궁구관리
		private String toolId;
		private String toolNm;
		private String toolMgtPurchase;
		private String toolMgtState;
		private int toolMgtLimit;
		private int toolMgtUse;
		private String toolMgtVerif;
		private String toolMgtGbn;
		private String toolMgtDesc;
		private String compId;
		private String compNm;
		
		
		//공구 장착정보
		// Tool RPM
		private int toolRpm;
		// Tool 위치
		private String toolLocation;
		// Tool 사용 횟수
		private float toolCount;
		private String itemId;
		private String itemNm;
		private String routingId;
		private String routingType;
		private String eqipState;
		
		//작업정보
		private String prodWorkId;
		private String prodWorkStart;
		private String prodWorkEnd;
		private String prodWorkDesc;
		private String lotId;
		private int toolUseQty;
		private String historyYN;
		
}
