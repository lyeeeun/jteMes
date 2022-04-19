package jin.mes.common.alarm;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.itcall.jte.common.mvc.BaseController;
import kr.co.itcall.jte.common.mvc.PageRequestVo;

@Controller
@RequestMapping("/alarm")
public class AlarmMgtController extends BaseController {

	@Autowired
	AlarmMgtService alarmMgtService;
	
	//나의 알람갯수 카운트
	@RequestMapping(value="/getMyAlarmCount")
	@ResponseBody
	public int getMyAlarmCount(ModelMap model) {
		return alarmMgtService.getMyAlarmCount();
	}
		
	//나의 알람 리스트 조회
	@RequestMapping(value="/getMyAlarmList")
	public ModelMap getMyAlarmList(ModelMap model, @ModelAttribute AlarmMgtDto alarmMgtDto) {
		model.addAttribute("result", alarmMgtService.getMyAlarmList(alarmMgtDto));
		return model;
	}

	//알람목록 읽음 표시
	@RequestMapping(value="/setMyAlarmRead")
	@ResponseBody
	public int setMyAlarmRead(ModelMap model, HttpServletRequest req, @RequestBody AlarmMgtDto alarmMgtDto) {
		return alarmMgtService.setMyAlarmRead(alarmMgtDto,req);
	}
	
	//나의 알람 리스트 조회
	@RequestMapping(value="/getAlarmList")
	public ModelMap getAlarmList(ModelMap model, @ModelAttribute AlarmMgtDto alarmMgtDto) {
		PageRequestVo pageRequestVo = new PageRequestVo();
		pageRequestVo.setPage(getCurrentPage(Integer.toString(alarmMgtDto.getPage())));
		pageRequestVo.setRows(alarmMgtDto.getRows());
		setModelWithkendoList(model, alarmMgtService.getAlarmList(alarmMgtDto,pageRequestVo));
		return model;
	}
	
}