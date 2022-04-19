package jin.mes.cform.mtrl.invenMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class KwangjinInvenHisDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -6603586253138827269L;

	private String itemId;
	private String itemNm;
	private String itemMgtId;
	
	private String itemQtyTarget;
	private String itemQtyTargetCode;
	private int itemQtyTotal;
	private String itemQtyDesc;
	private String itemQtyPgCd;
	private String itemQtyDate;
	private String itemQtyUser; 
	private String itemQtyUserNm;

	
	private String mtrlId;
	private String mtrlNm;
	private String mtrlMgtId;
	
	private String mtrlQtyTarget;
	private String mtrlQtyTargetCode;
	private int mtrlQtyTotal;
	private String mtrlQtyDesc;
	private String mtrlQtyPgCd;
	private String mtrlQtyPgNm;
	private String mtrlQtyDate;
	private String mtrlQtyUser;
	private String mtrlQtyUserNm;
	
	
	private int firstIndex;
	private int lastIndex;
	private String createdAt;
	private String creatorId;
	private String updatedAt;
	private String updatorId;
	private String selectTarget;
	
}
