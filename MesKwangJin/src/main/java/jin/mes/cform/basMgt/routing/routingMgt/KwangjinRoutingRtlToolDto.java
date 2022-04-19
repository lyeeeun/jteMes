package jin.mes.cform.basMgt.routing.routingMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinRoutingRtlToolDto  extends BaseVo {
	private static final long serialVersionUID = 2147148364430472709L;
	
	// Routing ID
	private String routingId;
	// Tool ID
	private String toolId;
	// Tool RPM
	private int toolRpm;
	// Tool 위치
	private String toolLocation;
	// Tool 사용 횟수
	private float toolCount;
	
	//공구정보
	private String toolNm;
	private String toolType;
	private int toolPrice;
	private int toolLimit;
	private String toolDesc;
}
