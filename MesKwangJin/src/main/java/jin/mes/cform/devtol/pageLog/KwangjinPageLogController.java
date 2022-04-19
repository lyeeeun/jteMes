package jin.mes.cform.devtol.pageLog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.devtol.pageLog.KwangjinPageLogDto;
import jin.mes.cform.devtol.pageLog.KwangjinPageLogService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cform/devtol/pageLog")
public class KwangjinPageLogController extends BaseController {
	@Autowired
	KwangjinPageLogService kwangjinpageLogService;
	
	@RequestMapping("getPageLogList")
	public ModelMap getPageLogList(ModelMap model, @ModelAttribute("KwangjinPageLogDto") KwangjinPageLogDto kwangjinPageLogDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(kwangjinPageLogDto.getPage())));
		pageRequestVo.setRows(kwangjinPageLogDto.getRows());
		try {
			setModelWithkendoList(model, kwangjinpageLogService.getPageLogList(kwangjinPageLogDto, pageRequestVo));
		} catch (Exception ex) {
			throw new BusinessException("페이지 접속 로그  조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("setPageLog")
	public ModelMap setPageLog(ModelMap model, @RequestBody KwangjinPageLogDto kwangjinPageLogDto) {
		try {
			kwangjinpageLogService.setPageLog(kwangjinPageLogDto);
		} catch (Exception ex) {
			throw new BusinessException("페이지 접속 저장 에러 : " + ex.getMessage());
		}
		return model;
	}
}
