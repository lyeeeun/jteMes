package jin.mes.form.basMgt.codMgt.popSet;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PopSetDto extends BaseVo {
	
	private static final long serialVersionUID = -3132443043964158946L;
	
	private String popId;
	private String popNm;
	private String popType;
	private int popWidth;
	private int popHeight;
	private String popUrl;
	private String popTemplate;
	private String popFormat;
	private String popUse;
	private int popNum;
	private String popSearchUse;
	private String popSearchValue;
	private String popDynamicUse;
	private String popDynamicValue;
	private String upPopId;

	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	
	private List<PopSetDto> popFieldList;
}
