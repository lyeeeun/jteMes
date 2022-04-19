package jin.mes.cform.perform.itemAggregation;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ZinixItemAggregationMapper {
	public List<ZinixItemAggregationDto> selectItemAggregation(ZinixItemAggregationDto zinixItemAggregationDto);
	public int selectItemAggregationCount(ZinixItemAggregationDto zinixItemAggregationDto);
}