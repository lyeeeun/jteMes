package jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt;

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
@RequestMapping("/cform/mtrl/mtrlOdMgt/mtrlOdplanMgt")
public class ZinixMtrlOdplanMgtController extends BaseController {

	@Autowired
	ZinixMtrlOdplanMgtService mtrlOrderService;
	
	@RequestMapping("getMtrlOrderList")
	public ModelMap getMtrlOrderList(ModelMap model, @ModelAttribute("mtrlOrderDto") ZinixMtrlOdplanMgtDto mtrlOrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(mtrlOrderDto.getPage())));
		pageRequestVo.setRows(mtrlOrderDto.getRows());
		try {
			setModelWithkendoList(model, mtrlOrderService.getMtrlOrderList(mtrlOrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlOrderSave")
	@ResponseBody
	public String setMtrlOrderSave(@RequestBody ZinixMtrlOdplanMgtDto mtrlOrderDto) {
		return mtrlOrderService.setMtrlOrderSave(mtrlOrderDto);
	}
	
	@RequestMapping("/setMtrlOrderBatchSave")
	@ResponseBody
	public String setMtrlOrderBatchSave(@RequestBody List<ZinixMtrlOdplanMgtDto> mtrlOrderList) {
		return mtrlOrderService.setMtrlOrderBatchSave(mtrlOrderList);
	}
	
	@RequestMapping("/setMtrlOrderDelete")
	@ResponseBody
	public int setMtrlOrderDelete(ModelMap model, @RequestBody List<ZinixMtrlOdplanMgtDto> facilMgtList) {
		return mtrlOrderService.setMtrlOrderDelete(facilMgtList);
	}
	
	
}