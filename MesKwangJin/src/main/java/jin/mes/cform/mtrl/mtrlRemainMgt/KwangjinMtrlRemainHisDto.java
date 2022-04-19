package jin.mes.cform.mtrl.mtrlRemainMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinMtrlRemainHisDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -7260027713579229002L;

	
	//자재관리
	private String mtrlMgtId;
	private String mtrlMgtPurchase;
	private String mtrlMgtPrescription;
	private int mtrlMgtCnt;
	private int mtrlMgtScrap;
	private String mtrlMgtDesc;
	private boolean isDel;
	//자재마스터
	private String mtrlId;
	private String mtrlNm;
	private String mtrlDiv;
	private String mtrlType;
	private float mtrlStd01; 
	private float mtrlStd02; 
	private float mtrlStd03; 
	private String mtrlStd04;
	private float mtrlStd05;
	private String mtrlStdStr01; 
	private String mtrlStdStr02; 
	private String mtrlStdStr03; 
	private String mtrlStdStr04;
	private String mtrlStdStr05;
	private int mtrlCost; 
	private String description;
	private boolean isUse; 
	private String mtrlDesc;
	
	private String remainQtyUser;
	private String remainQtyUserNm;
	private String remainQtyTarget;
	private String remainQtyTargetCode;
	private int remainQtyTotal;
	private String remainQtyDate; 
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	
	private String remainQtyDesc;
	private String remainQtyPgCd;
	private String remainQtyPgNm;
	
}
