package jin.mes.cform.mtrl.mtrlDisburseMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class KwangjinMtrlDisburseHisDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -6603586253138827269L;
	
	private String mtrlMgtId;
	private String mtrlQtyTarget;
	private String mtrlQtyTargetCode;
	private int mtrlQtyTotal;
	private String lotId;
	
	private String mtrlId;
	private String mtrlQtyDesc;
	private String mtrlQtyPgCd;
	private String mtrlQtyPgNm;
	private String mtrlQtyDate;
	private String mtrlQtyUser;
	private String mtrlQtyUserNm;
	
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	
	public KwangjinMtrlDisburseHisDto(String mtrlId, String mtrlQtyTarget, String mtrlQtyTargetCode, int mtrlQtyTotal, String mtrlQtyDate, String mtrlQtyUser,String mtrlMgtId, String lotId) {
		this.mtrlId = mtrlId;
		this.mtrlQtyTarget = mtrlQtyTarget;
		this.mtrlQtyTargetCode = mtrlQtyTargetCode;
		this.mtrlQtyTotal = mtrlQtyTotal;
		this.mtrlQtyDate =  mtrlQtyDate;
		this.mtrlQtyUser = mtrlQtyUser;
		this.mtrlMgtId = mtrlMgtId;
		this.lotId = lotId;
	}
}
