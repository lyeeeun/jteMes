package jin.mes.form.facilMgt.facilOperMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class FacilOperMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -8132540607427767565L;
	//설비상세
	private String eqmtMgtId;
	private String eqmtMgtGbn;
	private int eqmtMgtMtnc;
	private String eqmtMgtNm;
	private String eqmtMgtPurchase;
	private String eqmtMgtVerif;
	private String eqmtMgtDesc;
	private boolean isUse;
	private String creatorId;
	private String createdAt;
	private String updatorId;
	private String updatedAt;
	private String placeId;
	
	//설비마스터
	private String eqmtId;
	private String eqmtNm;
	private String eqmtGbn;
	private int eqmtMaintenance;
	private String eqmtFile;
	private String compId;
	

	//가동이력
	private String eqmtWorkStart;
	private String eqmtWorkEnd;
	private String runTime;
	private float eqmtPercent;
	private String prodWorkId;
	
	
	private String eqmtWorkTotal;
	private String eqmtWorkTemp;
	
}
