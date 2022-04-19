package jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.mfgplanMgt.mfgplan.ProductPlanDto;

@Mapper
public interface NewMfgplanMapper {
	public List<NewMfgplanDto> selectMonthPlanList(NewMfgplanDto planDto);
	
	public int selectMonthPlanListCount(NewMfgplanDto planDto);
	
	public List<NewMfgplanDto> selectDayPlanList(NewMfgplanDto planDto);
	
	public int selectDayPlanListCount(NewMfgplanDto planDto);
	
	public List<NewProductPlanDto> selectPlanDetail(NewProductPlanDto productPlanDto);
	
	public void insertPlanCnt(NewProductPlanDto productPlanDto);
	
	public void updatePlanCnt(NewProductPlanDto productPlanDto);
	
	public void deletePlan(NewProductPlanDto productPlanDto);
	
	public NewProductPlanDto selectBulkMonthPos(NewProductPlanDto productPlanDto);
	
	public NewProductPlanDto selectBulkDayPos(NewProductPlanDto productPlanDto);
	
	public NewProductPlanDto selectBulkMonthPeriod(NewProductPlanDto productPlanDto);
	
	public NewProductPlanDto selectBulkDayPeriod(NewProductPlanDto productPlanDto);
	
	public int selectBulkPlanCnt(NewProductPlanDto productPlanDto);
}
