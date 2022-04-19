package jin.mes.form.orderMgt.orderSheet.orderDetailMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.mtrl.mtrlMgt.MtrlMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/orderMgt/orderSheet/orderDetailMgt")
public class OrderDetailMgtController extends BaseController {

	@Autowired
	OrderDetailMgtService OrderDetailMgtService;
	
	@RequestMapping("getOrderList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("orderDto") OrderDetailMgtDto orderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderDto.getPage())));
		pageRequestVo.setRows(orderDto.getRows());
		
		try {
			setModelWithkendoList(model, OrderDetailMgtService.getOrderList(orderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//수주 상세조회(order-child)
	@RequestMapping("getOrderPop")
	public ModelMap getOrderPop(ModelMap model, @ModelAttribute("orderDto") OrderDetailMgtDto orderDto) {
		try {
			model.addAttribute("rows",OrderDetailMgtService.getOrderPop(orderDto)); 
		}catch(Exception ex) {
			throw new BusinessException("수주 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setOrderInfoSave")
	@ResponseBody
	public String setOrderInfoSave(@RequestBody OrderDetailMgtDto orderDto) {
		return OrderDetailMgtService.setOrderInfoSave(orderDto);
	}
	
	@RequestMapping("/setOrderInfoDelete")
	@ResponseBody
	public String setOrderInfoDelete(ModelMap model, @RequestBody List<OrderDetailMgtDto> orderList) {
		return OrderDetailMgtService.setOrderInfoDelete(orderList);
	}
	
	@RequestMapping("getLotList")
	public ModelMap getLotList(ModelMap model, @ModelAttribute("lotInfoDto") LotInfoDto lotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotInfoDto.getPage())));
		pageRequestVo.setRows(lotInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, OrderDetailMgtService.getLotList(lotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setLotInfoSave")
	@ResponseBody
	public int setLotInfoSave(@RequestBody LotInfoDto lotInfoDto) {
		return OrderDetailMgtService.setLotInfoSave(lotInfoDto);
	}
	
	@RequestMapping("/setLotInfoDelete")
	@ResponseBody
	public int setLotInfoDelete(ModelMap model, @RequestBody List<LotInfoDto> lotList) {
		return OrderDetailMgtService.setLotInfoDelete(lotList);	
	}
}
