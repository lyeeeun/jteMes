package jin.mes.form.orderMgt.orderSheet.deliveryStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/orderMgt/orderSheet/deliveryStatus")
public class DeliveryStatusController extends BaseController {
	
	@Autowired
	DeliveryStatusService deliveryStatusService;
	
	//order search
	@RequestMapping("getOrderSearchList")
	public ModelMap getOrderSearchList(ModelMap model, @ModelAttribute("deliveryStaDto") DeliveryStatusDto deliveryStaDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(deliveryStaDto.getPage())));
		pageRequestVo.setRows(deliveryStaDto.getRows());
		
		try {
			setModelWithkendoList(model, deliveryStatusService.getOrderSearchList(deliveryStaDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//납품현황 - LoT조회
	@RequestMapping("getDeliveryStaLotList")
	public ModelMap getDeliveryStaLotList(ModelMap model, @ModelAttribute("deliveryStaDto") DeliveryStatusDto deliveryStaDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(deliveryStaDto.getPage())));
		pageRequestVo.setRows(deliveryStaDto.getRows());
		
		try {
			setModelWithkendoList(model, deliveryStatusService.getDeliveryStaLotList(deliveryStaDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//납품현황 조회
	@RequestMapping("getDeliveryStatusList")
	public ModelMap getDeliveryStatusList(ModelMap model, @ModelAttribute("lotDeliveryStaDto") LotDeliveryStaDto lotDeliveryStaDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotDeliveryStaDto.getPage())));
		pageRequestVo.setRows(lotDeliveryStaDto.getRows());
		
		try {
			setModelWithkendoList(model, deliveryStatusService.getDeliveryStatusList(lotDeliveryStaDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("납품현황 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
}
