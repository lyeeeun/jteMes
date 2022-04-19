package jin.mes.cform.orderMgt.costMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/orderMgt/costMgt")
public class ZinixCostMgtController extends BaseController {

	@Autowired
	ZinixCostMgtService costMgtService;
	
	@RequestMapping("selectLotCostList")
	public ModelMap selectLotCostList(ModelMap model, @ModelAttribute("costMgtDto") ZinixCostMgtDto costMgtDto) {
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
