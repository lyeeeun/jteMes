package jin.mes.cform.perform.performItem;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewPerformItemMapper {
	public List<NewPerformItemDto> selectPerformItem(NewPerformItemDto performItemDto);
	public int selectPerformItemCount(NewPerformItemDto performItemDto);
	
	public List<NewPerformItemDto> selectKpiDefect(NewPerformItemDto performItemDto);
}