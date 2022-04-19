package jin.mes.cform.mfgMgt.mfgplanMgt.eqmtOperationPlan;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/cform/mfgMgt/mfgplanMgt/eqmtOperationPlan")
public class NewEqmtOperationPlanController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewEqmtOperationPlanController.class);
	
	@Resource
	protected NewEqmtOperationPlanService newEqmtOperationPlanService;
	
	@RequestMapping("/selectEqmtOperationPlan")
	public ModelMap selectEqmtOperationPlan(@ModelAttribute("newEqmtOperationPlanDto") NewEqmtOperationPlanDto newEqmtOperationPlanDto, ModelMap model) {
		model.addAttribute("rows", newEqmtOperationPlanService.selectEqmtOperationPlan(newEqmtOperationPlanDto));

		return model;
	}
}
