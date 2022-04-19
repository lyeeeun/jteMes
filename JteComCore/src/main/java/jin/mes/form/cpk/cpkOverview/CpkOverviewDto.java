package jin.mes.form.cpk.cpkOverview;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.Data;

@Data
public class CpkOverviewDto implements Serializable  {
	private static final long serialVersionUID = -7223763972842869911L;
	
	private String transferDt;
	
	private String itemCd;
	
	private String opNo;
	
	private String dimNo;
	
	private String axiesNo;
	
	private BigDecimal halfValue;
	
	private BigDecimal maxValue;
	
	private BigDecimal minValue;
	
	private BigDecimal gaValue;
	
	private BigDecimal distanceValue;
	
	private String outValue;
	
	private String lotNo;
	
	private String offsetNo;
	
	private String shopOrder;
	
	private String guOffset;
	
	private BigDecimal offsetBefore;
	
	private BigDecimal offsetAdjust;
	
	private BigDecimal offsetAfter;
	
	private String machineNo;
	
	private String gageDt;
	
	private char limitError;
	
	private char defectYn;
	
	private char graphYn;
	
	private BigDecimal graphValue;
	
	private String graphDesc;
	
	private String graphDisp;
	
	private char transferYn;
	
	private String deptCd;
}
