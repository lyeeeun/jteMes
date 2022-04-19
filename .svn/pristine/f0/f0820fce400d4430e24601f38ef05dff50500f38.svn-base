package jin.mes.cform.barcode.barcodePrint;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.barcode.barcodeBase.ZinixBarcodeBaseDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/barcode/barcodePrint")
public class ZinixBarcodePrintController extends BaseController {

	@Resource
	protected ZinixBarcodePrintService zinixBarcodePrintService;
	
	//바코드 조회
	@RequestMapping("/getBarcodeList")
	public ModelMap getBarcodeList(@ModelAttribute("zinixBarcodePrintDto") ZinixBarcodeBaseDto zinixBarcodeBaseDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(zinixBarcodeBaseDto.getPage())));
		pageRequestVo.setRows(zinixBarcodeBaseDto.getRows());

		setModelWithkendoList(model, zinixBarcodePrintService.getBarcodeList(zinixBarcodeBaseDto, pageRequestVo));

		return model;
	}
}
