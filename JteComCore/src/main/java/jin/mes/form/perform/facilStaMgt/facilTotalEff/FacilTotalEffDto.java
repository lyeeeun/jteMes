package jin.mes.form.perform.facilStaMgt.facilTotalEff;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class FacilTotalEffDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;

	//설비상세
	private String eqmtMgtId;
	private String eqmtMgtGbn;
	private int eqmtMgtMtnc;
	private String eqmtMgtNm;
	private String eqmtMgtDesc;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String placeId;
	
	private String compId;
	

	//가동이력
	private String eqmtWorkStart;
	private String eqmtWorkEnd;
	private String runTime;
	private float eqmtPercent;
	private String prodWorkId;
	
	
	private String eqmtWorkTotal;
	private String eqmtWorkTemp;
	
	//Alarm 발송 기준 (검증기간)
	private int pInterval;
	
}
