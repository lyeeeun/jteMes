package jin.mes.cform.facilMgt.facilCorMgt;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewFacilCorMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -4392718298756672432L;

	//설비상세
	private String eqmtMgtId;
	private String eqmtMgtNm;
	private String eqmtMgtPurchase;
	private String eqmtMgtVerif;
	private String eqmtMgtDesc;
	private boolean isUse;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String placeId;
	
	//설비마스터
	private String eqmtId;
	private String eqmtNm;
	private String eqmtGbn;
	private int eqmtMaintenance;
	private String eqmtFile;
	private String compId;
	
	//정비이력
	private String eqmtMtncId;
	private String eqmtMtncStart;
	private String eqmtMtncEnd;
	private String eqmtMtncUser;
	private int eqmtMtncCost;
	private String eqmtMtncDesc;
	private String eqmtMtncUserNm;

	//가동이력
	private String eqmtWorkStart;
	private String eqmtWorkEnd;
	private String runTime;
	private float eqmtPercent;
	private String prodWorkId;
	
	
	private String eqmtWorkTotal;
	private String eqmtWorkTemp;
	
	//다국어
	private List<MsgViewModel> msgList;
}
