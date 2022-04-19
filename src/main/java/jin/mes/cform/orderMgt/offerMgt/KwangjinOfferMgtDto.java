package jin.mes.cform.orderMgt.offerMgt;

import java.util.List;

import jin.mes.common.attach.AttachMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class KwangjinOfferMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = 6271629318833370412L;
	
	
	private String offerId;
	private String offerNm;
	private String offerDate;
	private String offerFile;
	private String offerDesc;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String compId;
	private String compNm;
	private String compStdStr02;
	private String compNumber;
	
	private String searchStartDate;
	private String searchEndDate;
	
	//첨부파일
	private List<AttachMgtDto> insertAttach;
	private List<AttachMgtDto> deleteAttach;
	
}
