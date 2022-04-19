package jin.mes.cform.devtol.schReg;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.mtrlInfo.KwangjinMtrlInfoDto;
import jin.mes.cform.basMgt.operMgt.mtrlInfo.KwangjinMtrlInfoMapper;
import jin.mes.cform.devtol.schReg.KwangjinSchRegMapper;
import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtMapper;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.common.cache.CacheUtil;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import jin.mes.cform.facilMgt.mtrltoolMgt.KwangjinMtrltoolMgtDto;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinSchRegService {

	@Autowired
	AlarmMgtService alarmMgtService;
	
	@Resource
	KwangjinSchRegMapper kwangjinSchRegMapper;
	
	@Resource
	AlarmMgtMapper alarmMgtMapper;
	
	@Resource
	KwangjinMtrlInfoMapper kwangjinMtrlInfoMapper;
	
	public void toolVerifCheckAlarm() {
		List<KwangjinMtrltoolMgtDto> toolMgtList = null;
		List<String> roleManager = null;
		try {
			KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto = new KwangjinMtrltoolMgtDto();
			
			BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_tool_verif");
			// 검사용 공구
			kwangjinMtrltoolMgtDto.setToolType("tool_div03");
			
			//Alarm 발송을 위한 검증 기간 기준(기초 코드 설정 값)
			kwangjinMtrltoolMgtDto.setPInterval(Integer.parseInt(alarmBCD.getCdVal()));
			
			toolMgtList = kwangjinSchRegMapper.toolVerifCheckAlarm(kwangjinMtrltoolMgtDto);
			
			roleManager = alarmMgtMapper.selectSystemManager("role_manager");
			
			for(KwangjinMtrltoolMgtDto tool : toolMgtList) {
				for(String manager : roleManager) {
					Date time = new Date();
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String sendDate = dateFormat.format(time);
					
					AlarmMgtDto alarmMgtDto = new AlarmMgtDto(
									alarmBCD.getCdId(), 
									tool.getToolMgtId(), 
									String.format(alarmBCD.getCdReserve01(), ""),
									String.format(alarmBCD.getCdReserve02(), tool.getToolMgtId()), 
									alarmBCD.getCdReserve03(), 
									"scheduller_toolVerif", 
									sendDate,
									manager, 
									"NEW", 
									null, 
									"scheduller_toolVerif"
									);
					
					alarmMgtDto.setAction("C");
					alarmMgtService.setAlarmMgt(alarmMgtDto);
				}
			}
			
		} catch(Exception ex) {
			throw new BusinessException("Scheduler: toolVerifCheckAlarm Error : " + ex.getMessage());
		}
	}
	
	@Transactional
	public void minOutOfStockAlarm(){
		try {
			List<KwangjinMtrlInfoDto> mtrlInfoList = null;
			mtrlInfoList = kwangjinMtrlInfoMapper.selectMinOutOfStock();
			
			//시스템 담당자 그룹 권한 보유자
			List<String> roleManager = null;
			roleManager = alarmMgtMapper.selectSystemManager("role_manager");
			
			for(KwangjinMtrlInfoDto mtrlInfoDto : mtrlInfoList) {
				BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_stock_mtrl");
				
				Date time = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String sendDate = dateFormat.format(time);
				
				for(String manager : roleManager) {
					AlarmMgtDto alarmMgtDto = new AlarmMgtDto(
							alarmBCD.getCdId(), 
							mtrlInfoDto.getMtrlMgtId(), 
							String.format(alarmBCD.getCdReserve01(), ""),
							String.format(alarmBCD.getCdReserve02(), mtrlInfoDto.getMtrlMgtId()), 
							alarmBCD.getCdReserve03(), 
							"alarm_minoutofstock", 
							sendDate,
							manager, 
							"NEW", 
							null, 
							"alarm_minoutofstock"
							);
					alarmMgtDto.setAction("C");
					
					alarmMgtService.setAlarmMgt(alarmMgtDto);
				}
			}
		} catch (Exception e) {
			throw new BusinessException("minOutOfStockAlarm : " + e.getMessage());
		}
	}
}
