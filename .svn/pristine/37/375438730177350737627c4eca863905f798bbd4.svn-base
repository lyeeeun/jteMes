package jin.mes.cform.mfgMgt.mfgplanMgt.eqmtOperationPlan;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewEqmtOperationPlanService {

	@Resource
    protected NewEqmtOperationPlanMapper newEqmtOperationPlanMapper;

	public List<NewEqmtOperationPlanDto> selectEqmtOperationPlan(NewEqmtOperationPlanDto eqmtOperationPlanDto){
		List<NewEqmtOperationPlanDto> operationPlanList = null;
		
		try {
			operationPlanList = newEqmtOperationPlanMapper.selectEqmtOperationPlan(eqmtOperationPlanDto);
			return operationPlanList;
		} catch (Exception e) {
			throw new BusinessException("selectEqmtOperationPlan : " + e.getMessage());
		}
	}
}
