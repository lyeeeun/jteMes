package jin.mes.cform.qualMgt.infergodsMgt;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinInfergodsMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 3576955479878072423L;
	
	private String badId;
	private String badCode;
	private int badQty;
	private String badFile;
	private String chkUser;
	private String chkDate;
	private String badTarget;
	private String badTargetCode;
	private String badDesc;
	private String lotId;
	private String lotState;
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
	//자재
	private String mtrlId;
	private String mtrlNm;
	private String mtrlMgtId;
	private String mtrlDiv;
	private String mtrlOrderId;
	private String controlNo;
	private String badPrimId;
	//품목
	private String itemId;
	private String itemNm;
	//설비
	private String eqmtMgtId;
	private String eqmtMgtNm;
	//작업자
	private String userId;
	private String userNm;
	
	//불량율 집계(품목, 자재, 설비, 작업자)
	private String selectTarget;
	private int totalQty;
	private int totalBadQty;
	private float totalBadRate;
	
	//첨부파일
	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;
}
