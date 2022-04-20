package jin.mes.cform.ship.shipMgt;

import java.util.List;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixShipMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 7161704239680756321L;
	
	private String itemMgtId;
	// 출하 ID
	private String shipId;
	// 출하 상태
	private String shipState;
	// 출하 수량
	private int shipQty;
	
	private int updateShipQty;
	
	private String shipType;
	
	private String shipDesc;
	
	private String shipStartDate;
	
	private String shipCompleteDate;
	
	private String compId;
	
	private String compNm;
	
	private String compAddrId;
	
	private String compAddrDetail;
	
	private String compAddrNumber;
	
	private String barcodeId;
	
	private String serialNumber;
	
	private String lotState;
	
	private List<ZinixShipMgtDto> shipRtlBarcodeList;
	
}