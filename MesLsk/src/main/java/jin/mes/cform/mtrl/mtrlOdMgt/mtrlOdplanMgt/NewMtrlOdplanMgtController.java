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
public class NewMtrlOdplanMgtController extends BaseController {

	@Autowired
	NewMtrlOdplanMgtService newMtrlOrderService;
	
	@RequestMapping("getMtrlOrderList")
	public ModelMap getMtrlOrderList(ModelMap model, @ModelAttribute("newMtrlOrderDto") NewMtrlOdplanMgtDto newMtrlOrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newMtrlOrderDto.getPage())));
		pageRequestVo.setRows(newMtrlOrderDto.getRows());
		try {
			setModelWithkendoList(model, newMtrlOrderService.getMtrlOrderList(newMtrlOrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("발주정보 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlOrderSave")
	@ResponseBody
	public String setEqmtMgtSave(@RequestBody NewMtrlOdplanMgtDto newMtrlOrderDto) {
		return newMtrlOrderService.setMtrlOrderSave(newMtrlOrderDto);
	}
	
	@RequestMapping("/setMtrlOrderDelete")
	@ResponseBody
	public int setEqmtMgtDelete(ModelMap model, @RequestBody List<NewMtrlOdplanMgtDto> facilMgtList) {
		return newMtrlOrderService.setMtrlOrderDelete(facilMgtList);
	}
	
	
}
