package jin.mes.form.ship.shipPlanMgt;

import java.util.List;

public interface ShipPlanMgtMapper {

	public List<ShipPlanMgtDto> selectShipPlanList(ShipPlanMgtDto shipPlanMgtDto);
	public int selectShipPlanCount(ShipPlanMgtDto shipPlanMgtDto);
	public List<ShipPlanMgtDto> selectLotStockList(ShipPlanMgtDto shipPlanMgtDto);
	public int selectLotStockCount(ShipPlanMgtDto shipPlanMgtDto);
	public void insertShipPlan(ShipPlanMgtDto shipPlanMgtDto);
	public void updateShipPlan(ShipPlanMgtDto shipPlanMgtDto);
	public void deleteShipPlan(ShipPlanMgtDto shipPlanMgtDto);
}
