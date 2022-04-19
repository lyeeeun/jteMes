package jin.mes.cform.basMgt.devtol.schReg;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.mtrlInfo.ZinixMtrlInfoDto;
import jin.mes.cform.basMgt.operMgt.mtrlInfo.ZinixMtrlInfoMapper;
import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtMapper;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.common.cache.CacheUtil;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import jin.mes.cform.mtrl.mtrltoolMgt.ZinixMtrltoolMgtDto;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixSchRegService {

	@Autowired
	AlarmMgtService alarmMgtService;
	
	@Resource
	ZinixSchRegMapper zinixSchRegMapper;
	
	@Resource
	AlarmMgtMapper zinixAlarmMgtMapper;
	
	@Resource
	ZinixMtrlInfoMapper zinixMtrlInfoMapper;
	
	public void toolVerifCheckAlarm() {
		List<ZinixMtrltoolMgtDto> toolMgtList = null;
		List<String> roleManager = null;
		try {
			ZinixMtrltoolMgtDto toolMgtDto = new ZinixMtrltoolMgtDto();
			
			BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_tool_verif");
			// 검사용 공구
			toolMgtDto.setToolType("tool_div03");
			
			//Alarm 발송을 위한 검증 기간 기준(기초 코드 설정 값)
			toolMgtDto.setPInterval(Integer.parseInt(alarmBCD.getCdVal()));
			
			toolMgtList = zinixSchRegMapper.toolVerifCheckAlarm(toolMgtDto);
			
			roleManager = zinixAlarmMgtMapper.selectSystemManager("role_manager");
			
			for(ZinixMtrltoolMgtDto tool : toolMgtList) {
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
			List<ZinixMtrlInfoDto> mtrlInfoList = null;
			mtrlInfoList = zinixMtrlInfoMapper.selectMinOutOfStock();
			
			//시스템 담당자 그룹 권한 보유자
			List<String> roleManager = null;
			roleManager = zinixAlarmMgtMapper.selectSystemManager("role_manager");
			
			for(ZinixMtrlInfoDto mtrlInfoDto : mtrlInfoList) {
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
