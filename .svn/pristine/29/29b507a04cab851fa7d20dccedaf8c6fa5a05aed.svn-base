package jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt;

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
@RequestMapping("/form/mtrl/mtrlOdMgt/mtrlOdplanMgt")
public class MtrlOdplanMgtController extends BaseController {

	@Autowired
	MtrlOdplanMgtService mtrlOrderService;
	
	@RequestMapping("getMtrlOrderList")
	public ModelMap getMtrlOrderList(ModelMap model, @ModelAttribute("mtrlOrderDto") MtrlOdplanMgtDto mtrlOrderDto) {
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
	public String setEqmtMgtSave(@RequestBody MtrlOdplanMgtDto mtrlOrderDto) {
		return mtrlOrderService.setMtrlOrderSave(mtrlOrderDto);
	}
	
	@RequestMapping("/setMtrlOrderDelete")
	@ResponseBody
	public int setEqmtMgtDelete(ModelMap model, @RequestBody List<MtrlOdplanMgtDto> facilMgtList) {
		return mtrlOrderService.setMtrlOrderDelete(facilMgtList);
	}
	
	
}
