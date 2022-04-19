package jin.mes.mapper.mfgMgt.mfgplanMgt.productPlan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.mfgplanMgt.mfgplan.MfgplanDto;
import jin.mes.form.mfgMgt.mfgplanMgt.mfgplan.ProductPlanDto;

@Mapper
public interface ProductPlanMapper {
	
	public List<MfgplanDto> selectProductPlanList(MfgplanDto planDto);
	
	public int selectProductPlanCount(MfgplanDto planDto);
	
	public List<ProductPlanDto> selectProductPlanDetail(ProductPlanDto productPlanDto);

	public void insertProductPlan(ProductPlanDto productPlanDto);
	
	public void updateProductPlan(ProductPlanDto productPlanDto);
	
	public void deleteProductPlan(ProductPlanDto productPlanDto);
}
