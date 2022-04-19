package jin.mes.cform.ship.shipMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.ship.shipMgt.KwangjinShipMgtDto;

@Mapper
public interface KwangjinShipMgtMapper {
	
	public List<KwangjinShipMgtDto> selectShipPlanList(KwangjinShipMgtDto kwangjinShipMgtDto);
	public int selectShipPlanCount(KwangjinShipMgtDto kwangjinShipMgtDto);
	
	public void insertShipInfo(KwangjinShipMgtDto kwangjinShipMgtDto);
	public void updateShipInfo(KwangjinShipMgtDto kwangjinShipMgtDto);
	
	public String selectLotState(KwangjinShipMgtDto kwangjinShipMgtDto);
	public void updateLotState(KwangjinShipMgtDto kwangjinShipMgtDto);
	public void updateShipInspect(KwangjinShipMgtDto kwangjinShipMgtDto);
	
	

}
