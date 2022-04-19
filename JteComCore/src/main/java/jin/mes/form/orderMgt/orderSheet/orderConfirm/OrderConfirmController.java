package jin.mes.form.orderMgt.orderSheet.orderConfirm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/orderMgt/orderSheet/orderConfirm")
public class OrderConfirmController extends BaseController {
	
	@Autowired
	OrderConfirmService orderConfirmService;
	
	//주문서정보 조회
	@RequestMapping("getOrderConfirmList")
	public ModelMap getOrderConfirmList(ModelMap model, @ModelAttribute("orderConfirmDto") OrderConfirmDto orderConfirmDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderConfirmDto.getPage())));
		pageRequestVo.setRows(orderConfirmDto.getRows());
		
		try {
			setModelWithkendoList(model, orderConfirmService.getOrderConfirmList(orderConfirmDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//주문서정보 수정
	@RequestMapping("/setOrderConfirmSave")
	@ResponseBody
	public String setOrderConfirmSave(@RequestBody OrderConfirmDto orderConfirmDto) {
		return orderConfirmService.setOrderConfirmSave(orderConfirmDto);
	}
	
	
	//LoT정보 조회
	@RequestMapping("getLotConfirmList")
	public ModelMap getLotConfirmList(ModelMap model, @ModelAttribute("lotConfirmDto") LotConfirmDto lotConfirmDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotConfirmDto.getPage())));
		pageRequestVo.setRows(lotConfirmDto.getRows());
		
		try {
			setModelWithkendoList(model, orderConfirmService.getLotConfirmList(lotConfirmDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//LoT정보 등록/수정
	@RequestMapping("/setLotConfirmSave")
	@ResponseBody
	public int setLotConfirmSave(@RequestBody LotConfirmDto lotConfirmDto) {
		return orderConfirmService.setLotConfirmSave(lotConfirmDto);
	}
	
}
