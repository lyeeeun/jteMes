package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.orderMgt.claimMgt.KwangjinClaimMgtDto;
import jin.mes.cform.orderMgt.claimMgt.KwangjinClaimMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/orderMgt/claimMgt")
public class KwangjinClaimMgtController extends BaseController {

	@Autowired
	KwangjinClaimMgtService kwangjinClaimMgtService;
	
	@RequestMapping("getLotClaimList")
	public ModelMap getLotClaimList(ModelMap model, @ModelAttribute("kwangjinClaimDto") KwangjinClaimMgtDto kwangjinClaimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinClaimDto.getPage())));
		pageRequestVo.setRows(kwangjinClaimDto.getRows());
		
		try {
			setModelWithkendoList(model, kwangjinClaimMgtService.getLotClaimList(kwangjinClaimDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("Claim 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setClaimInfoSave")
	@ResponseBody
	public String setClaimInfoSave(@RequestBody KwangjinClaimMgtDto kwangjinClaimDto) {
		return kwangjinClaimMgtService.setClaimInfoSave(kwangjinClaimDto);
	}

	
	@RequestMapping("/setClaimInfoDelete")
	@ResponseBody
	public int setClaimInfoDelete(ModelMap model, @RequestBody List<KwangjinClaimMgtDto> claimList) {
		return kwangjinClaimMgtService.setClaimInfoDelete(claimList);
	}

}
