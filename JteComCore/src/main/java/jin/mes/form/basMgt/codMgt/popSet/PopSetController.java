package jin.mes.form.basMgt.codMgt.popSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/form/basMgt/codMgt/popSet")
public class PopSetController extends BaseController{
	
	@Autowired 
	PopSetService popSetService;
	
	//팝업 세팅 - 조회
	@RequestMapping("/getPopSetList")
	public ModelMap getPopSetList(ModelMap modelMap, @ModelAttribute PopSetDto PageSetDto){
		try {
			modelMap.addAttribute("rows", popSetService.getPopSetList(PageSetDto));
		} catch (Exception e) {
			throw new BusinessException("팝업 세팅 - 조회에러입니다 \n" + e.getMessage());
		}
		return modelMap;
	}
	
	//팝업 세팅 - 저장/수정
	@RequestMapping("/setPopSetSave")
	@ResponseBody
	public String setPopSetSave(@RequestBody PopSetDto popSetDto) {
		return popSetService.setPopSetSave(popSetDto);
	}
	//팝업 세팅 - 삭제
	@RequestMapping("/setPopSetDelete")
	@ResponseBody
	public String setPopSetDelete(@RequestBody PopSetDto popSetDto) {
		return popSetService.setPopSetDelete(popSetDto);
	}
}
