package jin.mes.cform.orderMgt.claimMgt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.orderMgt.claimMgt.ZinixClaimMgtDto;
import jin.mes.cform.orderMgt.claimMgt.ZinixClaimMgtService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/orderMgt/claimMgt")
public class ZinixClaimMgtController extends BaseController {

	@Autowired
	ZinixClaimMgtService zinixClaimMgtService;
	
	@RequestMapping("getOrderClaimList")
	public ModelMap getOrderClaimList(ModelMap model, @ModelAttribute("OrderDto") ZinixOrderDetailMgtDto OrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(OrderDto.getPage())));
		pageRequestVo.setRows(OrderDto.getRows());
		
		try {
			setModelWithkendoList(model, zinixClaimMgtService.getOrderClaimList(OrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getLotClaimList")
	public ModelMap getLotClaimList(ModelMap model, @ModelAttribute("ClaimDto") ZinixClaimMgtDto ClaimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ClaimDto.getPage())));
		pageRequestVo.setRows(ClaimDto.getRows());
		
		try {
			setModelWithkendoList(model, zinixClaimMgtService.getLotClaimList(ClaimDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("Claim 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setClaimInfoSave")
	@ResponseBody
	public String setClaimInfoSave(@RequestBody ZinixClaimMgtDto ClaimDto) {
		return zinixClaimMgtService.setClaimInfoSave(ClaimDto);
	}

	
	@RequestMapping("/setClaimInfoDelete")
	@ResponseBody
	public int setClaimInfoDelete(ModelMap model, @RequestBody List<ZinixClaimMgtDto> claimList) {
		return zinixClaimMgtService.setClaimInfoDelete(claimList);
	}
	
	@RequestMapping("/getRtlDefectList")
	public ModelMap getRtlDefectList(@ModelAttribute("ZinixClaimMgtDto") ZinixClaimMgtDto ZinixClaimMgtDto, ModelMap model) {
		model.addAttribute("rows", zinixClaimMgtService.getRtlDefectList(ZinixClaimMgtDto));

		return model;
	}
	
	@RequestMapping("/selectClaimInfo")
	public ModelMap selectClaimInfo(ModelMap model, @ModelAttribute("ClaimDto") ZinixClaimMgtDto ClaimDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ClaimDto.getPage())));
		pageRequestVo.setRows(ClaimDto.getRows());
		
		try {
			setModelWithkendoList(model, zinixClaimMgtService.selectClaimInfo(ClaimDto, pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("selectClaimInfo 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getOrderList")
	public ModelMap getOrderList(ModelMap model, @ModelAttribute("OrderDto") ZinixOrderDetailMgtDto OrderDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(OrderDto.getPage())));
		pageRequestVo.setRows(OrderDto.getRows());
		
		try {
			setModelWithkendoList(model, zinixClaimMgtService.getOrderList(OrderDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	@RequestMapping("getLotList")
	public ModelMap getLotList(ModelMap model, @ModelAttribute("ZinixLotInfoDto") ZinixLotInfoDto ZinixLotInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(ZinixLotInfoDto.getPage())));
		pageRequestVo.setRows(ZinixLotInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, zinixClaimMgtService.getLotList(ZinixLotInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("수주 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	
}
