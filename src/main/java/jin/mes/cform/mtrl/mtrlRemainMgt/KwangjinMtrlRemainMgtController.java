package jin.mes.cform.mtrl.mtrlRemainMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.ship.shipPlanMgt.KwangjinShipPlanMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Controller
@RequestMapping("/cform/mtrl/mtrlRemainMgt")
public class KwangjinMtrlRemainMgtController extends BaseController {


	@Autowired
	KwangjinMtrlRemainMgtService kwangjinMtrlRemainMgtService;
	
	@RequestMapping("/getMtrlRemainList")
	public ModelMap getMtrlMgtList(ModelMap model, @ModelAttribute("kwangjinMtrlRemainMgtDto") KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinMtrlRemainMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinMtrlRemainMgtDto.getRows());
		pageRequestVo.setPagingYN(kwangjinMtrlRemainMgtDto.getPagingYN());
		try {
			setModelWithkendoList(model, kwangjinMtrlRemainMgtService.getMtrlRemainList(kwangjinMtrlRemainMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("자재 잔량 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMtrlRemainSave")
	@ResponseBody
	public String setMtrlMgtSave(@RequestBody KwangjinMtrlRemainMgtDto kwangjinMtrlRemainMgtDto) {
		return kwangjinMtrlRemainMgtService.setMtrlRemainSave(kwangjinMtrlRemainMgtDto);
	}

	@RequestMapping("/setMtrlRemainDelete")
	@ResponseBody
	public String setShipPlanDelete(ModelMap model, @RequestBody List<KwangjinMtrlRemainMgtDto> mtrlRemainList) {
		return kwangjinMtrlRemainMgtService.setMtrlRemainDelete(mtrlRemainList);
	}
}
