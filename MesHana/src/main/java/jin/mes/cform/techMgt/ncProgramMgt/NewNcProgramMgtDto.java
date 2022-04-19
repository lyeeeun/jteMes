package jin.mes.cform.techMgt.ncProgramMgt;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewNcProgramMgtDto extends BaseVo{
	
	private static final long serialVersionUID = 4712507605815362596L;
	
	/*** 프로젝트 포함 품목의 Routing 정보 ***/
	
	private String orderId;
	
	private String itemId;
	
	private String itemNm;
	
	private String routingId;
	
	private String routingType;
	
	private int routingSeq;
	
	private int cycleTime;
	
	private int setupTime;
	
	private int inspectTime;
	
	/*** NC Program 정보 ***/
	
	private String ncpgmId;
	
	private String ncpgmNo;
	
	private String ncpgmRevNo;
	
	private String eqmtMgtId;
	
	private String eqmtMgtNm;
	
	private String reqUser;
	
	private String reqUserNm;
	
	private String manager;
	
	private String managerNm;
	
	private String approveStat;
	
	private String rejectRemark;
	
	private boolean isUse;
	
	/*** 이거 원래 base에 있지 않았나... ***/
	
	private String createdAt;
	
	private String creatorId;
	
	private String updatedAt;
	
	private String updatorId;
	
	
	/*** 첨부 파일 ***/
	
	private List<AttachMgtDto> insertAttach;
	
	private List<AttachMgtDto> deleteAttach;

}
