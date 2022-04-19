package jin.mes.form.mfgMgt.mfgplanMgt.eqmtOperationPlan;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/mfgMgt/mfgplanMgt/eqmtOperationPlan")
public class EqmtOperationPlanController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(EqmtOperationPlanController.class);
	
	@Resource
	protected EqmtOperationPlanService eqmtOperationPlanService;
	
	@RequestMapping("/selectEqmtOperationPlan")
	public ModelMap selectEqmtOperationPlan(@ModelAttribute("eqmtOperationPlanDto") EqmtOperationPlanDto eqmtOperationPlanDto, ModelMap model) {
		model.addAttribute("rows", eqmtOperationPlanService.selectEqmtOperationPlan(eqmtOperationPlanDto));

		return model;
	}
}
