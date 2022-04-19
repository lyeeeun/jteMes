package jin.mes.form.basMgt.operMgt.processInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.form.basMgt.operMgt.processInfo.ProcessInfoDto;

@Mapper
public interface ProcessInfoMapper {
	public List<ProcessInfoDto> selectProcessInfo(ProcessInfoDto processInfoDto);
	public int rowCount(ProcessInfoDto processInfoDto);
	
	public List<ProcessInfoDto> selectRtlEqmtList(ProcessInfoDto processInfoDto);
	public int selectRtlEqmtCount(ProcessInfoDto processInfoDto);
	
	public void insertProcessInfo(ProcessInfoDto processInfoDto);
	public void updateProcessInfo(ProcessInfoDto processInfoDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String processId);
	public void deleteRtlEquipment(String eqmtMgtId, String processId);
	
	public void updateIsUse(ProcessInfoDto processInfoDto);
}
