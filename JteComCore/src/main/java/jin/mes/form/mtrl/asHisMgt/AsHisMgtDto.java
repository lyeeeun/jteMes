package jin.mes.form.mtrl.asHisMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class AsHisMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -7260027713579229002L;
	
	//Main Grid(바코드 ,시리얼넘버)
	private String itemMgtId;
	private String serialNum;
	private String barcodeId;
	private String targetId;
	private String pickCreatedAt;
	private String shipId;
	private String plcEqmtId;
	private String itemId;
	private String prodAsmId;
	private String packageId;
	
	//Main Grid Join
	private String orderId;
	private String orderNm;
	private String orderState;
	private String lotId;
	private String lotNm;
	private String lotState;
	private int lotQty;
	private String itemNm;
	private String itemStdStr01;
	private String shipCompleteDate;
	
	//Sub Grid(A/S 정보)
	private String ashisId;
	private String ashisState;
	private int ashisCnt;
	private String ashisUser;
	private String ashisAt;
	private String ashisDesc;
	private String ashisStdStr01;
	private String ashisResult;
	
	//Sub Grid Join
	private String ashisUserNm;
	private String mtrlMgtId;
	private String mtrlId;
	private String mtrlNm;
	
	//생성 , 수정
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;

}
