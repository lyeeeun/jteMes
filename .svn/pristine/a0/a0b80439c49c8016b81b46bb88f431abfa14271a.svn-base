package jin.mes.mapper.ship.shipPlanMgt;

import java.util.List;

import jin.mes.form.ship.shipPlanMgt.ShipPlanMgtDto;

public interface ShipPlanMgtMapper {
//	public List<ShipPlanMgtDto> selectLotInfo(ShipPlanMgtDto shipPlanMgtDto);
//	public int selectLotInfoCount(ShipPlanMgtDto shipPlanMgtDto);
	
	public List<ShipPlanMgtDto> selectShipPlanList(ShipPlanMgtDto shipPlanMgtDto);
	public int rowCount(ShipPlanMgtDto shipPlanMgtDto);
	
	public List<ShipPlanMgtDto> selectShipCompList(ShipPlanMgtDto shipPlanMgtDto);
	public int selectShipCompCount(ShipPlanMgtDto shipPlanMgtDto);
	
	public void insertShipPlan(ShipPlanMgtDto shipPlanMgtDto);
	public void updateShipPlan(ShipPlanMgtDto shipPlanMgtDto);
	public int deleteShipPlan(ShipPlanMgtDto shipPlanMgtDto);
	
	public int selectShipCompleteQty(ShipPlanMgtDto shipPlanMgtDto);
	
	public List<ShipPlanMgtDto> selectRtlBundleList(ShipPlanMgtDto shipPlanMgtDto);
	
	public void insertBundleList(String shipId, int bundleQty, String bundleUnit);
	public void updateBundleList(String shipId, int bundleQty, String bundleUnit);
	public void deleteBundleList(String shipId, int bundleQty, String bundleUnit);
	
	public void deleteAllBundleList(String shipId);
	
	
}
