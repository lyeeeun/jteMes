package jin.mes.form.mfgMgt.mfgplanMgt.mrcalMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MrcalMgtDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = 3721733783277573259L;
	
	private String orderId;
	private String orderNm;
	private String lotId;
	private String lotNm;
	private String lotQty;
	private String itemId;
	private String itemNm;
	private int bomTargetCnt;
	private String mtrlId;
	private String mtrlNm;
	private String mtrlDiv;
	private String mtrlMgtId;
	private String prodWorkId;
	private String prodAsmDate;
	private String prodWorkUser;
	private String prodWorkUserNm;
	private String eqmtMgtId;
	private String eqmtMgtNm;
	private int prodWorkQty;
	private int mtrlNeedQty;
	private int mtrlUseInput;
	private int mtrlUseCnt;
	private int mtrlMgtCnt;
}
