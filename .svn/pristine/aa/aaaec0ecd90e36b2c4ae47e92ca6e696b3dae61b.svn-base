package jin.mes.cform.basMgt.operMgt.processInfo;

import java.util.List;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.facilMgt.facilCorMgt.FacilCorMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewProcessInfoDto extends BaseVo{
	private static final long serialVersionUID = -7223763972842869911L;
	/** row number */
	String rownum;
	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	// 공정 ID
	private String processId;
	// 공정 명
	private String processNm;
	// 공정 
	private String processType;
	// 제품 제조(생산) 인건비
	private Boolean isUse;
	// 제품 단가
	private String description;
	// 생성일시
	private String createdAt;
	// 수정일시
	private String updatedAt;
	// 생성자 ID
	private String creatorId;
	// 수정자 ID
	private String updatorId;
	// 관련 설비 ID
	private String eqmtMgtId;
	// 관련 설비 명
	private String eqmtMgtNm;
	
	private String eqmtMgtPurchase;
	
	private String eqmtMgtVerif;
	
	private String eqmtMgtDesc;
	
	private String placeId;
	
	// 관련 설비 리스트(Insert, Update)
	private List<FacilCorMgtDto> rtlEqmtMgtList;
	
	// 관련 설비 리스트(Delete)
	private List<FacilCorMgtDto> delRtlEqmtMgtList;
	
}
