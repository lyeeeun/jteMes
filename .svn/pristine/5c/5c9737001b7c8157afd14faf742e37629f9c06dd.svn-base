package jin.mes.form.ship.orderCompleteMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.ship.orderCompleteMgt.OrderCompleteMgtDto;
import jin.mes.form.ship.shipMgt.ShipMgtDto;

@Mapper
public interface OrderCompleteMgtMapper {
	public List<OrderCompleteMgtDto> selectOrderList(OrderCompleteMgtDto orderCompleteMgtDto);
	public int selectOrderCount(OrderCompleteMgtDto orderCompleteMgtDto);
	
	public List<OrderCompleteMgtDto> selectProcShiftTable(OrderCompleteMgtDto orderCompleteMgtDto);
	public List<OrderCompleteMgtDto> selectReturnSurplusMtrl(OrderCompleteMgtDto orderCompleteMgtDto);
	
	public List<ShipMgtDto>selectNotCompleteLot(ShipMgtDto shipMgtDto);
	
	public void orderStateUpdate(ShipMgtDto shipMgtDto);
	
}
