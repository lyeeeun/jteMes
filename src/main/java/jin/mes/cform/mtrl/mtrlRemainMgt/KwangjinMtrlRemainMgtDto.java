package jin.mes.cform.mtrl.mtrlRemainMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinMtrlRemainMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -7260027713579229002L;

	
	//자재 잔량 정보
		private String remainId;
		private String remainNm;
		private float remainWeight;
		private String remainDate;
		private String remainUser;
		private String remainUserNm;
		private String remainDesc;
		private String remainDisuse;
		private String disuseDate;
		private String creatorId;
		private String createdAt;
		private String updatorId;
		private String updatedAt;
		
		private String startDate;
		private String endDate;
}
