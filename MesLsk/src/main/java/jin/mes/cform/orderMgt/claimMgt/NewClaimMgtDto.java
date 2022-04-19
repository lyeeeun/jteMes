package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewClaimMgtDto extends NewLotInfoDto {/**
	 * 
	 */
	private static final long serialVersionUID = 8579583011697189465L;
	
	private String claimId;
	private String claimNm;
	private int claimQty;
	private String claimState;
	private String claimDesc;
	
	private String badId;
	private List<NewInfergodsMgtDto> defectList;
	
	private List<NewInfergodsMgtDto> defectInsertList;
	private List<NewInfergodsMgtDto> defectUpdateList;
	private List<NewInfergodsMgtDto> defectDeleteList;
}
