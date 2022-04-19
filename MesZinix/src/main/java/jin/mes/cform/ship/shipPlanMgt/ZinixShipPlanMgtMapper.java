package jin.mes.cform.ship.shipPlanMgt;

import java.util.List;

public interface ZinixShipPlanMgtMapper {

	public List<ZinixShipPlanMgtDto> selectShipPlanList(ZinixShipPlanMgtDto planDto);
	
	public int selectShipPlanCount(ZinixShipPlanMgtDto planDto);
	
	public List<ZinixShipPlanMgtDto> selectShipPlanDetail(ZinixShipPlanMgtDto planDto);

	public void insertShipPlan(ZinixShipPlanMgtDto planDto);
	
	public void updateShipPlan(ZinixShipPlanMgtDto planDto);
	
	public void deleteShipPlan(ZinixShipPlanMgtDto planDto);
	
	
	public List<ZinixShipPlanMgtDto> selectShipCompList(ZinixShipPlanMgtDto planDto);
	public int selectShipCompCount(ZinixShipPlanMgtDto planDto);
}