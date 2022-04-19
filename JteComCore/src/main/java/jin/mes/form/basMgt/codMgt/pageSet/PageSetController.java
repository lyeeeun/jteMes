package jin.mes.form.basMgt.codMgt.pageSet;

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
@RequestMapping("/form/basMgt/codMgt/pageSet")
public class PageSetController extends BaseController{
	
	@Autowired 
	PageSetService pageSetService;
	
	//페이지 세팅 - 그리드 정보 조회
	@RequestMapping("/getPageSetList")
	public ModelMap getPageSetList(ModelMap modelMap, @ModelAttribute PageSetDto pageSetDto){
		try {
			modelMap.addAttribute("rows", pageSetService.getPageSetList(pageSetDto));
		} catch (Exception e) {
			throw new BusinessException("페이지 세팅 조회 에러입니다.\n" + e.getMessage());
		}
		return modelMap;
	}
	
	//페이지 세팅 - 그리드 정보 등록/수정
	@RequestMapping("/setPageSetSave")
	@ResponseBody
	public PageSetDto setPageSetSave(@RequestBody PageSetDto pageSetDto) {
		return pageSetService.setPageSetSave(pageSetDto);
	}
	
	//페이지 세팅 - 그리드 정보 삭제
	@RequestMapping("/setPageSetDelete")
	@ResponseBody
	public String setPageSetDelete(@RequestBody PageSetDto pageSetDto) {
		return pageSetService.setPageSetDelete(pageSetDto);
	}
	
	//페이지 세팅 - 그리드 정보 삭제
	@RequestMapping("/setPageCopyMenu")
	@ResponseBody
	public String setPageCopyMenu(@RequestBody PageSetDto pageSetDto) {
		return pageSetService.setPageCopyMenu(pageSetDto);
	}
		
	
	//페이지 세팅 - 필드 정보 조회
	@RequestMapping("/getPageFieldList")
	public ModelMap getPageFieldList(ModelMap modelMap, @RequestBody PageSetDto pageSetDto){
		try {
			modelMap.addAttribute("rows", pageSetService.getPageFieldList(pageSetDto));
		} catch (Exception e) {
			throw new BusinessException("페이지 필드 조회 에러입니다.\n" + e.getMessage());
		}
		return modelMap;
	}
	//페이지 세팅 - 필드 정보 등록/수정
	@RequestMapping("/setPageFieldSave")
	@ResponseBody
	public String setPageFieldSave(@RequestBody PageSetDto pageSetDto) {
		return pageSetService.setPageFieldSave(pageSetDto);
	}
	
	//페이지 세팅 - 필드 정보 삭제
	@RequestMapping("/setPageFieldDelete")
	@ResponseBody
	public String setPageFieldDelete(@RequestBody PageSetDto pageSetDto) {
		return pageSetService.setPageFieldDelete(pageSetDto);
	}
	
}
