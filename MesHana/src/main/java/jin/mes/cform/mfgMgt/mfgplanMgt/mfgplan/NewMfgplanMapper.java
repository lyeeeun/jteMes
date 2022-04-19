package jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.NewMfgplanDto;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.NewProductPlanDto;

@Mapper
public interface NewMfgplanMapper {
	public List<NewMfgplanDto> selectMonthPlanList(NewMfgplanDto newPlanDto);
	
	public int selectMonthPlanListCount(NewMfgplanDto newPlanDto);
	
	public List<NewMfgplanDto> selectDayPlanList(NewMfgplanDto newPlanDto);
	
	public int selectDayPlanListCount(NewMfgplanDto newPlanDto);
	
	public List<NewProductPlanDto> selectPlanDetail(NewProductPlanDto newProductPlanDto);
	
	public void insertPlanCnt(NewProductPlanDto newProductPlanDto);
	
	public void updatePlanCnt(NewProductPlanDto newProductPlanDto);
	
	public void deletePlan(NewProductPlanDto newProductPlanDto);
	
	public NewProductPlanDto selectBulkMonthPos(NewProductPlanDto newProductPlanDto);
	
	public NewProductPlanDto selectBulkDayPos(NewProductPlanDto newProductPlanDto);
	
	public NewProductPlanDto selectBulkMonthPeriod(NewProductPlanDto newProductPlanDto);
	
	public NewProductPlanDto selectBulkDayPeriod(NewProductPlanDto newProductPlanDto);
	
	public int selectBulkPlanCnt(NewProductPlanDto newProductPlanDto);
}
