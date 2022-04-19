package jin.mes.cform.cpk.cpkOverviewDetail;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.cpk.cpkBase.NewCpkService;
import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/cform/cpk/cpkOverviewDetail")
public class NewCpkOverviewDetailController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NewCpkOverviewDetailController.class);

	@Resource
	protected NewCpkService newCpkService;
	
}
