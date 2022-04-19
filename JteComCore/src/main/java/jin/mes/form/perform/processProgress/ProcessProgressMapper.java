package jin.mes.form.perform.processProgress;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProcessProgressMapper {
	public List<ProcessProgressDto> selectPerformItem(ProcessProgressDto processProgressDto);
	public int selectPerformItemCount(ProcessProgressDto processProgressDto);
	
	public List<ProcessProgressDto> selectKpiDefect(ProcessProgressDto processProgressDto);
}