package jin.mes.common.cache;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Controller
@RequestMapping("/cache")
public class CacheController extends BaseController {
	
	@Autowired
	CacheService cacheService;
	
	@RequestMapping("/getCacheList")
	public ModelMap getCacheList(ModelMap model) {
		try {
			CacheDto cacheDto = CacheUtil.getCacheList();
			model.addAttribute("result", cacheDto);
		} catch (Exception ex) {
			throw new BusinessException("캐시 조회   에러 : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setCacheDelete")
	public void setCacheDelete(ModelMap model) {
		try {
			cacheService.setCacheDelete();
		} catch (Exception ex) {
			throw new BusinessException("캐시 삭제   에러 : " + ex.getMessage());
		}
	}
}
