package jin.mes.cform.perform.performEquipment;

import java.math.BigDecimal;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewPerformEquipmentDto extends BaseVo{
	
	private static final long serialVersionUID = -7223763972842869911L;

	//위치 ID
	private String placeId;
	//위치명
	private String placeNm;
	//부모 위치코드
	private String placeParent;
	//설비 ID
	private String eqmtMgtId;
	//설비 명
	private String eqmtMgtNm;
	//품목 명
	private String itemNm;
	//전체 지시 수량
	private int totalTarget;
	//전체 생산 수량
	private int totalOutput;
	//전체 불량 수
	private int totalDefect;
	//달성율(전체 생산 수량/전체 지시 수량)
	private float eqmtAchieveRate;
	//불량율(전체 불량 수/전체 지시 수량)
	private float eqmtDefectRate;
	//상태(RUN/STOP)
	private String eqmtStatus;
	//작업자
	private String workUser;
	//기간 검색
	private String startDt;
	private String endDt;
}
