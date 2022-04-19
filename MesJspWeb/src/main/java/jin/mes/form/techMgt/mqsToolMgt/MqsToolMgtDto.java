package jin.mes.form.techMgt.mqsToolMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MqsToolMgtDto extends BaseVo{
	private static final long serialVersionUID = 8158422120694342170L;
	
	/*** Routing 정보 ***/
	private String itemId;
	
	private String itemNm;
	
	private String routingId;
	
	private int routingSeq;
	
	private String routingType;
	
	private int manHour;
	
	private String description;
	
	private String ncpgmNo;
	
	private int cycleTime;
	
	private int setupTime;
	
	private int inspectTime;
	
	/*** 관련 공구 정보 ***/
	private String toolNo;
	
	private String toolId;
	
	private String toolNm;
	
	private String toolDc;
	
	private String holderId;
	
	private String holderNm;
	
	private String holderDc;
	
	private int insertQty;
	
	private String insertDc;
	
	private int cornerQty;
	
	private float toolTLengthU;
	
	private float toolTLengthL;
	
	private float toolWlengthU;
	
	private float toolWlengthL;
	
	private float toolDia;
	
	private int toolChange;
	
	private String offsetH;
	
	private String offsetD;
	
	private String specialDc;
	
	private String specialPic;
	
}
