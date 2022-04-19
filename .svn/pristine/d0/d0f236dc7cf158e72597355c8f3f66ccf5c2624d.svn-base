package jin.mes.form.basMgt.menuMgt.menuInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
@RequestMapping("/form/basMgt/menuMgt/menuInfo")
public class MenuInfoController extends BaseController {

	@Autowired
	MenuInfoService menuInfoService;
	
	@RequestMapping("getMenuTree")
	public ResponseEntity<Object> getMenuTree(@ModelAttribute("menuInfoDto") MenuInfoDto menuInfoDto) {
		return new ResponseEntity<Object>(menuInfoService.getMenuTree(menuInfoDto), HttpStatus.OK);
	}
	
	@RequestMapping("getMenuList")
	public ModelMap getMenuList(ModelMap model, @ModelAttribute("menuInfoDto") MenuInfoDto menuInfoDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(menuInfoDto.getPage())));
		pageRequestVo.setRows(menuInfoDto.getRows());
		
		try {
			setModelWithkendoList(model, menuInfoService.getMenuList(menuInfoDto,pageRequestVo));
		}catch(Exception ex) {
			throw new BusinessException("메뉴 조회 에러  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("/setMenuSave")
	@ResponseBody
	public int setMenuSave(ModelMap model, @RequestBody MenuInfoDto menuInfoDto) {
		return menuInfoService.setMenuSave(menuInfoDto);
	}
}
