package jin.mes.cform.cpk.cpkVaneMonitor;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.cpk.cpkBase.NewCpkService;
import jin.mes.form.cpk.cpkBase.CpkService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/cform/cpk/cpkVaneMonitor")
public class NewCpkVaneMonitorController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(NewCpkVaneMonitorController.class);

	@Resource
	protected NewCpkService newCpkService;
	
	/**
	 * 코드 그룹 리스트를 가지고 온다.
	 * 
	 * @param map - 리스트 조회 조건
	 * 
	 * @return String - viewName / 코드 그룹 리스트
	 */
	
	@RequestMapping("/getVaneMonitorList")
	public ModelMap getProdInfoList(@ModelAttribute("CpkVaneMonitorDto") NewCpkVaneMonitorDto cpkVaneMonitorDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(cpkVaneMonitorDto.getPage())));
		pageRequestVo.setRows(cpkVaneMonitorDto.getRows());

		setModelWithkendoList(model, newCpkService.getVaneMonitorList(cpkVaneMonitorDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getVaneOffsetList")
	public ModelMap getVaneOffsetList(@ModelAttribute("CpkVaneOffsetDto") NewCpkVaneOffsetDto cpkVaneOffsetDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(cpkVaneOffsetDto.getPage())));
		pageRequestVo.setRows(cpkVaneOffsetDto.getRows());

		setModelWithkendoList(model, newCpkService.getVaneOffsetList(cpkVaneOffsetDto, pageRequestVo));

		return model;
	}
}
