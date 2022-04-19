package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.bom.bomMgt.ZinixBomMgtDto;
import jin.mes.cform.basMgt.operMgt.facilMgt.ZinixFacilMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.ZinixRoutingMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.ZinixRoutingRtlToolDto;

@Mapper
public interface ZinixRoutingMgtMapper {
	public List<ZinixRoutingMgtDto> selectRoutingInfo(ZinixRoutingMgtDto routingMgtDto);
	
	public void insertRoutingInfo(ZinixRoutingMgtDto routingMgtDto);
	public void updateRoutingInfo(ZinixRoutingMgtDto routingMgtDto);
	public void deleteRoutingInfo(ZinixRoutingMgtDto routingMgtDto);
	
	public List<ZinixBomMgtDto> selectRtlBomList(ZinixRoutingMgtDto routingMgtDto);
	
	public void insertRtlBomList(String bomId, String routingId);
	public void deleteRtlBomList(String bomId, String routingId);
	
	public List<ZinixFacilMgtDto> selectRtlEqmtList(ZinixRoutingMgtDto routingMgtDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String routingId);
	public void deleteRtlEquipment(String eqmtMgtId, String routingId);
	
	public void updateEqmtAllFalse(ZinixRoutingMgtDto routingMgtDto);
	public void updateEqmtTrue(ZinixRoutingMgtDto routingMgtDto);
	
	public List<ZinixRoutingRtlToolDto> selectRtlToolList(ZinixRoutingMgtDto routingMgtDto);
	
	public void insertRtlToolList(ZinixRoutingRtlToolDto rtlToolDto);
	public void updateRtlToolList(ZinixRoutingRtlToolDto rtlToolDto);
	public void deleteRtlToolList(ZinixRoutingRtlToolDto rtlToolDto);
	
}
