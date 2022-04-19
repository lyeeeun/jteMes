package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.ZinixItemMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.ZinixItemMgtMapper;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtMapper;
import jin.mes.common.alarm.AlarmMgtMapper;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixMtrlInfoService {

	@Resource
	ZinixMtrlInfoMapper zinixMtrlInfoMapper;
	
	@Resource
	AlarmMgtMapper zinixAlarmMgtMapper;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Resource
	ZinixItemMgtMapper zinixItemMgtMapper;
	
	@Resource
	ZinixMtrlMgtMapper zinixMtrlMgtMapper;
	
	//자재조회(page)
	public PageInfo<ZinixMtrlInfoDto> getMtrlInfoList(ZinixMtrlInfoDto mtrlInfoDto, PageRequestVo pageRequestVo){
		List<ZinixMtrlInfoDto> mtrlInfoList = null;
		int rowCount = 0;

		// Page Setting
		mtrlInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixMtrlInfoMapper.selectMtrlInfoCount(mtrlInfoDto);
			if (rowCount > 0) {
				//List
				mtrlInfoList = zinixMtrlInfoMapper.selectMtrlInfoList(mtrlInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlInfoList == null) {
			mtrlInfoList = new ArrayList<ZinixMtrlInfoDto>();
		}
		return new PageInfo<ZinixMtrlInfoDto>(mtrlInfoList, pageRequestVo, rowCount);
	}
	
	//자재정보 팝업조회(mtrl-child)
	public ZinixMtrlInfoDto getMtrlPop(ZinixMtrlInfoDto mtrlInfoDto){
		ZinixMtrlInfoDto mtrlPop = null;
		
		try {
			
			mtrlPop = zinixMtrlInfoMapper.selectMtrlOne(mtrlInfoDto);
			
			//해당 자재에 포함된 업체 정보 조회
			if(!mtrlPop.getMtrlId().equals(null)) {
				ZinixCompMgtDto compMgtDto = new ZinixCompMgtDto();
				compMgtDto.setMtrlId(mtrlPop.getMtrlId());
				mtrlPop.setChildCompList(zinixMtrlInfoMapper.selectMtrlChild(compMgtDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return mtrlPop;
	}
	
		
	//자재정보 입력/수정
	@Transactional
	public String setMtrlInfoSave(ZinixMtrlInfoDto mtrlInfoDto){
		String returnKey = "";
		try {
			mtrlInfoDto.setCreatorId(JteUtils.getUserId());
			mtrlInfoDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlInfoDto.getAction().equals("C")) {//
				//자재입력
				zinixMtrlInfoMapper.insertMtrlInfo(mtrlInfoDto);
				returnKey = mtrlInfoDto.getMtrlId();
				
				//일반자재 등록
				if(mtrlInfoDto.getMtrlType().equals("mtrl_div01")) {//일반자재
					ZinixMtrlMgtDto mtrlMgtDto = new ZinixMtrlMgtDto();
					mtrlMgtDto.setCreatorId(JteUtils.getUserId());
					mtrlMgtDto.setUpdatorId(JteUtils.getUserId());
					mtrlMgtDto.setUse(true);
					mtrlMgtDto.setMtrlId(returnKey);
					zinixMtrlMgtMapper.insertMtrlMgt(mtrlMgtDto);
				}
				
				//다국어 저장
				if(mtrlInfoDto.getMsgList() != null && mtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(mtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
				setMtrlCompSave (mtrlInfoDto);
			}else if(mtrlInfoDto.getAction().equals("U")){//자재 변경
				//자재수정
				zinixMtrlInfoMapper.updateMtrlInfo(mtrlInfoDto);
				
				returnKey =mtrlInfoDto.getMtrlId();
				
				//다국어 저장
				if(mtrlInfoDto.getMsgList() != null && mtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(mtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
				setMtrlCompSave (mtrlInfoDto);
			}else if(mtrlInfoDto.getAction().equals("USE")){//자재 잠금/해제
				if(mtrlInfoDto.isUse()) {
					mtrlInfoDto.setUse(false);
				}else {
					mtrlInfoDto.setUse(true);
				}
				//자재사용수정	
				zinixMtrlInfoMapper.updateMtrlInfo(mtrlInfoDto);
				
				returnKey =mtrlInfoDto.getMtrlId();
			}
		} catch (BusinessException e) {
			returnKey = "CONST";
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재정보 삭제
	@Transactional
	public int setMtrlInfoDelete(List<ZinixMtrlInfoDto> mtrlInfoList){
		int resultInt = -1;
		try {
			ZinixCompMgtDto compMgtDto = new ZinixCompMgtDto();
			//자재삭제
			for(ZinixMtrlInfoDto mtrlInfoDto : mtrlInfoList){
				// 관련 업체 삭제_FK 삭제
				compMgtDto.setMtrlId(mtrlInfoDto.getMtrlId());
				zinixMtrlInfoMapper.deleteMtrlRtlComp(compMgtDto);
				
				zinixMtrlInfoMapper.deleteMtrlInfo(mtrlInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	//자재구매업체 조회
	public PageInfo<ZinixCompMgtDto> getMtrlRtlCompList(ZinixCompMgtDto compMgtDto, PageRequestVo pageRequestVo){
		List<ZinixCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		compMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixMtrlInfoMapper.selectMtrlRtlCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = zinixMtrlInfoMapper.selectMtrlRtlCompList(compMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재구매업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<ZinixCompMgtDto>();
		}
		return new PageInfo<ZinixCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	

	//업체정보 입력/수정/삭제(mtrl-child)
	@Transactional
	public String setMtrlCompSave (ZinixMtrlInfoDto mtrlInfoDto) {
		String returnKey = "";
		try {
			for(ZinixCompMgtDto compMgtDto : mtrlInfoDto.getChildCompList()) {
				compMgtDto.setCreatorId(JteUtils.getUserId());
				compMgtDto.setUpdatorId(JteUtils.getUserId());
				compMgtDto.setMtrlId(mtrlInfoDto.getMtrlId());
				
				if(compMgtDto.getAction().equals("C")) {
					//Comp 입력
					zinixMtrlInfoMapper.insertMtrlRtlComp(compMgtDto);
					returnKey = compMgtDto.getCompId();
					
				}else if(compMgtDto.getAction().equals("D")) {
					zinixMtrlInfoMapper.deleteMtrlRtlComp(compMgtDto);
					returnKey = compMgtDto.getCompId();
				}
			}
			
			List<String> rtlItemList = zinixMtrlInfoMapper.selectMtrlRtlItemList(mtrlInfoDto.getMtrlId());
			
			/*** 품목 제조 원가 - 업체 별 자재 단가 평균 -> 업체 별 자재 단가 변경 시 Update ***/
			ZinixItemMgtDto itemMgtDto = new ZinixItemMgtDto();
			for(String item : rtlItemList) {
				itemMgtDto.setItemId(item);
				itemMgtDto.setItemMtrlCost(zinixMtrlInfoMapper.selectItemMtrlCost(item));
				zinixItemMgtMapper.updateItem(itemMgtDto);
			}
		}catch (Exception e) {
			throw new BusinessException("Comp 정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
		
	//자재구매업체 입력/수정(기본)
	@Transactional
	public String setMtrlRtlCompSave(ZinixCompMgtDto compMgtDto){
		String returnKey = "";
		try {
			compMgtDto.setCreatorId(JteUtils.getUserId());
			compMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(compMgtDto.getAction().equals("C")) {//
				//업체입력
				zinixMtrlInfoMapper.insertMtrlRtlComp(compMgtDto);
				returnKey = compMgtDto.getCompId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재구매업체 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//업체정보 삭제
	@Transactional
	public int setMtrlRtlCompDelete(List<ZinixCompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(ZinixCompMgtDto compDto : compList){
				zinixMtrlInfoMapper.deleteMtrlRtlComp(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재구매업체 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
//	
//	@Transactional
//	public void minOutOfStockAlarm(String mtrlMgtId){
//		try {
//			ZinixMtrlInfoDto mtrlInfoDto = new ZinixMtrlInfoDto();
//			mtrlInfoDto = zinixMtrlInfoMapper.selectMinOutOfStock(mtrlMgtId);
//			
//			if(mtrlInfoDto.getMtrlStd04() > mtrlInfoDto.getMtrlMgtCnt()) {
//				List<String> roleManager = null;
//				
//				ComnCodeVo alarmBCD = CodeUtil.getCode("alarm_stock_mtrl");
//				
//				Date time = new Date();
//				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//				String sendDate = dateFormat.format(time);
//				
//				//시스템 담당자 그룹 권한 보유자
//				roleManager = zinixAlarmMgtMapper.selectSystemManager("role_manager");
//				
//				for(String manager : roleManager) {
//					AlarmMgtDto alarmMgtDto = new AlarmMgtDto(
//							alarmBCD.getCdId(), 
//							mtrlInfoDto.getMtrlMgtId(), 
//							String.format(alarmBCD.getCdReserve01(), ""),
//							String.format(alarmBCD.getCdReserve02(), mtrlInfoDto.getMtrlMgtId()), 
//							alarmBCD.getCdReserve03(), 
//							"alarm_minoutofstock", 
//							sendDate,
//							manager, 
//							"NEW", 
//							null, 
//							"alarm_minoutofstock"
//							);
//
//					alarmMgtDto.setAction("C");
//					
//					alarmMgtService.setAlarmMgt(alarmMgtDto);
//				}
//			}
//			
//		} catch (Exception e) {
//			throw new BusinessException("자재구매업체 삭제 에러  : " + e.getMessage());
//		}
//	}

}
