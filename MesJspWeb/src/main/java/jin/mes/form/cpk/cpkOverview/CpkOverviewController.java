package jin.mes.form.cpk.cpkOverview;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.cpk.cpkBase.CpkService;
import kr.co.itcall.jte.common.mvc.BaseController;

@Controller
@RequestMapping("/form/cpk/cpkOverview")
public class CpkOverviewController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(CpkOverviewController.class);

	@Resource
	protected CpkService cpkService;

}
