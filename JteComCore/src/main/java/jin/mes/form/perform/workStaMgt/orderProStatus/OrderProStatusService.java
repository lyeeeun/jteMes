package jin.mes.form.perform.workStaMgt.orderProStatus;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class OrderProStatusService {
	@Resource
    protected OrderProStatusMapper orderProStatusMapper;

	public List<OrderProStatusDto> getOrderChart(OrderProStatusDto orderProStatusDto){
		List<OrderProStatusDto> performOrderInfo = null;
		try {
			performOrderInfo = orderProStatusMapper.selectOrderInfo(orderProStatusDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getPerformOrderChart Error " + e.getMessage());
		}
		return performOrderInfo;
	}
	
	public List<OrderProStatusDto> getTotalOrderChart(OrderProStatusDto orderProStatusDto){
		List<OrderProStatusDto> performOrderInfo = null;
		try {
			performOrderInfo = orderProStatusMapper.selectTotalOrderInfo(orderProStatusDto);
		} catch (Exception e) {
			throw new BusinessException("Service: getPerformOrderChart Error " + e.getMessage());
		}
		return performOrderInfo;
	}
}
