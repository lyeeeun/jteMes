package jin.mes.cform.cpk.cpkVaneMonitor;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class NewCpkVaneOffsetDto extends BaseVo {
	private static final long serialVersionUID = -7223763972842869911L;
	 
	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	
	private String itemCd; 
	
	private String opNo; // machine Table
	
	private String dimNo; 
	
	private String offsetNo;
	
	private String offsetGu;
	
	private String dimDesc;
	
	private String calDesc;
	
	private String graphDesc;
	
	private String graphDisp;
}
