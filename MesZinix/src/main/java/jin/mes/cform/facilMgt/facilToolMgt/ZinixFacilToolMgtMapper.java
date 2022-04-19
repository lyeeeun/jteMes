package jin.mes.cform.facilMgt.facilToolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.facilMgt.facilToolMgt.ZinixFacilToolMgtDto;

@Mapper
public interface ZinixFacilToolMgtMapper {

	public List<ZinixFacilToolMgtDto> selectEqmtToolList(ZinixFacilToolMgtDto eqmtToolDto);
	
	public int selectEqmtToolCount(ZinixFacilToolMgtDto eqmtToolDto);
	
	public List<ZinixFacilToolMgtDto> selectEqmtToolListAll(ZinixFacilToolMgtDto eqmtToolDto);
	
	public void insertEqmtTool(ZinixFacilToolMgtDto eqmtToolDto);
	
	public void updateEqmtTool(ZinixFacilToolMgtDto eqmtToolDto);
	
	public int deleteEqmtTool(ZinixFacilToolMgtDto eqmtToolDto);
	
	public List<ZinixFacilToolMgtDto> selectEqmtToolItemList(ZinixFacilToolMgtDto eqmtToolDto);
	
	public List<ZinixFacilToolMgtDto> selectEqmtToolRoutingList(ZinixFacilToolMgtDto eqmtToolDto);
	
	public List<ZinixFacilToolMgtDto> selectEqmtToolPosList(ZinixFacilToolMgtDto eqmtToolDto);
	
	public int selectEqmtToolPosCount(ZinixFacilToolMgtDto eqmtToolDto);
	
	public List<ZinixFacilToolMgtDto> selectRoutingToolCurList(ZinixFacilToolMgtDto eqmtToolDto);
	
	public List<ZinixFacilToolMgtDto> selectWorkToolAdminList(ZinixFacilToolMgtDto eqmtToolDto);
	
	public List<ZinixFacilToolMgtDto> selectWorkToolAdminPosList(ZinixFacilToolMgtDto eqmtToolDto);
}
