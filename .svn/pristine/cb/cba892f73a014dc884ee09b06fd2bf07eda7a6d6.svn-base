package jin.mes.cform.mfgMgt.mfgplanMgt.productPlan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.NewMfgplanDto;
import jin.mes.cform.mfgMgt.mfgplanMgt.mfgplan.NewProductPlanDto;

@Mapper
public interface NewProductPlanMapper {
	
	public List<NewMfgplanDto> selectProductPlanList(NewMfgplanDto newPlanDto);
	
	public int selectProductPlanCount(NewMfgplanDto newPlanDto);
	
	public List<NewProductPlanDto> selectProductPlanDetail(NewProductPlanDto newProductPlanDto);

	public void insertProductPlan(NewProductPlanDto newProductPlanDto);
	
	public void updateProductPlan(NewProductPlanDto newProductPlanDto);
	
	public void deleteProductPlan(NewProductPlanDto newProductPlanDto);
}
