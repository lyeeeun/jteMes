package jin.mes.mapper.mfgMgt.mfgplanMgt.mfgplan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.mfgplanMgt.mfgplan.MfgplanDto;
import jin.mes.form.mfgMgt.mfgplanMgt.mfgplan.ProductPlanDto;

@Mapper
public interface MfgplanMapper {
	public List<MfgplanDto> selectMonthPlanList(MfgplanDto planDto);
	
	public int selectMonthPlanListCount(MfgplanDto planDto);
	
	public List<MfgplanDto> selectDayPlanList(MfgplanDto planDto);
	
	public int selectDayPlanListCount(MfgplanDto planDto);
	
	public List<ProductPlanDto> selectPlanDetail(ProductPlanDto productPlanDto);
	
	public void insertPlanCnt(ProductPlanDto productPlanDto);
	
	public void updatePlanCnt(ProductPlanDto productPlanDto);
	
	public void deletePlan(ProductPlanDto productPlanDto);
	
	public ProductPlanDto selectBulkMonthPos(ProductPlanDto productPlanDto);
	
	public ProductPlanDto selectBulkDayPos(ProductPlanDto productPlanDto);
	
	public ProductPlanDto selectBulkMonthPeriod(ProductPlanDto productPlanDto);
	
	public ProductPlanDto selectBulkDayPeriod(ProductPlanDto productPlanDto);
	
	public int selectBulkPlanCnt(ProductPlanDto productPlanDto);
}
