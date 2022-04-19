package jin.mes.cform.mfgMgt.mfgplanMgt.productPlan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.ZinixMfgplanDto;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.ZinixProductPlanDto;

@Mapper
public interface ZinixProductPlanMapper {
	
	public List<ZinixMfgplanDto> selectProductPlanList(ZinixMfgplanDto planDto);
	
	public int selectProductPlanCount(ZinixMfgplanDto planDto);
	
	public List<ZinixProductPlanDto> selectProductPlanDetail(ZinixProductPlanDto productPlanDto);

	public void insertProductPlan(ZinixProductPlanDto productPlanDto);
	
	public void updateProductPlan(ZinixProductPlanDto productPlanDto);
	
	public void deleteProductPlan(ZinixProductPlanDto productPlanDto);
}
