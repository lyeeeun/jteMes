package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.ZinixInfergodsMgtDto;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ZinixClaimMgtDto extends ZinixLotInfoDto {/**
	 * 
	 */
	private static final long serialVersionUID = 8579583011697189465L;
	
	private String claimId;
	private String claimNm;
	private int claimQty;
	private int claimCnt;
	private String claimState;
	private String claimDesc;
	private String claimCause;
	private String claimResult;
	
	
	private String badId;
	private List<ZinixInfergodsMgtDto> defectList;
	
	private List<ZinixInfergodsMgtDto> defectInsertList;
	private List<ZinixInfergodsMgtDto> defectUpdateList;
	private List<ZinixInfergodsMgtDto> defectDeleteList;
}
