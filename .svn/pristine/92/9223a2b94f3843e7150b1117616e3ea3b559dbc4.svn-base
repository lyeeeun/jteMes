package jin.mes.form.basMgt.routing.routingMgt;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class RoutingMgtDto  extends BaseVo {
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
	
	//예비 1~5 x2
	private float routingMgtStd01;
	private float routingMgtStd02;
	private float routingMgtStd03;
	private float routingMgtStd04;
	private float routingMgtStd05;
	private String routingMgtStdStr01;
	private String routingMgtStdStr02;
	private String routingMgtStdStr03;
	private String routingMgtStdStr04;
	private String routingMgtStdStr05;
	
	
	// NC Program No(확장)
	private String ncpgmNo;
	
	
	// 관련 Bom 리스트(Select, Insert, Update)
	private List<BomMgtDto> bomList;
	// 관련 Bom 리스트(Delete)
	private List<BomMgtDto> delBomList;

	private List<BomMgtDto> childBomList;
	private List<FacilMgtDto> childEqmtList;
	private List<RoutingRtlToolDto> childToolList;
	
	// 관련 공구 리스트(Select, Insert)
	private List<RoutingRtlToolDto> toolList;
	// 관련 공구 리스트(Update)
	private List<RoutingRtlToolDto> updateToolList;
	// 관련 공구 리스트(Delete)
	private List<RoutingRtlToolDto> delToolList;
	
	//첨부파일
	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;
}
