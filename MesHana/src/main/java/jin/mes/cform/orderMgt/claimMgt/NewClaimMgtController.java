package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.orderMgt.orderDetailMgt.NewOrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/orderMgt/claimMgt")
public class NewClaimMgtController extends BaseController {

	@Autowired
	NewClaimMgtService newClaimMgtService;
	
	@RequestMapping("getOrderClaimList")
	public ModelMap getOrderClaimList(ModelMap model, @ModelAttribute("newOrderDto") NewOrderDetailMgtDto newOrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newOrderDto.getPage())));
		pageRequestVo.setRows(newOrderDto.getRows());
		
		try {
			setModelWithkendoList(model, newClaimMgtService.getOrderClaimList(newOrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getLotClaimList")
	public ModelMap getLotClaimList(ModelMap model, @ModelAttribute("newClaimDto") NewClaimMgtDto newClaimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newClaimDto.getPage())));
		pageRequestVo.setRows(newClaimDto.getRows());
		
		try {
			setModelWithkendoList(model, newClaimMgtService.getLotClaimList(newClaimDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("Claim 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setClaimInfoSave")
	@ResponseBody
	public String setClaimInfoSave(@RequestBody NewClaimMgtDto newClaimDto) {
		return newClaimMgtService.setClaimInfoSave(newClaimDto);
	}
	
	@RequestMapping("/setClaimInfoDelete")
	@ResponseBody
	public int setClaimInfoDelete(ModelMap model, @RequestBody List<NewClaimMgtDto> claimList) {
		return newClaimMgtService.setClaimInfoDelete(claimList);
	}
	
	@RequestMapping("/getRtlDefectList")
	public ModelMap getRtlDefectList(@ModelAttribute("newClaimMgtDto") NewClaimMgtDto newClaimMgtDto, ModelMap model) {
		model.addAttribute("rows", newClaimMgtService.getRtlDefectList(newClaimMgtDto));

		return model;
	}
	
	@RequestMapping("/selectClaimInfo")
	public ModelMap selectClaimInfo(ModelMap model, @ModelAttribute("newClaimDto") NewClaimMgtDto newClaimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newClaimDto.getPage())));
		pageRequestVo.setRows(newClaimDto.getRows());
		
		try {
			setModelWithkendoList(model, newClaimMgtService.selectClaimInfo(newClaimDto, pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("selectClaimInfo 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	
}
