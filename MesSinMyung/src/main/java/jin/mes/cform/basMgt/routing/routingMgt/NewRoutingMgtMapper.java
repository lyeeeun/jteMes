package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.bom.bomMgt.NewBomMgtDto;
import jin.mes.cform.basMgt.operMgt.facilMgt.NewFacilMgtDto;

@Mapper
public interface NewRoutingMgtMapper {
	public List<NewRoutingMgtDto> selectRoutingInfo(NewRoutingMgtDto routingMgtDto);
	
	public void insertRoutingInfo(NewRoutingMgtDto routingMgtDto);
	public void updateRoutingInfo(NewRoutingMgtDto routingMgtDto);
	public void deleteRoutingInfo(NewRoutingMgtDto routingMgtDto);
	
	public List<NewBomMgtDto> selectRtlBomList(NewRoutingMgtDto routingMgtDto);
	
	public void insertRtlBomList(String bomId, String routingId);
	public void deleteRtlBomList(String bomId, String routingId);
	
	public List<NewFacilMgtDto> selectRtlEqmtList(NewRoutingMgtDto routingMgtDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String routingId);
	public void deleteRtlEquipment(String eqmtMgtId, String routingId);
	
	public List<NewRoutingRtlToolDto> selectRtlToolList(NewRoutingRtlToolDto routingRtlToolDto);
	
	public void insertRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	public void updateRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	public void deleteRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	
}
