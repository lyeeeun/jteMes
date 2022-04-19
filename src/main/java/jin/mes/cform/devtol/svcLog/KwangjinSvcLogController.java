package jin.mes.cform.devtol.svcLog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.cform.devtol.svcLog.KwangjinSvcLogDto;
import jin.mes.cform.devtol.svcLog.KwangjinSvcLogService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/devtol/svcLog")
public class KwangjinSvcLogController extends BaseController {
	@Autowired
	KwangjinSvcLogService kwangjinSvcLogService;
	
	@RequestMapping("getSvcLogList")
	public ModelMap getSvcLogList(ModelMap model, @ModelAttribute("kwangjinSvcLogDto") KwangjinSvcLogDto kwangjinSvcLogDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinSvcLogDto.getPage())));
		pageRequestVo.setRows(kwangjinSvcLogDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinSvcLogService.getSvcLogList(kwangjinSvcLogDto, pageRequestVo));
		} catch (Exception ex) {
			throw new BusinessException("서비스 이력 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("setSvcLog")
	@ResponseBody
	public long setSvcLog(@RequestBody KwangjinSvcLogDto kwangjinSvcLogDto) {
		long result = 0;
		try {
			result = kwangjinSvcLogService.setSvcLog(kwangjinSvcLogDto);
		} catch (Exception ex) {
			throw new BusinessException("서비스 이력 저장 에러 : " + ex.getMessage());
		}
		return result;
	}
}
