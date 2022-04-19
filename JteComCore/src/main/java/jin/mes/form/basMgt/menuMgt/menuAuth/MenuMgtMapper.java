package jin.mes.form.basMgt.menuMgt.menuAuth;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;

@Mapper
public interface MenuMgtMapper {
	
	public List<MenuInfoDto> selectMenuRoleTree(MenuInfoDto menuInfoDto);

	public int insertMenuRole(MenuInfoDto menuInfoDto);
	
	public int deleteMenuRole(MenuInfoDto menuInfoDto);
}
