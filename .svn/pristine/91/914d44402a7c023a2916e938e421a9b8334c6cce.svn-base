package jin.mes.cform.prcesMgt.gantChtMgt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewGantChtMgtService {
	
	@Resource
	NewGantChtMgtMapper newGantChtMgtMapper;
	
	public List<NewGantChtMgtDto> getGanttChart(NewGantChtMgtDto gantChtMgtDto) {
		
		List<NewGantChtMgtDto> ganttChartList;
		try {
			ganttChartList = newGantChtMgtMapper.selectGanttChart(gantChtMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getGanttChart Error " + e.getMessage());
		}
		
		return ganttChartList;
	}
}
