package jin.mes.cform.ship.shipPlanMgt;

import java.util.List;


public interface KwangjinShipPlanMgtMapper {

	public List<KwangjinShipPlanMgtDto> selectShipPlanList(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
	public int selectShipPlanCount(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
	public List<KwangjinShipPlanMgtDto> selectLotStockList(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
	public int selectLotStockCount(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
	public void insertShipPlan(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
	public void updateShipPlan(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
	public void deleteShipPlan(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
	public void updateShipInspect(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
	public void updateLotState(KwangjinShipPlanMgtDto kwangjinShipPlanMgtDto);
}
