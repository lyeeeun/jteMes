package jin.mes.form.orderMgt.costMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/orderMgt/costMgt")
public class CostMgtController extends BaseController {

	@Autowired
	CostMgtService costMgtService;
	
	@RequestMapping("selectLotCostList")
	public ModelMap selectLotCostList(ModelMap model, @ModelAttribute("costMgtDto") CostMgtDto costMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(costMgtDto.getPage())));
		pageRequestVo.setRows(costMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, costMgtService.selectLotCostList(costMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
