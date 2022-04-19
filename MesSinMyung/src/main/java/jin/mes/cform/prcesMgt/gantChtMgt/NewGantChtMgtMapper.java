package jin.mes.cform.prcesMgt.gantChtMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewGantChtMgtMapper {
	public List<NewGantChtMgtDto> selectGanttChart(NewGantChtMgtDto gantChtMgtDto);
}
