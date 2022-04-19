package jin.mes.mapper.facilMgt.facilToolMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;

@Mapper
public interface FacilToolMgtMapper {

	public List<FacilToolMgtDto> selectEqmtToolList(FacilToolMgtDto eqmtToolDto);
	
	public int selectEqmtToolCount(FacilToolMgtDto eqmtToolDto);
	
	public List<FacilToolMgtDto> selectEqmtToolListAll(FacilToolMgtDto eqmtToolDto);
	
	public void insertEqmtTool(FacilToolMgtDto eqmtToolDto);
	
	public void updateEqmtTool(FacilToolMgtDto eqmtToolDto);
	
	public int deleteEqmtTool(FacilToolMgtDto eqmtToolDto);
	
	public List<FacilToolMgtDto> selectEqmtToolItemList(FacilToolMgtDto eqmtToolDto);
	
	public List<FacilToolMgtDto> selectEqmtToolRoutingList(FacilToolMgtDto eqmtToolDto);
	
	public List<FacilToolMgtDto> selectEqmtToolPosList(FacilToolMgtDto eqmtToolDto);
	
	public int selectEqmtToolPosCount(FacilToolMgtDto eqmtToolDto);
	
	public List<FacilToolMgtDto> selectRoutingToolCurList(FacilToolMgtDto eqmtToolDto);
	
	public List<FacilToolMgtDto> selectWorkToolAdminList(FacilToolMgtDto eqmtToolDto);
	
	public List<FacilToolMgtDto> selectWorkToolAdminPosList(FacilToolMgtDto eqmtToolDto);
}
