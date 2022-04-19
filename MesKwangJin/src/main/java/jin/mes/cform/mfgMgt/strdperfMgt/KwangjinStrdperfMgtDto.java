package jin.mes.cform.mfgMgt.strdperfMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinStrdperfMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -576586822859793480L;
	
	private String orderId;
	private String orderNm;
	private String lotId;
	private String lotNm;
	private int lotQty;
	private String itemId;
	private String itemNm;
	private String routingId;
	private String routingType;
	private int routingSeq;
	private String pordWorkId;
	private String prodWorkUser;
	private String prodWorkUserNm;
	private String prodWorkStart;
	private String prodWorkEnd;
	private int prodWorkQty;
	private int prodWorkGood;
	private int prodWorkBad;
	private String eqmtMgtId;
	private String eqmtMgtNm;
	private String placeId;
	private String placeNm;
	private float baseHour;
	private float realTime;

	private String prodAsmId;
	private String prodAsmNm;
	private String prodAsmDate;
	private int prodAsmQty;
	private String prodAsmDesc;
	private String prodAsmType;
	private String prodAsmUser;
	private String prodAsmUserNm;
	private String prodAsmState;
	private String createdAt;
	private String creatorId;
	
	private String lotType;
	private String lotState;
	private String updatedAt;
	private String updatorId;
	
}
