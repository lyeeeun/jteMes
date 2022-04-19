package jin.mes.cform.perform.performItem;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.perform.performItem.NewPerformItemDto;

@Mapper
public interface NewPerformItemMapper {
	public List<NewPerformItemDto> selectPerformItem(NewPerformItemDto newPerformItemDto);
	public int selectPerformItemCount(NewPerformItemDto newPerformItemDto);
	
	public List<NewPerformItemDto> selectKpiDefect(NewPerformItemDto newPerformItemDto);
}