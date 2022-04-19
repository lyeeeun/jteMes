package jin.mes.form.basMgt.codMgt.popSet;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PopSetMapper {
	
	public List<PopSetDto> selectPopSetList(PopSetDto popSetDto);
	
	public void insertPopSetSave(PopSetDto popSetDto); 
	
	public void updatePopSetSave(PopSetDto popSetDto);
	
	public void deletePopSet(PopSetDto popSetDto);
}
