package jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.ZinixMfgplanDto;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.ZinixProductPlanDto;

@Mapper
public interface ZinixMfgplanMapper {
	public List<ZinixMfgplanDto> selectMonthPlanList(ZinixMfgplanDto planDto);
	
	public int selectMonthPlanListCount(ZinixMfgplanDto planDto);
	
	public List<ZinixMfgplanDto> selectDayPlanList(ZinixMfgplanDto planDto);
	
	public int selectDayPlanListCount(ZinixMfgplanDto planDto);
	
	public List<ZinixProductPlanDto> selectPlanDetail(ZinixProductPlanDto productPlanDto);
	
	public void insertPlanCnt(ZinixProductPlanDto productPlanDto);
	
	public void updatePlanCnt(ZinixProductPlanDto productPlanDto);
	
	public void deletePlan(ZinixProductPlanDto productPlanDto);
	
	public ZinixProductPlanDto selectBulkMonthPos(ZinixProductPlanDto productPlanDto);
	
	public ZinixProductPlanDto selectBulkDayPos(ZinixProductPlanDto productPlanDto);
	
	public ZinixProductPlanDto selectBulkMonthPeriod(ZinixProductPlanDto productPlanDto);
	
	public ZinixProductPlanDto selectBulkDayPeriod(ZinixProductPlanDto productPlanDto);
	
	public int selectBulkPlanCnt(ZinixProductPlanDto productPlanDto);
}
