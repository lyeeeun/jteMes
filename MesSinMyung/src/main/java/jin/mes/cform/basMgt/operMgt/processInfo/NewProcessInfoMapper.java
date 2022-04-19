package jin.mes.cform.basMgt.operMgt.processInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NewProcessInfoMapper {
	public List<NewProcessInfoDto> selectProcessInfo(NewProcessInfoDto processInfoDto);
	public int rowCount(NewProcessInfoDto processInfoDto);
	
	public List<NewProcessInfoDto> selectRtlEqmtList(NewProcessInfoDto processInfoDto);
	public int selectRtlEqmtCount(NewProcessInfoDto processInfoDto);
	
	public void insertProcessInfo(NewProcessInfoDto processInfoDto);
	public void updateProcessInfo(NewProcessInfoDto processInfoDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String processId);
	public void deleteRtlEquipment(String eqmtMgtId, String processId);
	
	public void updateIsUse(NewProcessInfoDto processInfoDto);
}
