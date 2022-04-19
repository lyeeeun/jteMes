package jin.mes.cform.ship.orderCompleteMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.ship.shipMgt.NewShipMgtDto;

@Mapper
public interface NewOrderCompleteMgtMapper {
	public List<NewOrderCompleteMgtDto> selectOrderList(NewOrderCompleteMgtDto orderCompleteMgtDto);
	public int selectOrderCount(NewOrderCompleteMgtDto orderCompleteMgtDto);
	
	public List<NewOrderCompleteMgtDto> selectProcShiftTable(NewOrderCompleteMgtDto orderCompleteMgtDto);
	public List<NewOrderCompleteMgtDto> selectReturnSurplusMtrl(NewOrderCompleteMgtDto orderCompleteMgtDto);
	
	public List<NewShipMgtDto>selectNotCompleteLot(NewShipMgtDto shipMgtDto);
	
	public void orderStateUpdate(NewShipMgtDto shipMgtDto);
	
}
