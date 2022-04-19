package jin.mes.form.cpk.cpkVaneMonitor;

import java.math.BigDecimal;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CpkVaneMonitorDto extends BaseVo  {
	private static final long serialVersionUID = -7223763972842869911L;
	
	/** 목록 조회 첫번째 row */
	private int firstIndex;
	/** 목록 조회 마지막 row */
	private int lastIndex;
	
	private String machineCd;  // machine Table 
	
	private String machineStatus; // machine Table
	
	private String partNo; 
	
	private String opNo;
	
	private String planedQty;
	
	private String actQty;
	
	private BigDecimal performance;
	
	private BigDecimal elapsedTime;
	
	private BigDecimal utilizationRate;

	private BigDecimal runTime;
	
	private BigDecimal haveTime;
	
	private BigDecimal dueTime;
	
	private String ipAdd;
	
	private String mcnoDisp;
	
	private String shiftCd;
	
	private String startDate;
	
	private String endDate;
	
	private int dayCount;
	
	private String deptCd;
}