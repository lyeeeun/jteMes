package jin.mes.form.orderMgt.claimMgt;

import java.util.List;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimMgtDto extends LotInfoDto {/**
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
	private List<InfergodsMgtDto> defectList;
	
	private List<InfergodsMgtDto> defectInsertList;
	private List<InfergodsMgtDto> defectUpdateList;
	private List<InfergodsMgtDto> defectDeleteList;
}
