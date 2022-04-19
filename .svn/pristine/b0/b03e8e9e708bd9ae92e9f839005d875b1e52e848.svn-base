package jin.mes.cform.orderMgt.orderDetailMgt;

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
@RequestMapping("/cform/orderMgt/orderDetailMgt")
public class NewOrderDetailMgtController extends BaseController {

	@Autowired
	NewOrderDetailMgtService newOrderDetailMgtService;
	
	@RequestMapping("getOrderList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("newOrderDto") NewOrderDetailMgtDto newOrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newOrderDto.getPage())));
		pageRequestVo.setRows(newOrderDto.getRows());
		
		try {
			setModelWithkendoList(model, newOrderDetailMgtService.getOrderList(newOrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setOrderInfoSave")
	@ResponseBody
	public String setOrderInfoSave(@RequestBody NewOrderDetailMgtDto newOrderDto) {
		return newOrderDetailMgtService.setOrderInfoSave(newOrderDto);
	}
	
	@RequestMapping("/setOrderInfoDelete")
	@ResponseBody
	public int setOrderInfoDelete(ModelMap model, @RequestBody List<NewOrderDetailMgtDto> orderList) {
		return newOrderDetailMgtService.setOrderInfoDelete(orderList);
	}
	
	@RequestMapping("getLotList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("newLotInfoDto") NewLotInfoDto newLotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newLotInfoDto.getPage())));
		pageRequestVo.setRows(newLotInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, newOrderDetailMgtService.getLotList(newLotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setLotInfoSave")
	@ResponseBody
	public int setLotInfoSave(@RequestBody NewLotInfoDto newLotInfoDto) {
		return newOrderDetailMgtService.setLotInfoSave(newLotInfoDto);
	}
	
	@RequestMapping("/setLotInfoDelete")
	@ResponseBody
	public int setLotInfoDelete(ModelMap model, @RequestBody List<NewLotInfoDto> lotList) {
		return newOrderDetailMgtService.setLotInfoDelete(lotList);
	}
	
	@RequestMapping("/setLotInfoComplete")
	@ResponseBody
	public void setLotInfoComplete(@RequestBody NewLotInfoDto newLotInfoDto) {
		newOrderDetailMgtService.setLotInfoComplete(newLotInfoDto);
	}
}
