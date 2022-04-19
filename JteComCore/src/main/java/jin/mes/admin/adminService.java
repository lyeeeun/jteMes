package jin.mes.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jin.mes.common.menu.MenuService;
import jin.mes.common.menu.MyMenuVo;

@Service
public class adminService {

	@Autowired
	protected MenuService menuService;
	
	
	public List<MyMenuVo> getAdminMenu(){
		return menuService.getAdminMenu(); 
	}
	 
	
}
