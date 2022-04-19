package jin.mes.common.alarm;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import jin.mes.common.alarm.AlarmMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

public interface AlarmMgtService {
	
	//나의 알람갯수 체크
	public int getMyAlarmCount();
		
	//나의 알람조회
	public List<AlarmMgtDto> getMyAlarmList(AlarmMgtDto alarmMgtDto);
	
	//알람 전체 리스트 조회
	public PageInfo<AlarmMgtDto> getAlarmList(AlarmMgtDto alarmMgtDto, PageRequestVo pageRequestVo);
	
	//알람등록
	public AlarmMgtDto setAlarmMgt(AlarmMgtDto alarmMgtDto);
	
	//알람 수신확인
	public int setMyAlarmRead(AlarmMgtDto alarmMgtDto, HttpServletRequest req);
	
	//알람삭제
}
