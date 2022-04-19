package jin.mes.form.techMgt.offsetMgt;

import kr.co.itcall.jte.common.mvc.BaseVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OffsetMgtDto extends BaseVo{/**
	 * 
	 */
	private static final long serialVersionUID = -396263279309356341L;
	
	private String transferDt;
	
	private String itemCd;
	
	private String opNo;
	
	private String dimNo;
	
	private String axiesNo;
	
	private float halfValue;
	
	private float maxValue;
	
	private float minValue;
	
	private float gaValue;
	
	private float distanceValue;
	
	private String offsetNo;
	
	private String guOffset;
	
	private float offsetBefore;
	
	private float offsetAdjust;
	
	private float offsetAfter;
	
	private String machineNo;

}
