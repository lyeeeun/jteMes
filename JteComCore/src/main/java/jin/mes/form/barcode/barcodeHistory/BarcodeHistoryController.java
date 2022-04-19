package jin.mes.form.barcode.barcodeHistory;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/corm/barcode/barcodeHistory")
public class BarcodeHistoryController extends BaseController {

	@Resource
	protected BarcodeHistoryService barcodeHistoryService;
	
}
