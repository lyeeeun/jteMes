package jin.mes.form.mfgMgt.wrkinTeamMgt;

import java.util.List;

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
@RequestMapping("/form/mfgMgt/wrkinTeamMgt")
public class WrkinTeamMgtController extends BaseController {

	@Autowired
	WrkinTeamMgtService asgnService;
	
	@RequestMapping("/getAsgnList")
	public ModelMap getAsgnList(ModelMap model, @ModelAttribute("asgnDto") WrkinTeamMgtDto asgnDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(asgnDto.getPage())));
		pageRequestVo.setRows(asgnDto.getRows());
		try {
			
			setModelWithkendoList(model, asgnService.getAsgnList(asgnDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getAsgnPop")
	public ModelMap getAsgnPop(ModelMap model, @ModelAttribute("asgnDto") WrkinTeamMgtDto asgnDto) {
		try {
			model.addAttribute("rows", asgnService.getAsgnPop(asgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 팝업 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setAsgnSave")
	@ResponseBody
	public String setAsgnSave(@RequestBody WrkinTeamMgtDto asgnDto) {
		return asgnService.setAsgnSave(asgnDto);
	}
	
	@RequestMapping("/setAsgnDelete")
	@ResponseBody
	public int setAsgnDelete(ModelMap model, @RequestBody List<WrkinTeamMgtDto> mtrlOrderList) {
		return asgnService.setAsgnDelete(mtrlOrderList);
	}
}
