package jin.mes.cform.perform.performOrderChart;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewPerformOrderChartService {

	@Resource
    protected NewPerformOrderChartMapper newPerformOrderChartMapper;

	public List<NewPerformOrderChartDto> getPerformOrderChart(NewPerformOrderChartDto performOrderChartDto){
		List<NewPerformOrderChartDto> performOrderInfo = null;
		try {
			performOrderInfo = newPerformOrderChartMapper.selectPerformOrderInfo(performOrderChartDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getPerformOrderChart Error " + e.getMessage());
		}
		return performOrderInfo;
	}
	
	public List<NewPerformOrderChartDto> getPerformTotalOrderChart(NewPerformOrderChartDto performOrderChartDto){
		List<NewPerformOrderChartDto> performOrderInfo = null;
		try {
			performOrderInfo = newPerformOrderChartMapper.selectPerformTotalOrderInfo(performOrderChartDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getPerformOrderChart Error " + e.getMessage());
		}
		return performOrderInfo;
	}
	
}
