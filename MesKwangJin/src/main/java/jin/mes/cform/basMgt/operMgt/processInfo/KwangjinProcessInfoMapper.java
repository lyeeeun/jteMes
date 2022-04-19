package jin.mes.cform.basMgt.operMgt.processInfo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.cform.basMgt.operMgt.processInfo.KwangjinProcessInfoDto;

@Mapper
public interface KwangjinProcessInfoMapper {
	public List<KwangjinProcessInfoDto> selectProcessInfo(KwangjinProcessInfoDto kwangjinProcessInfoDto);
	public int rowCount(KwangjinProcessInfoDto kwangjinProcessInfoDto);
	
	public List<KwangjinProcessInfoDto> selectRtlEqmtList(KwangjinProcessInfoDto kwangjinProcessInfoDto);
	public int selectRtlEqmtCount(KwangjinProcessInfoDto kwangjinProcessInfoDto);
	
	public void insertProcessInfo(KwangjinProcessInfoDto kwangjinProcessInfoDto);
	public void updateProcessInfo(KwangjinProcessInfoDto kwangjinProcessInfoDto);
	
	public void insertRtlEquipment(String eqmtMgtId, String processId);
	public void deleteRtlEquipment(String eqmtMgtId, String processId);
	
	public void updateIsUse(KwangjinProcessInfoDto kwangjinProcessInfoDto);
}
