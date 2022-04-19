package jin.mes.common.alarm;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import jin.mes.common.alarm.AlarmMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//@Service("alarmMgtService")
@Service
public class AlarmMgtService{

	@Resource
	AlarmMgtMapper alarmMgtMapper;
	
	//나의 알람갯수 체크
	
	public int getMyAlarmCount() {
		int alarmCount = 0;
		try {
			AlarmMgtDto alarmMgtDto = new AlarmMgtDto();
			alarmMgtDto.setAlarmReceiver(JteUtils.getUserId());
			alarmCount = alarmMgtMapper.selectMyAlarmCount(alarmMgtDto);
		}catch(Exception ex) {
			throw new BusinessException("나의알람 갯수 체크 조회 에러(Service) : " + ex.getMessage());
		}
		return alarmCount;
	}
		
	//나의 알람조회
	
	public List<AlarmMgtDto> getMyAlarmList(AlarmMgtDto alarmMgtDto) {
		List<AlarmMgtDto> alarmMgtList = new ArrayList<AlarmMgtDto>();
		try {
			alarmMgtDto.setAlarmReceiver(JteUtils.getUserId());
			alarmMgtList = alarmMgtMapper.selectMyAlarmList(alarmMgtDto);
		}catch(Exception ex) {
			throw new BusinessException("알람 조회 에러(Service) : " + ex.getMessage());
		}
		return alarmMgtList;
	}
	
	//알람 전체 리스트 조회
	
	public PageInfo<AlarmMgtDto> getAlarmList(AlarmMgtDto alarmMgtDto, PageRequestVo pageRequestVo){
		List<AlarmMgtDto> alarmMgtList = null;
		int rowCount = 0;

		// Page Setting
		alarmMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		alarmMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = alarmMgtMapper.selectAlarmCount(alarmMgtDto);
			if (rowCount > 0) {
				//List
				alarmMgtList = alarmMgtMapper.selectAlarmList(alarmMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("알람 리스트 조회 에러(Service) : " + e.getMessage());
		}
		if (alarmMgtList == null) {
			alarmMgtList = new ArrayList<AlarmMgtDto>();
		}
		return new PageInfo<AlarmMgtDto>(alarmMgtList, pageRequestVo, rowCount);
	}
	
	//알람등록
	
	public AlarmMgtDto setAlarmMgt(AlarmMgtDto alarmMgtDto) {
		try {
			if(alarmMgtDto.getAction().equals("C")) {
				alarmMgtMapper.insertAlarmMgt(alarmMgtDto);
			}else if(alarmMgtDto.getAction().equals("U")) {
				alarmMgtMapper.updateAlarmMgt(alarmMgtDto);
			}
		}catch(Exception ex) {
			throw new BusinessException("알람 등록 에러(Service) : " + ex.getMessage());
		}
		return alarmMgtDto;
	}
	
	//알람 수신확인
	
	public int setMyAlarmRead(AlarmMgtDto alarmMgtDto, HttpServletRequest req) {
		int resultInt = -1;
		try {
			String isDevice = "";
			String userAgent = req.getHeader("User-Agent").toUpperCase();
			if(userAgent.indexOf("MOBILE") > -1) {
				if(userAgent.indexOf("PHONE") == -1) {
					isDevice = "MOBILE";
				}else {
					isDevice = "TABLET";
				}
			} else {
				isDevice = "PC";
			}
			alarmMgtDto.setAlarmDevice(isDevice);
			resultInt = alarmMgtMapper.updateAlarmRead(alarmMgtDto);
		}catch(Exception ex) {
			resultInt = -1;
			throw new BusinessException("알람 수신 확인  에러(Service) : " + ex.getMessage());
		}
		return resultInt;
	}
	
	//알람삭제
	
}
