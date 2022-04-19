package jin.mes.form.ship.pickMgt;

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

import jin.mes.form.ship.shipMgt.ShipMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/ship/pickMgt")
public class PickMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(PickMgtController.class);

	@Resource
	protected PickMgtService pickMgtService;

	@RequestMapping("/selectPickInfo")
	public ModelMap selectPickInfo(@ModelAttribute("pickMgtDto") PickMgtDto pickMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(pickMgtDto.getPage())));
		pageRequestVo.setRows(pickMgtDto.getRows());

		setModelWithkendoList(model, pickMgtService.selectPickInfo(pickMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectBarcodeInfo")
	public ModelMap selectBarcodeInfo(@ModelAttribute("pickMgtDto") PickMgtDto pickMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(pickMgtDto.getPage())));
		pageRequestVo.setRows(pickMgtDto.getRows());
		pageRequestVo.setPagingYN(pickMgtDto.getPagingYN());
		
		setModelWithkendoList(model, pickMgtService.selectBarcodeInfo(pickMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectBarcodeInfoAll")
	public ModelMap selectBarcodeInfoAll(@ModelAttribute("pickMgtDto") PickMgtDto pickMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", pickMgtService.selectBarcodeInfoAll(pickMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectBarcodeInfoAll  : " + ex.getMessage());
		}

		return model;
	}

	@RequestMapping("/setPickInfo")
	@ResponseBody
	public void setPickInfo(@RequestBody PickMgtDto pickMgtDto) {
		pickMgtService.setPickInfo(pickMgtDto);
	}
	
	@RequestMapping("/deletePickInfo")
	@ResponseBody
	public int deletePickInfo(@RequestBody List<PickMgtDto> pickMgtDto) {
		return pickMgtService.deletePickInfo(pickMgtDto);
	}

}
