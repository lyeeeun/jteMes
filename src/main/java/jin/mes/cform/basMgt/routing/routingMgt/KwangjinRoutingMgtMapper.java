package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.bom.bomMgt.KwangjinBomMgtDto;
import jin.mes.cform.basMgt.operMgt.facilMgt.KwangjinFacilMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.KwangjinRoutingMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.KwangjinRoutingRtlToolDto;

@Mapper
public interface KwangjinRoutingMgtMapper {
	public List<KwangjinRoutingMgtDto> selectRoutingInfo(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	
	public void insertRoutingInfo(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	public void updateRoutingInfo(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	public void deleteRoutingInfo(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	
	public List<KwangjinBomMgtDto> selectRtlBomList(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	
	public void insertRtlBomList(String bomId, String routingId);
	public void deleteRtlBomList(String bomId, String routingId);
	
	public List<KwangjinFacilMgtDto> selectRtlEqmtList(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String routingId);
	public void deleteRtlEquipment(String eqmtMgtId, String routingId);
	
	public void updateEqmtAllFalse(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	public void updateEqmtTrue(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	
	public List<KwangjinRoutingRtlToolDto> selectRtlToolList(KwangjinRoutingMgtDto kwangjinRoutingMgtDto);
	
	public void insertRtlToolList(KwangjinRoutingRtlToolDto kwangjinRoutingRtlToolDto);
	public void updateRtlToolList(KwangjinRoutingRtlToolDto kwangjinRoutingRtlToolDto);
	public void deleteRtlToolList(KwangjinRoutingRtlToolDto kwangjinRoutingRtlToolDto);
	
}
