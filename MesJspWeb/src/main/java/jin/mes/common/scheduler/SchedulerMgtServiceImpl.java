package jin.mes.common.scheduler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.form.basMgt.userMgt.userAuth.UserAuthDto;
import jin.mes.form.basMgt.userMgt.userInfo.UserInfoDto;
import jin.mes.form.facilMgt.facilCorMgt.FacilCorMgtDto;
import jin.mes.mapper.common.scheduler.SchedulerMgtMapper;
import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class SchedulerMgtServiceImpl implements SchedulerMgtService{
	
	@Resource
	SchedulerMgtMapper schedulerMgtMapper;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	@Override
	public void gageCheckAlarm() {
		List<FacilCorMgtDto> eqmtMgtList = null;
		List<UserAuthDto> userAuthList = null;
		try {
			FacilCorMgtDto facilCorMgtDto = new FacilCorMgtDto();
			UserAuthDto userAuthDto = new UserAuthDto();
			ComnCodeVo alarmBCD = CodeUtil.getCode("alarm_gage_reach");
			// 측정 장비
			facilCorMgtDto.setEqmtMgtGbn("eqmt_div10");
			// Alarm 발송을 위한 검증 기간 기준(기초 코드 설정 값)
			facilCorMgtDto.setPInterval(Integer.parseInt(alarmBCD.getCdVal()));
			eqmtMgtList = schedulerMgtMapper.selectGageInfo(facilCorMgtDto);
			
			userAuthDto.setAuthId("auth.eqmtMgt.manager");
			userAuthList = schedulerMgtMapper.selectEqmtManager(userAuthDto);
			
			for(FacilCorMgtDto eqmt : eqmtMgtList) {
				for(UserAuthDto user : userAuthList) {
					Date time = new Date();
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String sendDate = dateFormat.format(time);
					
					AlarmMgtDto alarmMgtDto = new AlarmMgtDto(
									alarmBCD.getCdId(), 
									eqmt.getEqmtMgtId(), 
									String.format(alarmBCD.getCdReserve01(), ""),
									String.format(alarmBCD.getCdReserve02(), eqmt.getEqmtMgtId()), 
									alarmBCD.getCdReserve03(), 
									"scheduller_gage", 
									sendDate,
									user.getUserId(), 
									"NEW", 
									null, 
									"scheduller_gage"
									);
					
					alarmMgtDto.setAction("C");
					//생산계획 알람등록
					alarmMgtService.setAlarmMgt(alarmMgtDto);
				}
			}
			
		} catch(Exception ex) {
			throw new BusinessException("Scheduler: gageCheckAlarm Error : " + ex.getMessage());
		}
	}
	
}
