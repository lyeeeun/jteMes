package jin.mes.form.devtol.svcLog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/devtol/svcLog")
public class SvcLogController extends BaseController {
	@Autowired
	SvcLogService svcLogService;
	
	@RequestMapping("getSvcLogList")
	public ModelMap getSvcLogList(ModelMap model, @ModelAttribute("svcLogDto") SvcLogDto svcLogDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(svcLogDto.getPage())));
		pageRequestVo.setRows(svcLogDto.getRows());
		try {
			setModelWithkendoList(model, svcLogService.getSvcLogList(svcLogDto, pageRequestVo));
		} catch (Exception ex) {
			throw new BusinessException("서비스 이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("setSvcLog")
	@ResponseBody
	public long setSvcLog(@RequestBody SvcLogDto svcLogDto) {
		long result = 0;
		try {
			result = svcLogService.setSvcLog(svcLogDto);
		} catch (Exception ex) {
			throw new BusinessException("서비스 이력 저장 에러 : " + ex.getMessage());
		}
		return result;
	}
}
