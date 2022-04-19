package jin.mes.form.basMgt.menuMgt.menuAuth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jin.mes.form.basMgt.authMgt.grpAuth.RoleMgtServiceImpl;
import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;
import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.KendoPageVO;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/form/basMgt/menuMgt/menuAuth")
@Slf4j
public class MenuMgtController extends BaseController{
	
	@Autowired
	MenuMgtServiceImpl menuMgtService;
	
	@Autowired
	RoleMgtServiceImpl roleMgtService;
	
	@RequestMapping("/getAuthList")
	public ModelMap getAuthList(ModelMap model, @ModelAttribute KendoPageVO pageVO) {
		try {
			setModelWithkendoList(model,roleMgtService.getRoleGrp(pageVO));
		}catch(Exception ex) {
			throw new BusinessException("조회에러입니다.  : " + ex.getMessage());
		}
		return model;
	}
	
	@RequestMapping("getMenuRoleTree")
	public ResponseEntity<Object> getMenuRoleTree(@ModelAttribute("menuInfoDto") MenuInfoDto menuInfoDto) {
		return new ResponseEntity<Object>(menuMgtService.getMenuRoleTree(menuInfoDto), HttpStatus.OK);
	}
	
	@RequestMapping("/setMenuRoleSave")
	@ResponseBody
	public int setMenuRoleSave(ModelMap model, @ModelAttribute("menuInfoDto") MenuInfoDto menuInfoDto) {
		return menuMgtService.setMenuRoleSave(menuInfoDto);
	}
}
