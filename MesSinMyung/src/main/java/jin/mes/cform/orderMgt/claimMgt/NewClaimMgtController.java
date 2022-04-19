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
	public ModelMap getOrderClaimList(ModelMap model, @ModelAttribute("orderDto") NewOrderDetailMgtDto orderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderDto.getPage())));
		pageRequestVo.setRows(orderDto.getRows());
		
		try {
			setModelWithkendoList(model, newClaimMgtService.getOrderClaimList(orderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getLotClaimList")
	public ModelMap getLotClaimList(ModelMap model, @ModelAttribute("claimDto") NewClaimMgtDto claimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(claimDto.getPage())));
		pageRequestVo.setRows(claimDto.getRows());
		
		try {
			setModelWithkendoList(model, newClaimMgtService.getLotClaimList(claimDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("Claim 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setClaimInfoSave")
	@ResponseBody
	public String setClaimInfoSave(@RequestBody NewClaimMgtDto claimDto) {
		return newClaimMgtService.setClaimInfoSave(claimDto);
	}
	
	@RequestMapping("/setClaimInfoDelete")
	@ResponseBody
	public int setClaimInfoDelete(ModelMap model, @RequestBody List<NewClaimMgtDto> claimList) {
		return newClaimMgtService.setClaimInfoDelete(claimList);
	}
	
	@RequestMapping("/getRtlDefectList")
	public ModelMap getRtlDefectList(@ModelAttribute("claimMgtDto") NewClaimMgtDto claimMgtDto, ModelMap model) {
		model.addAttribute("rows", newClaimMgtService.getRtlDefectList(claimMgtDto));

		return model;
	}
	
	@RequestMapping("/selectClaimInfo")
	public ModelMap selectClaimInfo(ModelMap model, @ModelAttribute("claimDto") NewClaimMgtDto claimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(claimDto.getPage())));
		pageRequestVo.setRows(claimDto.getRows());
		
		try {
			setModelWithkendoList(model, newClaimMgtService.selectClaimInfo(claimDto, pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("selectClaimInfo 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	
}
