package jin.mes.cform.mfgMgt.wrkinWrkerMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewMtrlUseDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -1787421404591935487L;
	
	private String prodWorkId;
	private String prodWorkUser;
	private String prodWorkStart;
	private String prodWorkEnd;
	private String prodWorkDesc;
	private String bomId;
	private String mtrlId;
	private String mtrlDiv;
	private String mtrlNm;
	private String mtrlType;
	private String mtrlHCD;
	private float mtrlStd01; 
	private float mtrlStd02; 
	private float mtrlStd03; 
	private String mtrlStd04;
	private float mtrlStd05; 
	private int mtrlUseday; 
	private int mtrlCost; 
	private boolean isUse;  
	private String mtrlDesc;
	private String mtrlQual; 
	private String mtrlUnit;
	private String mtrlUseId;
	private int mtrlUseInput;
	private int mtrlUseCnt;
	private String mtrlMgtId;
	private String mtrlMgtPurchase;
	private int mtrlMgtCnt;
	private String mtrlMgtDesc;
	private String badId;
	private String badCode;
	private int badQty;
	private String chkUser;
	private String chkUserNm;
	private String chkDate;
	private String badTarget;
	private String badTargetCode;
	private String badDesc;
}
