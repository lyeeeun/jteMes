package jin.mes.form.barcode.barcodePrint;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.barcode.barcodeBase.BarcodeBaseDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/barcode/barcodePrint")
public class BarcodePrintController extends BaseController {

	@Resource
	protected BarcodePrintService barcodePrintService;
	
	//바코드 조회
	@RequestMapping("/getBarcodeList")
	public ModelMap getBarcodeList(@ModelAttribute("barcodePrintDto") BarcodeBaseDto barcodeBaseDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(barcodeBaseDto.getPage())));
		pageRequestVo.setRows(barcodeBaseDto.getRows());

		setModelWithkendoList(model, barcodePrintService.getBarcodeList(barcodeBaseDto, pageRequestVo));

		return model;
	}
}
