package jin.mes.form.perform.facilStaMgt.performEquipment;

import java.math.BigDecimal;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PerformEquipmentDto extends BaseVo{
	
	private static final long serialVersionUID = -7223763972842869911L;

	//설비 ID
	private String eqmtMgtId;
	//설비 명
	private String eqmtMgtNm;
	//
	private String lotId;
	//품목 명
	private String itemNm;
	//
	private String routingId;
	//
	private String prodAsmNm;
	//
	private String prodAsmDate;
	//
	private String prodAsmId;
	//
	private String prodWorkStart;
	//전체 지시 수량
	private int prodWorkQty;
	//전체 생산 수량
	private int prodWorkGood;
	//전체 불량 수
	private int prodWorkBad;
	//달성율(전체 생산 수량/전체 지시 수량)
	private float prodWorkRate;
	//불량율(전체 불량 수/전체 지시 수량)
	private float prodDefectRate;
	//상태(RUN/STOP)
	private String prodWorkStatus;
	//작업자
	private String prodWorkUser;
	//기간 검색
	private String startDt;
	private String endDt;
}
