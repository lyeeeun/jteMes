package jin.mes.mapper.common.alarm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import jin.mes.common.alarm.AlarmMgtDto;

@Mapper
public interface AlarmMgtMapper {

	public int selectMyAlarmCount(AlarmMgtDto alarmMgtDto);

	public List<AlarmMgtDto> selectMyAlarmList(AlarmMgtDto alarmMgtDto);
	
	public List<AlarmMgtDto> selectAlarmList(AlarmMgtDto alarmMgtDto);
	
	public int selectAlarmCount(AlarmMgtDto alarmMgtDto);
	
	public void insertAlarmMgt(AlarmMgtDto alarmMgtDto);
	
	public int updateAlarmMgt(AlarmMgtDto alarmMgtDto);
	
	public int updateAlarmRead(AlarmMgtDto alarmMgtDto);
	
	public void deleteAlarmMgt(AlarmMgtDto alarmMgtDto);
	
}
