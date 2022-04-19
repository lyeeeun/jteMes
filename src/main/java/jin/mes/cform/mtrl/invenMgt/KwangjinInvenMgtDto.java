package jin.mes.cform.mtrl.invenMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinInvenMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -7260027713579229002L;

	private int firstIndex;
	private int lastIndex;
	
	
	private String itemId;
	private String itemNm;
	private String itemType;
	private int itemPrice;
	private int itemPersonCost;
	private float itemStd01;
	private float itemStd02;
	private float itemStd03;
	private float itemStd04;
	private float itemStd05;
	private String itemStdStr01;
	private String itemStdStr02;
	private String itemStdStr03;
	private String itemStdStr04;
	private String itemStdStr05;
	private String itemDesc;
	
	private String itemMgtId;
	private String itemMgtType;
	private String itemMfgDate;
	private int itemStock;
	private int itemPackageStock;
	private String description;
	private String itemMgtDesc;
	private String createdAt;
	private String creatorId;
	private String updatedAt;
	private String updatorId;
	private boolean isDel;
	
	private String itemQtyTarget;
	private String itemQtyTargetCode;
	private int itemQtyTotal;
	private String itemQtyDesc;
	private String itemQtyPgCd;
	private String itemQtyDate;
	private String itemQtyUser; 
	private String itemQtyUserNm;
	
	
	private String mtrlMgtId;
	private String mtrlMgtPurchase;
	private String mtrlMgtPrescription;
	private int mtrlMgtCnt;
	private int mtrlMgtScrap;
	private String mtrlMgtDesc;

	//자재마스터
	private String mtrlId;
	private String mtrlNm;
	private String mtrlDiv;
	private String mtrlType;
	private String mtrlHCD;
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
	private boolean isUse; 
	private String mtrlDesc;
	
	private String selectTarget;
}
