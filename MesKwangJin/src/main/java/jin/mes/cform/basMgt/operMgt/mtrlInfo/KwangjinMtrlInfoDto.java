package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinMtrlInfoDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -2958704761046212412L;

	private String mtrlId; 
	private String mtrlDesc; 
	private String mtrlNm; 
	private String mtrlType;
	private String mtrlHCD;
	private int mtrlCost; 
	private String createdAt; 
	private String updatedAt; 
	private String creatorId; 
	private String updatorId; 
	private String mtrlDiv; 
	private boolean isUse; 
	private String description;
	private String compId;
	private String compNm;
	private String compStdStr02;
	private String compNumber;
	private String itemId;
	
	private List<KwangjinCompMgtDto> childCompList;
	
	//예비
	private float mtrlStd01; 
	private float mtrlStd02; 
	private float mtrlStd03; 
	private float mtrlStd04;
	private float mtrlStd05;
	private String mtrlStdStr01; 
	private String mtrlStdStr02; 
	private String mtrlStdStr03; 
	private String mtrlStdStr04;
	private String mtrlStdStr05;	
	private List<MsgViewModel> msgList;	
	
	//자재 개별 재고량
	private float mtrlMgtCnt;
	private String mtrlMgtId;
}
