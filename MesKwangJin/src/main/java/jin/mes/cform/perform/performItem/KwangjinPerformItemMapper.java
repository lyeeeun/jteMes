package jin.mes.cform.perform.performItem;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.perform.performItem.KwangjinPerformItemDto;

@Mapper
public interface KwangjinPerformItemMapper {
	public List<KwangjinPerformItemDto> selectPerformItem(KwangjinPerformItemDto kwangjinPerformItemDto);
	public int selectPerformItemCount(KwangjinPerformItemDto kwangjinPerformItemDto);
	
	public List<KwangjinPerformItemDto> selectKpiDefect(KwangjinPerformItemDto kwangjinPerformItemDto);
}