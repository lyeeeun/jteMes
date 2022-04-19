package jin.mes.mapper.ship.shipMgt;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.ship.shipMgt.ShipMgtDto;

@Mapper
public interface ShipMgtMapper {
	public void shipStateUpdate(ShipMgtDto shipMgtDto);
	public void lotStateUpdate(ShipMgtDto shipMgtDto);
	public void updateAfterCost(ShipMgtDto shipMgtDto);
	
	public int selectLotQty(ShipMgtDto shipMgtDto);
	public int selectPackageStock(ShipMgtDto shipMgtDto);
	
}
