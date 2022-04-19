package jin.mes.cform.cpk.cpkOverview;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.cpk.cpkBase.NewCpkService;
import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/cform/cpk/cpkOverview")
public class NewCpkOverviewController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewCpkOverviewController.class);

	@Resource
	protected NewCpkService newCpkService;

}
