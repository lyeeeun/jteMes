package jin.mes.form.ship.shipMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.ship.pickMgt.PickMgtDto;

@Mapper
public interface ShipMgtMapper {
	
	public List<ShipMgtDto> selectShipPlanList(ShipMgtDto shipMgtDto);
	public int selectShipPlanCount(ShipMgtDto shipMgtDto);
	
	public void insertShipInfo(ShipMgtDto shipMgtDto);
	public void updateShipInfo(ShipMgtDto shipMgtDto);
	
	public String selectLotState(ShipMgtDto shipMgtDto);
	public void updateLotState(ShipMgtDto shipMgtDto);
	public void updateShipInspect(ShipMgtDto shipMgtDto);
	
	

}
