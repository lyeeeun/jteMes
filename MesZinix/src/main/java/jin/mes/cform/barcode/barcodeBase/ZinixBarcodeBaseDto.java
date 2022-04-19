package jin.mes.cform.barcode.barcodeBase;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixBarcodeBaseDto extends BaseVo{
	
	private static final long serialVersionUID = -2254707945352809903L;
	
	private String barcodeId; 
	private String lotId;
	private String lotNm;
	private int lotSeq;
	private String lotState;
	private String orderId;
	private String orderNm;
	private String itemId; 
	private String itemNm;
	private String itemStdStr01;
	private String itemStdStr02;
	private String itemStdStr03;
	private String itemStdStr04;
	private String itemStdStr05;
	private String itemStdStr06;
	private String itemUnit;
	private String itemMtrl;
	private String prodAsmId; 
	private String plcEqmtId; 
	private String packageId; 
	private String shipId; 
	private String createdAt; 
	private String creatorId;
	private String updatedAt; 
	private String updatorId;
}
