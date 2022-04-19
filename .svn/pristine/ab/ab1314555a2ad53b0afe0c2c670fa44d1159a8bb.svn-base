package jin.mes.form.orderMgt.claimMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.OrderDetailMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;
import jin.mes.form.orderMgt.claimMgt.ClaimMgtDto;
import jin.mes.form.orderMgt.claimMgt.ClaimMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/orderMgt/claimMgt")
public class ClaimMgtController extends BaseController {

	@Autowired
	ClaimMgtService claimMgtService;
	
	@RequestMapping("getOrderClaimList")
	public ModelMap getOrderClaimList(ModelMap model, @ModelAttribute("OrderDto") OrderDetailMgtDto OrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(OrderDto.getPage())));
		pageRequestVo.setRows(OrderDto.getRows());
		
		try {
			setModelWithkendoList(model, claimMgtService.getOrderClaimList(OrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getLotClaimList")
	public ModelMap getLotClaimList(ModelMap model, @ModelAttribute("ClaimDto") ClaimMgtDto ClaimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ClaimDto.getPage())));
		pageRequestVo.setRows(ClaimDto.getRows());
		
		try {
			setModelWithkendoList(model, claimMgtService.getLotClaimList(ClaimDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("Claim 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setClaimInfoSave")
	@ResponseBody
	public String setClaimInfoSave(@RequestBody ClaimMgtDto ClaimDto) {
		return claimMgtService.setClaimInfoSave(ClaimDto);
	}

	
	@RequestMapping("/setClaimInfoDelete")
	@ResponseBody
	public int setClaimInfoDelete(ModelMap model, @RequestBody List<ClaimMgtDto> claimList) {
		return claimMgtService.setClaimInfoDelete(claimList);
	}
	
	@RequestMapping("/getRtlDefectList")
	public ModelMap getRtlDefectList(@ModelAttribute("ClaimMgtDto") ClaimMgtDto ClaimMgtDto, ModelMap model) {
		model.addAttribute("rows", claimMgtService.getRtlDefectList(ClaimMgtDto));

		return model;
	}
	
	@RequestMapping("/selectClaimInfo")
	public ModelMap selectClaimInfo(ModelMap model, @ModelAttribute("ClaimDto") ClaimMgtDto ClaimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ClaimDto.getPage())));
		pageRequestVo.setRows(ClaimDto.getRows());
		
		try {
			setModelWithkendoList(model, claimMgtService.selectClaimInfo(ClaimDto, pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("selectClaimInfo 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getOrderList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("OrderDto") OrderDetailMgtDto OrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(OrderDto.getPage())));
		pageRequestVo.setRows(OrderDto.getRows());
		
		try {
			setModelWithkendoList(model, claimMgtService.getOrderList(OrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("getLotList")
	public ModelMap getLotList(ModelMap model, @ModelAttribute("LotInfoDto") LotInfoDto LotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(LotInfoDto.getPage())));
		pageRequestVo.setRows(LotInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, claimMgtService.getLotList(LotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	
}
