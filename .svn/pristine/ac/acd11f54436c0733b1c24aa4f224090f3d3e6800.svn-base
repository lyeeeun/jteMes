package jin.mes.cform.basMgt.routing.routingMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.bom.bomMgt.NewBomMgtDto;
import jin.mes.cform.basMgt.operMgt.facilMgt.NewFacilMgtDto;

@Mapper
public interface NewRoutingMgtMapper {
	public List<NewRoutingMgtDto> selectRoutingInfo(NewRoutingMgtDto newRoutingMgtDto);
	
	public void insertRoutingInfo(NewRoutingMgtDto newRoutingMgtDto);
	public void updateRoutingInfo(NewRoutingMgtDto newRoutingMgtDto);
	public void deleteRoutingInfo(NewRoutingMgtDto newRoutingMgtDto);
	
	public List<NewBomMgtDto> selectRtlBomList(NewRoutingMgtDto newRoutingMgtDto);
	
	public void insertRtlBomList(String bomId, String routingId);
	public void deleteRtlBomList(String bomId, String routingId);
	
	public List<NewFacilMgtDto> selectRtlEqmtList(NewRoutingMgtDto newRoutingMgtDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String routingId);
	public void deleteRtlEquipment(String eqmtMgtId, String routingId);
	public void updateDefaultEqmt(NewRoutingMgtDto newRoutingMgtDto);
	
	public List<NewRoutingRtlToolDto> selectRtlToolList(NewRoutingRtlToolDto newRoutingRtlToolDto);
	
	public void insertRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	public void updateRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	public void deleteRtlToolList(String toolId, int toolRpm, String toolLocation, float toolCount,  String routingId);
	
}
