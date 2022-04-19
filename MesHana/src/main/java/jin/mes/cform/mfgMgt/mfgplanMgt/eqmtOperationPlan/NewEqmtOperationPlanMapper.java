package jin.mes.cform.mfgMgt.mfgplanMgt.eqmtOperationPlan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.mfgMgt.mfgplanMgt.eqmtOperationPlan.NewEqmtOperationPlanDto;

@Mapper
public interface NewEqmtOperationPlanMapper {
	public List<NewEqmtOperationPlanDto> selectEqmtOperationPlan(NewEqmtOperationPlanDto newEqmtOperationPlanDto);
}