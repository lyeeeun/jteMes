package jin.mes.common.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;

@Component
public class SchedulerMgtController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(SchedulerMgtController.class);
	
	@Autowired
	SchedulerMgtService schedulerMgtService;
	
	@Scheduled(cron = "#{getCronOneDayExp}")
	public void testSch() {
		schedulerMgtService.gageCheckAlarm();
		
		logger.info("매일 08시에 스케줄러 동작.");
	}
	
}
