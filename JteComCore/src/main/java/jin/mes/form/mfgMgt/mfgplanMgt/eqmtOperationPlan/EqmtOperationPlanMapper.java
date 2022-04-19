package jin.mes.form.mfgMgt.mfgplanMgt.eqmtOperationPlan;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.mfgMgt.mfgplanMgt.eqmtOperationPlan.EqmtOperationPlanDto;

@Mapper
public interface EqmtOperationPlanMapper {
	public List<EqmtOperationPlanDto> selectEqmtOperationPlan(EqmtOperationPlanDto eqmtOperationPlanDto);
}