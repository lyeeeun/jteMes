package jin.mes.form.mfgMgt.mfgplanMgt.eqmtOperationPlan;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class EqmtOperationPlanService {

	@Resource
    protected EqmtOperationPlanMapper eqmtOperationPlanMapper;

	public List<EqmtOperationPlanDto> selectEqmtOperationPlan(EqmtOperationPlanDto eqmtOperationPlanDto){
		List<EqmtOperationPlanDto> operationPlanList = null;
		
		try {
			operationPlanList = eqmtOperationPlanMapper.selectEqmtOperationPlan(eqmtOperationPlanDto);
			return operationPlanList;
		} catch (Exception e) {
			throw new BusinessException("selectEqmtOperationPlan : " + e.getMessage());
		}
	}
}
