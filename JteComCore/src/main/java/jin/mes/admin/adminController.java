package jin.mes.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jin.mes.common.menu.MenuService;
import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoService;

@Controller
@RequestMapping("/admin")
public class adminController {
	
	@Autowired
	protected MenuService menuService;
	
	@Autowired MenuInfoService MenuInfoService;
	
	@RequestMapping("/main")
	public ModelAndView adminMain(ModelAndView model) {
		model.setViewName("/admin/main");
		
		
		return model;
	}
	
	@RequestMapping("/menu")
	public ModelMap adminMenu(ModelMap model) {
		
		model.addAttribute("rows", MenuInfoService.getAdminMenu());
		
		return model;
	}
	
}
