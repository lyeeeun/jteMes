package jin.mes.common.cache;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import jin.mes.form.basMgt.codMgt.pageSet.PageSetDto;
import jin.mes.form.basMgt.codMgt.popSet.PopSetDto;
import jin.mes.form.basMgt.menuMgt.menuInfo.MenuInfoDto;

@Mapper
public interface CacheMapper {	
	/* 기초설정 */
	public List<BaseCodeMgtDto> selectCacheSet();
	
	/* 기초코드 */
	public List<BaseCodeMgtDto> selectCacheCode();
	
	/* 메뉴 */
	public List<MenuInfoDto> selectCacheMenu();
	
	/* 페이지 정보 - 그리드 */
	public List<PageSetDto> selectCachePageGrid();
	
	/* 페이지 정보 - 필드 */
	public List<PageSetDto> selectCachePageField();
	
	public List<PopSetDto> selectCachePopInfo();
	
}
