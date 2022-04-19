package jin.mes.form.devtol.pageLog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/devtol/pageLog")
public class PageLogController extends BaseController {
	@Autowired
	PageLogService pageLogService;
	
	@RequestMapping("getPageLogList")
	public ModelMap getPageLogList(ModelMap model, @ModelAttribute("pageLogDto") PageLogDto pageLogDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(pageLogDto.getPage())));
		pageRequestVo.setRows(pageLogDto.getRows());
		try {
			setModelWithkendoList(model, pageLogService.getPageLogList(pageLogDto, pageRequestVo));
		} catch (Exception ex) {
			throw new BusinessException("페이지 접속 로그  조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("setPageLog")
	public ModelMap setPageLog(ModelMap model, @RequestBody PageLogDto pageLogDto) {
		try {
			pageLogService.setPageLog(pageLogDto);
		} catch (Exception ex) {
			throw new BusinessException("페이지 접속 저장 에러 : " + ex.getMessage());
		}
		return model;
	}
}
