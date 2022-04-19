package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import jin.mes.cform.basMgt.bom.bomMgt.NewBomMgtDto;
import jin.mes.cform.basMgt.operMgt.facilMgt.NewFacilMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewRoutingMgtDto  extends BaseVo {
	private static final long serialVersionUID = 2147148364430472709L;
	
	// Routing ID
	private String routingId;
	// Routing 순서(차수)
	private int routingSeq;
	// 공정(기초코드)
	private String routingType;
	// 작업 시간(공수)
	private int manHour;
	// 비고
	private String description;
	// 생성일시
	private String createdAt;
	// 생성자 ID
	private String creatorId;
	// 수정일시
	private String updatedAt;
	// 수정자 ID
	private String updatorId;
	// 공정 ID
	private String processId;
	// 공정 명
	private String processNm;
	// 품목 ID
	private String itemId;
	// 관련 설비 ID
	private String eqmtMgtId;
	
	// NC Program No(확장)
	private String ncpgmNo;
	// Cycle Time(확장)
	private int cycleTime;
	// Setup Time(확장)
	private int setupTime;
	//inspect Time(확장)
	private int inspectTime;
	
	
	// 관련 Bom 리스트(Select, Insert, Update)
	private List<NewBomMgtDto> bomList;
	// 관련 Bom 리스트(Delete)
	private List<NewBomMgtDto> delBomList;
	// 관련 설비 리스트(Select, Insert, Update)
	private List<NewFacilMgtDto> eqmtMgtList;
	// 관련 설비 리스트(Delete)
	private List<NewFacilMgtDto> delEqmtMgtList;
	// 관련 설비 Default Value
	private String defaultEqmtMgtId;
	// 관련 공구 리스트(Select, Insert)
	private List<NewRoutingRtlToolDto> toolList;
	// 관련 공구 리스트(Update)
	private List<NewRoutingRtlToolDto> updateToolList;
	// 관련 공구 리스트(Delete)
	private List<NewRoutingRtlToolDto> delToolList;
	
	//첨부파일
	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;
}
