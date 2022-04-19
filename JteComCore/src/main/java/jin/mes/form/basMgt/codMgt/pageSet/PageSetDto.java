package jin.mes.form.basMgt.codMgt.pageSet;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PageSetDto extends BaseVo {
	private static final long serialVersionUID = 2084247198487342065L;
	
	//그리드설정
	private String gridNo;
	private String gridDb;
	private String gridId;
	private String gridClass;
	private String gridStyle;
	private String gridTitle;
	private String gridUrlBase;
	private String gridUrlRead;
	private String gridUrlCreate;
	private String gridUrlUpdate;
	private String gridUrlDestroy;
	private String gridPopId;
	private int gridPopWidth;
	private int gridPopHeight;
	private String gridPopClass;
	private String gridPopCol;
	private String gridPopTitle;
	private String gridFunction;
	private String gridDiv;
	private String upGridId;
	private String menuId;
	
	private String copyMenuId;
	
	//필드 설정
	private String fieldNo;
	private String fieldDb;
	private String fieldId;
	private String fieldName;
	private String fieldType;	
	
 
	private String fieldPop; 
	private String fieldGrid;
	private String fieldSearch;
	private String fieldValidation;
	private String fieldExcel;


	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	
	private List<PageSetDto> pageFieldList;
}
