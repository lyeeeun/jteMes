package jin.mes.form.basMgt.codMgt.pageSet;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PageSetMapper {
	
	public List<PageSetDto> selectPageSetList(PageSetDto pageSetDto);
	
	public void insertPageSetSave(PageSetDto pageSetDto); 
	
	public void updatePageSetSave(PageSetDto pageSetDto);
	
	public void deletePageSet(PageSetDto pageSetDto);
	
	
	
	public List<PageSetDto> selectPageFieldList(PageSetDto pageSetDto);
	
	public void insertPageField(PageSetDto pageSetDto); 
	
	public void updatePageField(PageSetDto pageSetDto);
	
	public void deletePageField(PageSetDto pageSetDto);
}
