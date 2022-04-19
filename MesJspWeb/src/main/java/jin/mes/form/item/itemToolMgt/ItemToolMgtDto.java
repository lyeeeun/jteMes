package jin.mes.form.item.itemToolMgt;

import java.util.List;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.toolMgt.ToolMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ItemToolMgtDto extends BaseVo{
	private static final long serialVersionUID = -7223763972842869911L;
	/** row number */
	//String rownum;
	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	// 품목 ID
	private String itemId;
	// 공정 ID
	private String processId;
	// 공정 명
	private String processNm;
	// 설비 ID
	private String eqmtMgtId;
	// 설비 명
	private String eqmtMgtNm;
	// 관련 공구 ID
	private String toolId;
	// 관련 공구 명
	private String toolNm;
	// 관련 공구 리스트(Insert, Update)
	private List<ToolMgtDto> toolList;
	// 관련 공구 리스트(Delete)
	private List<ToolMgtDto> delToolList;
}
