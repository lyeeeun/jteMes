package jin.mes.form.cpk.cpkVaneMonitor;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.form.cpk.cpkBase.CpkService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/cpk/cpkVaneMonitor")
public class CpkVaneMonitorController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(CpkVaneMonitorController.class);

	@Resource
	protected CpkService cpkService;
	
	/**
	 * 코드 그룹 리스트를 가지고 온다.
	 * 
	 * @param map - 리스트 조회 조건
	 * 
	 * @return String - viewName / 코드 그룹 리스트
	 */
	
	@RequestMapping("/getVaneMonitorList")
	public ModelMap getProdInfoList(@ModelAttribute("CpkVaneMonitorDto") CpkVaneMonitorDto cpkVaneMonitorDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(cpkVaneMonitorDto.getPage())));
		pageRequestVo.setRows(cpkVaneMonitorDto.getRows());

		setModelWithkendoList(model, cpkService.getVaneMonitorList(cpkVaneMonitorDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getVaneOffsetList")
	public ModelMap getVaneOffsetList(@ModelAttribute("CpkVaneOffsetDto") CpkVaneOffsetDto cpkVaneOffsetDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(cpkVaneOffsetDto.getPage())));
		pageRequestVo.setRows(cpkVaneOffsetDto.getRows());

		setModelWithkendoList(model, cpkService.getVaneOffsetList(cpkVaneOffsetDto, pageRequestVo));

		return model;
	}
}
