package jin.mes.cform.cpk.cpkReport;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.cpk.cpkBase.NewCpkService;
import jin.mes.cform.cpk.cpkVaneMonitor.NewCpkVaneMonitorDto;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/cpk/cpkReport")
public class NewCpkReportController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewCpkReportController.class);

	@Resource
	protected NewCpkService newCpkService;
	
	/**
	 * 코드 그룹 리스트를 가지고 온다.
	 * 
	 * @param map - 리스트 조회 조건
	 * 
	 * @return String - viewName / 코드 그룹 리스트
	 */
	
	@RequestMapping("/getCpkReportList")
	public ModelMap getProdInfoList(@ModelAttribute("CpkVaneMonitorDto") NewCpkVaneMonitorDto cpkVaneMonitorDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(cpkVaneMonitorDto.getPage())));
		pageRequestVo.setRows(cpkVaneMonitorDto.getRows());

		setModelWithkendoList(model, newCpkService.getCpkReportList(cpkVaneMonitorDto, pageRequestVo));

		return model;
	}
}
