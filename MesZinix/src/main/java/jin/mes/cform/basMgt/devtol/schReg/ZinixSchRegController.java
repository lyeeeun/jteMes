package jin.mes.cform.basMgt.devtol.schReg;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Component
public class ZinixSchRegController extends BaseController {
	
	@Autowired
	ZinixSchRegService schRegService;
	
	@Scheduled(cron = "#{schMinMtrlStock}")
	public void zinixScheduled() {
		try {
			// schRegService.toolVerifCheckAlarm();
			schRegService.minOutOfStockAlarm();
		} catch(Exception ex) {
			throw new BusinessException("zinixScheduled Error : " + ex.getMessage());
		}
	}
	
}
