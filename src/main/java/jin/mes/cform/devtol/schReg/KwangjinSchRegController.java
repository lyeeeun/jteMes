package jin.mes.cform.devtol.schReg;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jin.mes.cform.devtol.schReg.KwangjinSchRegService;
import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Component
public class KwangjinSchRegController extends BaseController {
	
	@Autowired
	KwangjinSchRegService kwangjinSchRegService;
	
	@Scheduled(cron = "#{schMinMtrlStock}")
	public void scheduled() {
		try {
			// schRegService.toolVerifCheckAlarm();
			kwangjinSchRegService.minOutOfStockAlarm();
		} catch(Exception ex) {
			throw new BusinessException("scheduled Error : " + ex.getMessage());
		}
	}
	
}
