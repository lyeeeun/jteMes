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
	NewOrderDetailMgtService newOrderDetailMgtService;;
	
	@RequestMapping("getOrderList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("orderDto") NewOrderDetailMgtDto orderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderDto.getPage())));
		pageRequestVo.setRows(orderDto.getRows());
		
		try {
			setModelWithkendoList(model, newOrderDetailMgtService.getOrderList(orderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setOrderInfoSave")
	@ResponseBody
	public String setOrderInfoSave(@RequestBody NewOrderDetailMgtDto orderDto) {
		return newOrderDetailMgtService.setOrderInfoSave(orderDto);
	}
	
	@RequestMapping("/setOrderInfoDelete")
	@ResponseBody
	public int setOrderInfoDelete(ModelMap model, @RequestBody List<NewOrderDetailMgtDto> orderList) {
		return newOrderDetailMgtService.setOrderInfoDelete(orderList);
	}
	
	@RequestMapping("getLotList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("lotInfoDto") NewLotInfoDto lotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotInfoDto.getPage())));
		pageRequestVo.setRows(lotInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, newOrderDetailMgtService.getLotList(lotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setLotInfoSave")
	@ResponseBody
	public int setLotInfoSave(@RequestBody NewLotInfoDto lotInfoDto) {
		return newOrderDetailMgtService.setLotInfoSave(lotInfoDto);
	}
	
	@RequestMapping("/setLotInfoDelete")
	@ResponseBody
	public int setLotInfoDelete(ModelMap model, @RequestBody List<NewLotInfoDto> lotList) {
		return newOrderDetailMgtService.setLotInfoDelete(lotList);
	}
	
	@RequestMapping("/selectDupleKeyCount")
	@ResponseBody
	public int selectDupleKeyCount(@RequestBody NewLotInfoDto lotInfoDto) {
		return newOrderDetailMgtService.selectDupleKeyCount(lotInfoDto);
	}
}
