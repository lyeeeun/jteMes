package jin.mes.cform.mfgMgt.wrkinTeamMgt;

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
@RequestMapping("/cform/mfgMgt/wrkinTeamMgt")
public class NewWrkinTeamMgtController extends BaseController {

	@Autowired
	NewWrkinTeamMgtService newAsgnService;
	
	@RequestMapping("/getAsgnList")
	public ModelMap getAsgnList(ModelMap model, @ModelAttribute("newAsgnDto") NewWrkinTeamMgtDto newAsgnDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(newAsgnDto.getPage())));
		pageRequestVo.setRows(newAsgnDto.getRows());
		try {
			
			setModelWithkendoList(model, newAsgnService.getAsgnList(newAsgnDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 조회 에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/getAsgnPop")
	public ModelMap getAsgnPop(ModelMap model, @ModelAttribute("newAsgnDto") NewWrkinTeamMgtDto newAsgnDto) {
		try {
			model.addAttribute("rows", newAsgnService.getAsgnPop(newAsgnDto));
		}catch(Exception ex) {
			throw new BusinessException("작업지시 팝업 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setAsgnSave")
	@ResponseBody
	public String setAsgnSave(@RequestBody NewWrkinTeamMgtDto newAsgnDto) {
		return newAsgnService.setAsgnSave(newAsgnDto);
	}
	
	@RequestMapping("/setAsgnDelete")
	@ResponseBody
	public int setAsgnDelete(ModelMap model, @RequestBody List<NewWrkinTeamMgtDto> mtrlOrderList) {
		return newAsgnService.setAsgnDelete(mtrlOrderList);
	}
}
