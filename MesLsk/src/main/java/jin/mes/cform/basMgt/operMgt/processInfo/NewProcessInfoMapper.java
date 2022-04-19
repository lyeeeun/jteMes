package jin.mes.cform.basMgt.operMgt.processInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.processInfo.NewProcessInfoDto;

@Mapper
public interface NewProcessInfoMapper {
	public List<NewProcessInfoDto> selectProcessInfo(NewProcessInfoDto newProcessInfoDto);
	public int rowCount(NewProcessInfoDto newProcessInfoDto);
	
	public List<NewProcessInfoDto> selectRtlEqmtList(NewProcessInfoDto newProcessInfoDto);
	public int selectRtlEqmtCount(NewProcessInfoDto newProcessInfoDto);
	
	public void insertProcessInfo(NewProcessInfoDto newProcessInfoDto);
	public void updateProcessInfo(NewProcessInfoDto newProcessInfoDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String processId);
	public void deleteRtlEquipment(String eqmtMgtId, String processId);
	
	public void updateIsUse(NewProcessInfoDto newProcessInfoDto);
}
