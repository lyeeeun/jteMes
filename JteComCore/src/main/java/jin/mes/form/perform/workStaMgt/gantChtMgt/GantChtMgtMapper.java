package jin.mes.form.perform.workStaMgt.gantChtMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.perform.workStaMgt.gantChtMgt.GantChtMgtDto;

@Mapper
public interface GantChtMgtMapper {
	public List<GantChtMgtDto> selectGanttChart(GantChtMgtDto gantChtMgtDto);
}
