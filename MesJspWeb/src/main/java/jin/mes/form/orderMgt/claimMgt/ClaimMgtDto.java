package jin.mes.form.orderMgt.claimMgt;

import java.util.List;

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.BaseVo;
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
	private String claimState;
	private String claimDesc;
	
	private String badId;
	private List<InfergodsMgtDto> defectList;
	
	private List<InfergodsMgtDto> defectInsertList;
	private List<InfergodsMgtDto> defectUpdateList;
	private List<InfergodsMgtDto> defectDeleteList;
}
