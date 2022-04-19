package jin.mes.cform.ship.shipMgt;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.ship.shipPlanMgt.ZinixShipPlanMgtController;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/ship/shipMgt")
public class ZinixShipMgtController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ZinixShipPlanMgtController.class);

	@Resource
	protected ZinixShipMgtService zinixShipMgtService; 
	
	@RequestMapping("/selectShipInfo")
	public ModelMap selectShipInfo(@ModelAttribute("shipMgtDto") ZinixShipMgtDto shipMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(shipMgtDto.getPage())));
		pageRequestVo.setRows(shipMgtDto.getRows());

		setModelWithkendoList(model, zinixShipMgtService.selectShipInfo(shipMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectShipRtlBarcode")
	public ModelMap selectShipRtlBarcode(@ModelAttribute("shipMgtDto") ZinixShipMgtDto shipMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", zinixShipMgtService.selectShipRtlBarcode(shipMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectShipRtlBarcode  : " + ex.getMessage());
		}

		return model;
	}
	
	@RequestMapping("/selectBarcodeInfo")
	public ModelMap selectBarcodeInfo(@ModelAttribute("shipMgtDto") ZinixShipMgtDto shipMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(shipMgtDto.getPage())));
		pageRequestVo.setRows(shipMgtDto.getRows());
		pageRequestVo.setPagingYN(shipMgtDto.getPagingYN());
		
		setModelWithkendoList(model, zinixShipMgtService.selectBarcodeInfo(shipMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/setShipInfo")
	@ResponseBody
	public void setShipInfo(@RequestBody ZinixShipMgtDto shipMgtDto) {
		zinixShipMgtService.setShipInfo(shipMgtDto);
	}
	
	@RequestMapping("/deleteShipInfo")
	@ResponseBody
	public void deleteShipInfo(@RequestBody List<ZinixShipMgtDto> shipMgtDto) {
		zinixShipMgtService.deleteShipInfo(shipMgtDto);
	}
	
	@RequestMapping("/selectLotState")
	public ModelMap selectLotState(@ModelAttribute("shipMgtDto") ZinixShipMgtDto shipMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", zinixShipMgtService.selectLotState(shipMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectLotState  : " + ex.getMessage());
		}

		return model;
	}
	
	@RequestMapping("/allShipComplete")
	@ResponseBody
	public void allShipComplete(@RequestBody ZinixShipMgtDto shipMgtDto) {
		zinixShipMgtService.allShipComplete(shipMgtDto);
	}
	
}
