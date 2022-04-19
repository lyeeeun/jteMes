package jin.mes.form.perform.workStaMgt.lotProStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/perform/workStaMgt/lotProStatus")
public class LotProStatusController extends BaseController {
	
	@Autowired
	LotProStatusService lotProStatusService;
	
	@RequestMapping("getLotProgressList")
	public ModelMap getLotProgressList(ModelMap model, @ModelAttribute("lotProStatusDto") LotProStatusDto lotProStatusDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(lotProStatusDto.getPage())));
		pageRequestVo.setRows(lotProStatusDto.getRows());
		
		try {
			setModelWithkendoList(model, lotProStatusService.getLotProgressList(lotProStatusDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("LoT 조회 에러 : " + ex.getMessage());
		}
		return model;
	}	
}
