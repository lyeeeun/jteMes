package jin.mes.api.mobile;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtService;
import kr.co.itcall.jte.spring.user.JteUserUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/api")
public class MobileApiController {
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	AlarmMgtDto alarmMgtDto = new AlarmMgtDto(); 

	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/check/{userId}")
	public ResponseEntity<Object> checkLoginOk(@PathVariable(name="userId", required=true) String userId){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userId", userId);
		result.put("userNm", JteUserUtil.getUserNm());
		result.put("result", "DONE");
		result.put("date", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS").format(new Date()));
		return new ResponseEntity<Object>(result, HttpStatus.OK);
	}

	/*** http://192.168.2.62:8090/api/get/khaeng ***/
	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/get/{userId}")
	public ResponseEntity<Object> checkMyAlertInfo(@PathVariable(name="userId", required=true) String userId){
		
		List<AlarmMgtDto> myAlarmList = alarmMgtService.getMyAlarmList(alarmMgtDto);
		int rowCount = alarmMgtService.getMyAlarmCount();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userId", userId);
		result.put("userNm", JteUserUtil.getUserNm());
		result.put("result", "DONE");
		result.put("target", "AlarmCheck");
		if(rowCount > 0) {
			result.put("info", myAlarmList);
			result.put("result", "MSG");
			result.put("code", myAlarmList.get(0).getAlarmSeqId());
			result.put("title", myAlarmList.get(0).getAlarmTitle() + " (읽지 않은 알람 " + rowCount + "건)");
			result.put("msg", "");
			result.put("detail", myAlarmList.get(0).getAlarmContent());
			result.put("url", "/");
		}

		log.info("API Alarm 호출정보 ::: {}", result);
		return new ResponseEntity<Object>(result, HttpStatus.OK);
	}

	/*** http://192.168.2.62:8090/api/job/khaeng ***/
	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/job/{userId}")
	public ResponseEntity<Object> checkMyJobInfo(@PathVariable(name="userId", required=true) String userId){
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userId", userId);
		result.put("userNm", JteUserUtil.getUserNm());
		result.put("result", "DONE");
		result.put("target", "JobScheduleCheck");
		if(new Random().nextInt(3)==0) {
			// 10분의 1의 확률로 처리 또는 전달할 메시지가 있는것으로 한다.
			result.put("result", "JOB");
			result.put("code", new Random().nextInt(5) + 100);
			result.put("title", "작업처리["+result.get("code")+"]");
			result.put("msg", "작업 처리에 보내는 테스트입니다. 작업을 확인해 주세요.");
			result.put("detail", "안녕하세요.\n"
					+ "JOB 시스템에 문제가 발생했습니다.\n"
					+ "시스템 로깅에 문제가 있는 메시지테스트 전달사항이며,\n"
					+ "JOB 시스템에 접속의 상세상태를 확인하시려면 알림메시지를 클릭하여 상세정보를 보실 수 있습니다.");
			result.put("url", new Random().nextInt(2)==0?"/":"/api/mobile/");
			result.put("userInfo", JteUserUtil.getUserInfo().getUserInfo());
		}
		log.info("API Job 호출정보 ::: {}", result);
		return new ResponseEntity<Object>(result, HttpStatus.OK);
	}

	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/mobile/{userId}")
	public String goPageMyJobInfo(@PathVariable(name="userId", required=true) String userId){
		return "tlf/main";
	}

}
