package jin.mes.cform.ship.shipPlanMgt;

import java.util.List;

import jin.mes.cform.ship.shipPlanMgt.NewShipPlanMgtDto;

public interface NewShipPlanMgtMapper {
//	public List<ShipPlanMgtDto> selectLotInfo(ShipPlanMgtDto shipPlanMgtDto);
//	public int selectLotInfoCount(ShipPlanMgtDto shipPlanMgtDto);
	
	public List<NewShipPlanMgtDto> selectShipPlanList(NewShipPlanMgtDto shipPlanMgtDto);
	public int rowCount(NewShipPlanMgtDto shipPlanMgtDto);
	
	public List<NewShipPlanMgtDto> selectShipCompList(NewShipPlanMgtDto shipPlanMgtDto);
	public int selectShipCompCount(NewShipPlanMgtDto shipPlanMgtDto);
	
	public void insertShipPlan(NewShipPlanMgtDto shipPlanMgtDto);
	public void updateShipPlan(NewShipPlanMgtDto shipPlanMgtDto);
	public int deleteShipPlan(NewShipPlanMgtDto shipPlanMgtDto);
	
	public int selectShipCompleteQty(NewShipPlanMgtDto shipPlanMgtDto);
	
	public List<NewShipPlanMgtDto> selectRtlBundleList(NewShipPlanMgtDto shipPlanMgtDto);
	
	public void insertBundleList(String shipId, int bundleQty, String bundleUnit);
	public void updateBundleList(String shipId, int bundleQty, String bundleUnit);
	public void deleteBundleList(String shipId, int bundleQty, String bundleUnit);
	
	public void deleteAllBundleList(String shipId);
	
	
}
