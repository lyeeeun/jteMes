package jin.mes.form.prcesMgt.gantChtMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.mapper.prcesMgt.gantChtMgt.GantChtMgtMapper;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class GantChtMgtService {
	
	@Resource
	GantChtMgtMapper gantChtMgtMapper;
	
	public List<GantChtMgtDto> getGanttChart(GantChtMgtDto gantChtMgtDto) {
		
		List<GantChtMgtDto> ganttChartList;
		try {
			ganttChartList = gantChtMgtMapper.selectGanttChart(gantChtMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getGanttChart Error " + e.getMessage());
		}
		
		return ganttChartList;
	}
}
