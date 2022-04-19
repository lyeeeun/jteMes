package jin.mes.cform.perform.performOrderChart;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.perform.performOrderChart.NewPerformOrderChartDto;

@Mapper
public interface NewPerformOrderChartMapper {
	public List<NewPerformOrderChartDto> selectPerformOrderInfo(NewPerformOrderChartDto newPerformOrderChartDto);
	public int rowCount(NewPerformOrderChartDto newPerformOrderChartDto);
	public List<NewPerformOrderChartDto> selectPerformTotalOrderInfo(NewPerformOrderChartDto newPerformOrderChartDto);
}