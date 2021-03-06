package jin.mes.cform.facilMgt.facilCorMgt;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinFacilCorMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -4392718298756672432L;

	//설비상세
	private String eqmtMgtId;
	private String eqmtMgtGbn;
	private int eqmtMgtMtnc;
	private String eqmtMgtNm;
	private String eqmtMgtPurchase;
	private String eqmtMgtVerif;
	private String eqmtMgtDesc;
	private boolean isUse;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String eqmtFile;
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
	
	//Alarm 발송 기준 (검증기간)
	private int pInterval;
	
	//첨부파일
	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;
		
	//다국어
	private List<MsgViewModel> msgList;
}
