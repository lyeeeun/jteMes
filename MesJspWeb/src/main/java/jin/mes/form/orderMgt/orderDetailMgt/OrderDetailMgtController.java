package jin.mes.form.orderMgt.orderDetailMgt;

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
@RequestMapping("/form/orderMgt/orderDetailMgt")
public class OrderDetailMgtController extends BaseController {

	@Autowired
	OrderDetailMgtService orderDetailMgtService;
	
	@RequestMapping("getOrderList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("orderDto") OrderDetailMgtDto orderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderDto.getPage())));
		pageRequestVo.setRows(orderDto.getRows());
		
		try {
			setModelWithkendoList(model, orderDetailMgtService.getOrderList(orderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setOrderInfoSave")
	@ResponseBody
	public String setOrderInfoSave(@RequestBody OrderDetailMgtDto orderDto) {
		return orderDetailMgtService.setOrderInfoSave(orderDto);
	}
	
	@RequestMapping("/setOrderInfoDelete")
	@ResponseBody
	public int setOrderInfoDelete(ModelMap model, @RequestBody List<OrderDetailMgtDto> orderList) {
		return orderDetailMgtService.setOrderInfoDelete(orderList);
	}
	
	@RequestMapping("getLotList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("lotInfoDto") LotInfoDto lotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotInfoDto.getPage())));
		pageRequestVo.setRows(lotInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, orderDetailMgtService.getLotList(lotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setLotInfoSave")
	@ResponseBody
	public int setLotInfoSave(@RequestBody LotInfoDto lotInfoDto) {
		return orderDetailMgtService.setLotInfoSave(lotInfoDto);
	}
	
	@RequestMapping("/setLotInfoDelete")
	@ResponseBody
	public int setLotInfoDelete(ModelMap model, @RequestBody List<LotInfoDto> lotList) {
		return orderDetailMgtService.setLotInfoDelete(lotList);
	}
}
