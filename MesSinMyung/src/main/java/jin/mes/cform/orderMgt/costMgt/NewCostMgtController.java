package jin.mes.cform.orderMgt.costMgt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/orderMgt/costMgt")
public class NewCostMgtController extends BaseController {

	@Autowired
	NewCostMgtService newCostMgtService;
	
	@RequestMapping("getOrderCostList")
	public ModelMap getOrderCostList(ModelMap model, @ModelAttribute("orderDto") NewOrderDetailMgtDto orderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderDto.getPage())));
		pageRequestVo.setRows(orderDto.getRows());
		
		try {
			setModelWithkendoList(model, newCostMgtService.getOrderCostList(orderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getLotCostList")
	public ModelMap getLotCostList(ModelMap model, @ModelAttribute("lotInfoDto") NewLotInfoDto lotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotInfoDto.getPage())));
		pageRequestVo.setRows(lotInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, newCostMgtService.getLotCostList(lotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
}
