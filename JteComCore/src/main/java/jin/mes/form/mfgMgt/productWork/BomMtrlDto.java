package jin.mes.form.mfgMgt.productWork;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BomMtrlDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = 4093989867371595325L;
	private String bomId;
	private String bomTarget;
	private String bomTargetId;  
	private String mtrlNm;
	private int mtrlMgtCnt;
	private int mtrlQtyTotal; 
	private int lvl;
	private String prodWorkId;
	private String prodAsmId;
	private String itemId;

	private String mtrlMgtId;
	private String mtrlQtyTarget;
	private String mtrlQtyTargetCode;
	private String lotId;
	
	private String mtrlId;
	private String mtrlQtyDesc;
	private String mtrlQtyPgCd;
	private String mtrlQtyPgNm;
	private String mtrlQtyDate;
	private String mtrlQtyUser;
	private String mtrlQtyUserNm;
	
	private String routingId;
	private String routingSeq;
}
