package jin.mes.cform.qualMgt.inputQualMgt;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

import jin.mes.form.qualMgt.qualCheckList.QualCheckListDto;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinInputQualMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 1718511844707342363L;
	
	//자재정보
	private String mtrlId;
	private String mtrlNm;
	private String mtrlType;
	private String mtrlStd01;
	private String mtrlStd02;
	private String mtrlStd03;
	private String mtrlStd04;
	private String mtrlStd05;
	private String mtrlStdStr01;
	private String mtrlStdStr02;
	private String mtrlStdStr03;
	private String mtrlStdStr04;
	private String mtrlStdStr05;
	private String mtrlCost;
	private String createdAt;
	private String updatedAt;
	private String creatorId;
	private String updatorId;
	private String mtrlDesc;
	private String isUse;
	
	//자재관리정보
	private String mtrlMgtId;
	private String mtrlMgtPurchase;
	private String mtrlMgtPrescription;
	private int mtrlMgtCnt;
	private int mtrlMgtScrap;
	private String description;
	private String isDel;
	private String lotId;
	
	//자재수량정보
	private String mtrlQtyTarget;
	private String mtrlQtyTargetCode;
	private int mtrlQtyTotal;
	private String mtrlQtyDesc;
	private String mtrlQtyPgCd;
	private String mtrlQtyPgNm;
	private String mtrlQtyDate;
	private String mtrlQtyUser;
	private String mtrlQtyUserNm;
	private String mtrlInspect;
	
	
	//불량정보
	private String badId;
	private String badCode;
	private int	badQty;
	private String chkUser;
	private String chkUserNm;
	private String chkDate;
	private String badTarget;
	private String badTargetCode;
	private String badTargetNm;
	private String badDesc;
	private String badPgUser;
	private String badPgUserNm;
	private String badPgDate;
	private String badPgCd;
	private String badPgNm;
	private String badFile;

	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;
}
