package jin.mes.cform.cpk.cpkVaneMonitor;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.cpk.cpkBase.NewCpkService;
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
	public ModelMap getProdInfoList(@ModelAttribute("NewCpkVaneMonitorDto") NewCpkVaneMonitorDto newCpkVaneMonitorDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newCpkVaneMonitorDto.getPage())));
		pageRequestVo.setRows(newCpkVaneMonitorDto.getRows());

		setModelWithkendoList(model, newCpkService.getVaneMonitorList(newCpkVaneMonitorDto, pageRequestVo));

		return model;
	}
	
	@RequestMapping("/getVaneOffsetList")
	public ModelMap getVaneOffsetList(@ModelAttribute("NewCpkVaneOffsetDto") NewCpkVaneOffsetDto newcpkVaneOffsetDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newcpkVaneOffsetDto.getPage())));
		pageRequestVo.setRows(newcpkVaneOffsetDto.getRows());

		setModelWithkendoList(model, newCpkService.getVaneOffsetList(newcpkVaneOffsetDto, pageRequestVo));

		return model;
	}
}
