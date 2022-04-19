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
public class KwangjinOrderDetailMgtController extends BaseController {

	@Autowired
	KwangjinOrderDetailMgtService kwangjinOrderDetailMgtService;
	
	@RequestMapping("getOrderList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("kwangjinOrderDetailMgtDto") KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinOrderDetailMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinOrderDetailMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, kwangjinOrderDetailMgtService.getOrderList(kwangjinOrderDetailMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	//수주 상세조회(order-child)
	@RequestMapping("getOrderPop")
	public ModelMap getOrderPop(ModelMap model, @ModelAttribute("kwangjinOrderDetailMgtDto") KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto) {
		try {
			model.addAttribute("rows",kwangjinOrderDetailMgtService.getOrderPop(kwangjinOrderDetailMgtDto)); 
		}catch(Exception ex) {
			throw new BusinessException("수주 상세조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setOrderInfoSave")
	@ResponseBody
	public String setOrderInfoSave(@RequestBody KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto) {
		return kwangjinOrderDetailMgtService.setOrderInfoSave(kwangjinOrderDetailMgtDto);
	}
	
	@RequestMapping("/setOrderInfoDelete")
	@ResponseBody
	public String setOrderInfoDelete(ModelMap model, @RequestBody List<KwangjinOrderDetailMgtDto> orderList) {
		return kwangjinOrderDetailMgtService.setOrderInfoDelete(orderList);
	}
	
	@RequestMapping("/setOrderTieSave")
	@ResponseBody
	public String setOrderTieSave(@RequestBody KwangjinOrderDetailMgtDto kwangjinOrderDetailMgtDto) {
		return kwangjinOrderDetailMgtService.setOrderTieSave(kwangjinOrderDetailMgtDto);
	}
	
	@RequestMapping("getLotList")
	public ModelMap getLotList(ModelMap model, @ModelAttribute("kwangjinLotInfoDto") KwangjinLotInfoDto kwangjinLotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinLotInfoDto.getPage())));
		pageRequestVo.setRows(kwangjinLotInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, kwangjinOrderDetailMgtService.getLotList(kwangjinLotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setLotInfoSave")
	@ResponseBody
	public int setLotInfoSave(@RequestBody KwangjinLotInfoDto kwangjinLotInfoDto) {
		return kwangjinOrderDetailMgtService.setLotInfoSave(kwangjinLotInfoDto);
	}
	
	@RequestMapping("/setLotInfoDelete")
	@ResponseBody
	public int setLotInfoDelete(ModelMap model, @RequestBody List<KwangjinLotInfoDto> lotList) {
		return kwangjinOrderDetailMgtService.setLotInfoDelete(lotList);	
	}
}
