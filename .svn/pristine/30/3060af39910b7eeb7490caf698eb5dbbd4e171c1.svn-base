package jin.mes.mapper.basMgt.routing.routingMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingRtlToolDto;

@Mapper
public interface RoutingMgtMapper {
	public List<RoutingMgtDto> selectRoutingInfo(RoutingMgtDto routingMgtDto);
	
	public void insertRoutingInfo(RoutingMgtDto routingMgtDto);
	public void updateRoutingInfo(RoutingMgtDto routingMgtDto);
	public void deleteRoutingInfo(RoutingMgtDto routingMgtDto);
	
	public List<BomMgtDto> selectRtlBomList(RoutingMgtDto routingMgtDto);
	
	public void insertRtlBomList(String bomId, String routingId);
	public void deleteRtlBomList(String bomId, String routingId);
	
	public List<FacilMgtDto> selectRtlEqmtList(RoutingMgtDto routingMgtDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String routingId);
	public void deleteRtlEquipment(String eqmtMgtId, String routingId);
	public void updateDefaultEqmt(RoutingMgtDto routingMgtDto);
	
	public List<RoutingRtlToolDto> selectRtlToolList(RoutingRtlToolDto routingRtlToolDto);
	
	public void insertRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	public void updateRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	public void deleteRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	
}
