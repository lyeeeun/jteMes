package jin.mes.form.perform.performOrderChart;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class PerformOrderChartService {

	@Resource
    protected PerformOrderChartMapper performOrderChartMapper;

	public List<PerformOrderChartDto> getPerformOrderChart(PerformOrderChartDto performOrderChartDto){
		List<PerformOrderChartDto> performOrderInfo = null;
		try {
			performOrderInfo = performOrderChartMapper.selectPerformOrderInfo(performOrderChartDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getPerformOrderChart Error " + e.getMessage());
		}
		return performOrderInfo;
	}
	
	public List<PerformOrderChartDto> getPerformTotalOrderChart(PerformOrderChartDto performOrderChartDto){
		List<PerformOrderChartDto> performOrderInfo = null;
		try {
			performOrderInfo = performOrderChartMapper.selectPerformTotalOrderInfo(performOrderChartDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getPerformOrderChart Error " + e.getMessage());
		}
		return performOrderInfo;
	}
	
}
