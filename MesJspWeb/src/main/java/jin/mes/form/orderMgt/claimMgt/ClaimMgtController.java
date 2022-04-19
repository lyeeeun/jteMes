package jin.mes.form.orderMgt.claimMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.routing.routingMgt.RoutingRtlToolDto;
import jin.mes.form.orderMgt.costMgt.CostMgtService;
import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.orderDetailMgt.OrderDetailMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/orderMgt/claimMgt")
public class ClaimMgtController extends BaseController {

	@Autowired
	ClaimMgtService claimMgtService;
	
	@RequestMapping("getOrderClaimList")
	public ModelMap getOrderClaimList(ModelMap model, @ModelAttribute("orderDto") OrderDetailMgtDto orderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(orderDto.getPage())));
		pageRequestVo.setRows(orderDto.getRows());
		
		try {
			setModelWithkendoList(model, claimMgtService.getOrderClaimList(orderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getLotClaimList")
	public ModelMap getLotClaimList(ModelMap model, @ModelAttribute("claimDto") ClaimMgtDto claimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(claimDto.getPage())));
		pageRequestVo.setRows(claimDto.getRows());
		
		try {
			setModelWithkendoList(model, claimMgtService.getLotClaimList(claimDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("Claim 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setClaimInfoSave")
	@ResponseBody
	public String setClaimInfoSave(@RequestBody ClaimMgtDto claimDto) {
		return claimMgtService.setClaimInfoSave(claimDto);
	}
	
	@RequestMapping("/setClaimInfoDelete")
	@ResponseBody
	public int setClaimInfoDelete(ModelMap model, @RequestBody List<ClaimMgtDto> claimList) {
		return claimMgtService.setClaimInfoDelete(claimList);
	}
	
	@RequestMapping("/getRtlDefectList")
	public ModelMap getRtlDefectList(@ModelAttribute("claimMgtDto") ClaimMgtDto claimMgtDto, ModelMap model) {
		model.addAttribute("rows", claimMgtService.getRtlDefectList(claimMgtDto));

		return model;
	}
	
	@RequestMapping("/selectClaimInfo")
	public ModelMap selectClaimInfo(ModelMap model, @ModelAttribute("claimDto") ClaimMgtDto claimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(claimDto.getPage())));
		pageRequestVo.setRows(claimDto.getRows());
		
		try {
			setModelWithkendoList(model, claimMgtService.selectClaimInfo(claimDto, pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("selectClaimInfo 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	
}
