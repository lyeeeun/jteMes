package jin.mes.mapper.basMgt.menuMgt.menuInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;

@Mapper
public interface MenuInfoMapper {
	
	public List<MenuInfoDto> selectMenuTree(MenuInfoDto menuInfoDto);
	
	public List<MenuInfoDto> selectMenuList(MenuInfoDto menuInfoDto);
	
	public int selectMenuListCount(MenuInfoDto menuInfoDto);
	
	public int insertMenuInfo(MenuInfoDto menuInfoDto);
	
	public int updateMenuInfo(MenuInfoDto menuInfoDto);
}
