package jin.mes.cform.ship.shipMgt;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.ship.shipMgt.NewShipMgtDto;

@Mapper
public interface NewShipMgtMapper {
	public void shipStateUpdate(NewShipMgtDto shipMgtDto);
	public void lotStateUpdate(NewShipMgtDto shipMgtDto);
	public void updateAfterCost(NewShipMgtDto shipMgtDto);
	
	public int selectLotQty(NewShipMgtDto shipMgtDto);
	public int selectPackageStock(NewShipMgtDto shipMgtDto);
	
}
