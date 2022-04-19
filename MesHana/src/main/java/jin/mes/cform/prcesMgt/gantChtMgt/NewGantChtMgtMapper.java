package jin.mes.cform.prcesMgt.gantChtMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.prcesMgt.gantChtMgt.NewGantChtMgtDto;

@Mapper
public interface NewGantChtMgtMapper {
	public List<NewGantChtMgtDto> selectGanttChart(NewGantChtMgtDto newGantChtMgtDto);
}
