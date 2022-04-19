package jin.mes.cform.orderMgt.offerMgt;


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
@RequestMapping("/cform/orderMgt/offerMgt")
public class KwangjinOfferMgtController extends BaseController {

	@Autowired
	KwangjinOfferMgtService kwangjinOfferMgtService;
	
	@RequestMapping("getOfferList")
	public ModelMap getLotClaimList(ModelMap model, @ModelAttribute("kwangjinOfferMgtDto") KwangjinOfferMgtDto kwangjinOfferMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinOfferMgtDto.getPage())));
		pageRequestVo.setRows(kwangjinOfferMgtDto.getRows());
		
		try {
			setModelWithkendoList(model, kwangjinOfferMgtService.getOfferList(kwangjinOfferMgtDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("Claim 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setOfferSave")
	@ResponseBody
	public String setClaimInfoSave(@RequestBody KwangjinOfferMgtDto kwangjinOfferMgtDto) {
		return kwangjinOfferMgtService.setOfferSave(kwangjinOfferMgtDto);
	}

	
	@RequestMapping("/setOfferDelete")
	@ResponseBody
	public int setClaimInfoDelete(ModelMap model, @RequestBody List<KwangjinOfferMgtDto> claimList) {
		return kwangjinOfferMgtService.setOfferDelete(claimList);
	}

}
