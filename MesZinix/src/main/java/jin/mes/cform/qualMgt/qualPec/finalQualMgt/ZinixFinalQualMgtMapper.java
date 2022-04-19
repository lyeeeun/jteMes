package jin.mes.cform.qualMgt.qualPec.finalQualMgt;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ZinixFinalQualMgtMapper {
	
	//입고검사 Main
	public List<ZinixFinalQualMgtDto> selectPlcEqmtLogList(ZinixFinalQualMgtDto zinixFinalQualMgtDto);
	
	public int selectPlcEqmtLogCount(ZinixFinalQualMgtDto zinixFinalQualMgtDto);
	
	//plc 데이터 - 대기 > 완료 저장
	public void updateEqmtLog(ZinixFinalQualMgtDto zinixFinalQualMgtDto);
	
	//기존 조치내역  조회 하여 상위 검사내역 변경
	public void updateEqmtLogChange(ZinixFinalQualMgtDto zinixFinalQualMgtDto);
}
