package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.List;

import jin.mes.common.msg.MsgViewModel;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewMtrlInfoDto  extends BaseVo {/**
	 * 
	 */
	private static final long serialVersionUID = -2958704761046212412L;

	private String mtrlId; 
	private String mtrlDesc; 
	private String mtrlNm; 
	private String mtrlType;
	private String mtrlHCD;
	private float mtrlStd01; 
	private float mtrlStd02; 
	private float mtrlStd03; 
	private String mtrlStd04;
	private float mtrlStd05;
	private String mtrlStdStr01; 
	private String mtrlStdStr02; 
	private String mtrlStdStr03; 
	private String mtrlStdStr04;
	private String mtrlStdStr05;
	private int mtrlUseday; 
	private int mtrlCost; 
	private String createdAt; 
	private String updatedAt; 
	private String creatorId; 
	private String updatorId; 
	private String mtrlDiv; 
	private boolean isUse; 
	private String mtrlQual; 
	private String mtrlUnit;
	private String description;
	
	private List<MsgViewModel> msgList;	
}
