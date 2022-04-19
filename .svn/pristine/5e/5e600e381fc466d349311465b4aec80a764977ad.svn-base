package jin.mes.form.mfgMgt.mfgplanMgt.mfgplan;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class ProductPlanDto  extends LotInfoDto {/**
	 * 
	 */
	private static final long serialVersionUID = 3301904692251069570L;
	
	public ProductPlanDto(String prodPlanId, String prodPlanType, String prodPlanYear, String prodPlanMonth, String prodPlanDay, int prodPlanQty, String prodPlanDesc, String creatorId, String updatorId, String lotId) {
		 this.prodPlanId = prodPlanId;
		 this.prodPlanType = prodPlanType;
		 this.prodPlanYear = prodPlanYear;
		 this.prodPlanMonth = prodPlanMonth;
		 this.prodPlanDay = prodPlanDay;
		 this.prodPlanQty = prodPlanQty;
		 this.prodPlanDesc = prodPlanDesc;
		 this.creatorId = creatorId;
		 this.updatorId = updatorId;
		 super.setLotId(lotId);
	}
	
	private String prodPlanId;
	private String prodPlanType;
	private String prodPlanYear;
	private String prodPlanMonth;
	private String prodPlanDay;
	private int prodPlanQty;
	private String itemId;
	private String itemNm;
	private int itemDeduction;
	private int itemDayTarget;
	private String prodPlanDesc;
	private String createdAt;
	private String creatorId;
	private String updatedAt;
	private String updatorId;
	
	//일괄처리
	private String[] bulkTarget;
	private String bulkType;
	private String baseDate;
	private String bulkPeriodYN;
	private String bulkStdt;
	private String bulkEddt;
	private int planCnt;
	private int asgnCnt;
	private int workCnt;
}
