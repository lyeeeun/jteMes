package jin.mes.common.excelUtil;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class ExcelUtilDto  extends BaseVo {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -101577993640386400L;
	
	private String mode;
	
	private String menuId;
	 
	private String tableId;
	
	private String columnId;
	
	private String columnNm;
	
	private String columnType;
	
	private boolean autoKeyYn;
	
	private String autoKey;
	
	private boolean listYn;
	
	private String cdId;
	
	private String cdNm;
	
	private boolean rtlTableYn;
	
	private String rtlTableId;
	
	private String rtlTablePk;
	
	private String rtlTablePkNm;

	private int order;
	
	private boolean checkYn;
	
	private List<ExcelUtilDto> columnList;
	
	private List<ExcelUtilDto> valueList;
	
	private String stringValue;
	
	private int intValue;
	
	private double floatValue;
	
	private boolean nullAble;
	
	private boolean rtlSystemYn;
	
	private String rtlSystemSvc;
	
	private String rtlSystemMethod;
	
	
	private String orderId;
	private String slipNum;
	private String orderNm;
	private String orderManager;
	private String orderStdt;
	private String orderEddt;
	private String createdAt;
	private String creatorId;
	private String updatedAt;
	private String updatorId;
	private String description;
	private String orderState;
	private int lotQty;
	private String itemId;
	private String itemNm;
	private float itemStdStr01;
	private float itemStdStr02;
	private String compId;
	private String compNm;
	private float compStdStr02;
	private int shipQty;
	
	
}
