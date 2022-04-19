package jin.mes.cform.ship.pickMgt;

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

import jin.mes.cform.ship.shipMgt.ZinixShipMgtDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/ship/pickMgt")
public class ZinixPickMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ZinixPickMgtController.class);

	@Resource
	protected ZinixPickMgtService zinixPickMgtService;

	@RequestMapping("/selectPickInfo")
	public ModelMap selectPickInfo(@ModelAttribute("pickMgtDto") ZinixPickMgtDto pickMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(pickMgtDto.getPage())));
		pageRequestVo.setRows(pickMgtDto.getRows());

		setModelWithkendoList(model, zinixPickMgtService.selectPickInfo(pickMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectBarcodeInfo")
	public ModelMap selectBarcodeInfo(@ModelAttribute("pickMgtDto") ZinixPickMgtDto pickMgtDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(pickMgtDto.getPage())));
		pageRequestVo.setRows(pickMgtDto.getRows());
		pageRequestVo.setPagingYN(pickMgtDto.getPagingYN());
		
		setModelWithkendoList(model, zinixPickMgtService.selectBarcodeInfo(pickMgtDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/selectBarcodeInfoAll")
	public ModelMap selectBarcodeInfoAll(@ModelAttribute("pickMgtDto") ZinixPickMgtDto pickMgtDto, ModelMap model) {
		try {
			model.addAttribute("rows", zinixPickMgtService.selectBarcodeInfoAll(pickMgtDto));
		}catch(Exception ex) {
			throw new BusinessException("selectBarcodeInfoAll  : " + ex.getMessage());
		}

		return model;
	}

	@RequestMapping("/setPickInfo")
	@ResponseBody
	public void setPickInfo(@RequestBody ZinixPickMgtDto pickMgtDto) {
		zinixPickMgtService.setPickInfo(pickMgtDto);
	}
	
	@RequestMapping("/deletePickInfo")
	@ResponseBody
	public int deletePickInfo(@RequestBody List<ZinixPickMgtDto> pickMgtDto) {
		return zinixPickMgtService.deletePickInfo(pickMgtDto);
	}

}
