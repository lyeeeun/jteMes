package jin.mes.form.pick.rlesRecord;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/form/pick/rlesRecord")
public class RlesRecordController extends BaseController {
	@Resource
	protected RlesRecordService rlesRecordService;

	@RequestMapping("/getRlesRecordList")
	public ModelMap getRlesRecordList(@ModelAttribute("rlesRecordDto") RlesRecordDto rlesRecordDto, ModelMap model) {
		
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(rlesRecordDto.getPage())));
		pageRequestVo.setRows(rlesRecordDto.getRows());

		setModelWithkendoList(model, rlesRecordService.getRlesRecordList(rlesRecordDto, pageRequestVo));

		return model;
	}
	
}
