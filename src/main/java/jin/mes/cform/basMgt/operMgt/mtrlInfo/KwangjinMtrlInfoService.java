package jin.mes.cform.basMgt.operMgt.mtrlInfo;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.alarm.AlarmMgtMapper;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.KwangjinItemMgtDto;
import jin.mes.cform.basMgt.operMgt.itemMgt.KwangjinItemMgtMapper;
import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingMgtDto;
import jin.mes.cform.mtrl.mtrlRecevingMgt.KwangjinMtrlRecevingMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinMtrlInfoService {

	@Resource
	KwangjinMtrlInfoMapper kwangjinMtrlInfoMapper;
	
	@Resource
	AlarmMgtMapper alarmMgtMapper;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Resource
	KwangjinItemMgtMapper kwangjinItemMgtMapper;
	
	@Resource
	KwangjinMtrlRecevingMgtMapper kwangjinMtrlRecevingMgtMapper;
	
	//자재조회(page)
	public PageInfo<KwangjinMtrlInfoDto> getMtrlInfoList(KwangjinMtrlInfoDto kwangjinMtrlInfoDto, PageRequestVo pageRequestVo){
		List<KwangjinMtrlInfoDto> mtrlInfoList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinMtrlInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinMtrlInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinMtrlInfoMapper.selectMtrlInfoCount(kwangjinMtrlInfoDto);
			if (rowCount > 0) {
				//List
				mtrlInfoList = kwangjinMtrlInfoMapper.selectMtrlInfoList(kwangjinMtrlInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlInfoList == null) {
			mtrlInfoList = new ArrayList<KwangjinMtrlInfoDto>();
		}
		return new PageInfo<KwangjinMtrlInfoDto>(mtrlInfoList, pageRequestVo, rowCount);
	}
	
	//자재정보 팝업조회(mtrl-child)
	public KwangjinMtrlInfoDto getMtrlPop(KwangjinMtrlInfoDto kwangjinMtrlInfoDto){
		KwangjinMtrlInfoDto mtrlPop = null;
		
		try {
			
			mtrlPop = kwangjinMtrlInfoMapper.selectMtrlOne(kwangjinMtrlInfoDto);
			
			//해당 자재에 포함된 업체 정보 조회
			if(!mtrlPop.getMtrlId().equals(null)) {
				KwangjinCompMgtDto kwangjinCompMgtDto = new KwangjinCompMgtDto();
				kwangjinCompMgtDto.setMtrlId(mtrlPop.getMtrlId());
				mtrlPop.setChildCompList(kwangjinMtrlInfoMapper.selectMtrlChild(kwangjinCompMgtDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return mtrlPop;
	}
	
		
	//자재정보 입력/수정
	@Transactional
	public String setMtrlInfoSave(KwangjinMtrlInfoDto kwangjinMtrlInfoDto){
		String returnKey = "";
		try {
			kwangjinMtrlInfoDto.setCreatorId(JteUtils.getUserId());
			kwangjinMtrlInfoDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinMtrlInfoDto.getAction().equals("C")) {//
				//자재입력
				kwangjinMtrlInfoMapper.insertMtrlInfo(kwangjinMtrlInfoDto);
				returnKey = kwangjinMtrlInfoDto.getMtrlId();
				
				//일반자재 등록
				if(kwangjinMtrlInfoDto.getMtrlType().equals("mtrl_div01")) {//일반자재
					KwangjinMtrlRecevingMgtDto mtrlMgtDto = new KwangjinMtrlRecevingMgtDto();
					mtrlMgtDto.setCreatorId(JteUtils.getUserId());
					mtrlMgtDto.setUpdatorId(JteUtils.getUserId());
					mtrlMgtDto.setUse(true);
					mtrlMgtDto.setMtrlId(returnKey);
					kwangjinMtrlRecevingMgtMapper.insertMtrlRecevingMgt(mtrlMgtDto);
				}
				
				//다국어 저장
				if(kwangjinMtrlInfoDto.getMsgList() != null && kwangjinMtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinMtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
				setMtrlCompSave (kwangjinMtrlInfoDto);
			}else if(kwangjinMtrlInfoDto.getAction().equals("U")){//자재 변경
				//자재수정
				kwangjinMtrlInfoMapper.updateMtrlInfo(kwangjinMtrlInfoDto);
				
				returnKey =kwangjinMtrlInfoDto.getMtrlId();
				
				//다국어 저장
				if(kwangjinMtrlInfoDto.getMsgList() != null && kwangjinMtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinMtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
				setMtrlCompSave (kwangjinMtrlInfoDto);
			}else if(kwangjinMtrlInfoDto.getAction().equals("USE")){//자재 잠금/해제
				if(kwangjinMtrlInfoDto.isUse()) {
					kwangjinMtrlInfoDto.setUse(false);
				}else {
					kwangjinMtrlInfoDto.setUse(true);
				}
				//자재사용수정	
				kwangjinMtrlInfoMapper.updateMtrlInfo(kwangjinMtrlInfoDto);
				
				returnKey =kwangjinMtrlInfoDto.getMtrlId();
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
	public int setMtrlInfoDelete(List<KwangjinMtrlInfoDto> mtrlInfoList){
		int resultInt = -1;
		try {
			KwangjinCompMgtDto kwangjinCompMgtDto = new KwangjinCompMgtDto();
			//자재삭제
			for(KwangjinMtrlInfoDto kwangjinMtrlInfoDto : mtrlInfoList){
				// 관련 업체 삭제_FK 삭제
				kwangjinCompMgtDto.setMtrlId(kwangjinMtrlInfoDto.getMtrlId());
				kwangjinMtrlInfoMapper.deleteMtrlRtlComp(kwangjinCompMgtDto);
				
				kwangjinMtrlInfoMapper.deleteMtrlInfo(kwangjinMtrlInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	//자재구매업체 조회
	public PageInfo<KwangjinCompMgtDto> getMtrlRtlCompList(KwangjinCompMgtDto kwangjinCompMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinCompMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinCompMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinMtrlInfoMapper.selectMtrlRtlCompCount(kwangjinCompMgtDto);
			if (rowCount > 0) {
				//List
				compList = kwangjinMtrlInfoMapper.selectMtrlRtlCompList(kwangjinCompMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재구매업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<KwangjinCompMgtDto>();
		}
		return new PageInfo<KwangjinCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	

	//업체정보 입력/수정/삭제(mtrl-child)
	@Transactional
	public String setMtrlCompSave (KwangjinMtrlInfoDto kwangjinMtrlInfoDto) {
		String returnKey = "";
		try {
			for(KwangjinCompMgtDto kwangjinCompMgtDto : kwangjinMtrlInfoDto.getChildCompList()) {
				kwangjinCompMgtDto.setCreatorId(JteUtils.getUserId());
				kwangjinCompMgtDto.setUpdatorId(JteUtils.getUserId());
				kwangjinCompMgtDto.setMtrlId(kwangjinMtrlInfoDto.getMtrlId());
				
				if(kwangjinCompMgtDto.getAction().equals("C")) {
					//Comp 입력
					kwangjinMtrlInfoMapper.insertMtrlRtlComp(kwangjinCompMgtDto);
					returnKey = kwangjinCompMgtDto.getCompId();
					
				}else if(kwangjinCompMgtDto.getAction().equals("D")) {
					kwangjinMtrlInfoMapper.deleteMtrlRtlComp(kwangjinCompMgtDto);
					returnKey = kwangjinCompMgtDto.getCompId();
				}
			}
			
			List<String> rtlItemList = kwangjinMtrlInfoMapper.selectMtrlRtlItemList(kwangjinMtrlInfoDto.getMtrlId());
			
			/*** 품목 제조 원가 - 업체 별 자재 단가 평균 -> 업체 별 자재 단가 변경 시 Update ***/
			KwangjinItemMgtDto itemMgtDto = new KwangjinItemMgtDto();
			for(String item : rtlItemList) {
				itemMgtDto.setItemId(item);
				itemMgtDto.setItemMtrlCost(kwangjinMtrlInfoMapper.selectItemMtrlCost(item));
				kwangjinItemMgtMapper.updateItem(itemMgtDto);
			}
		}catch (Exception e) {
			throw new BusinessException("Comp 정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
		
	//자재구매업체 입력/수정(기본)
	@Transactional
	public String setMtrlRtlCompSave(KwangjinCompMgtDto kwangjinCompMgtDto){
		String returnKey = "";
		try {
			kwangjinCompMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinCompMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinCompMgtDto.getAction().equals("C")) {//
				//업체입력
				kwangjinMtrlInfoMapper.insertMtrlRtlComp(kwangjinCompMgtDto);
				returnKey = kwangjinCompMgtDto.getCompId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재구매업체 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//업체정보 삭제
	@Transactional
	public int setMtrlRtlCompDelete(List<KwangjinCompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(KwangjinCompMgtDto compDto : compList){
				kwangjinMtrlInfoMapper.deleteMtrlRtlComp(compDto);
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
//			KwangjinMtrlInfoDto kwangjinMtrlInfoDto = new KwangjinMtrlInfoDto();
//			kwangjinMtrlInfoDto = kwangjinMtrlInfoMapper.selectMinOutOfStock(mtrlMgtId);
//			
//			if(kwangjinMtrlInfoDto.getMtrlStd04() > kwangjinMtrlInfoDto.getMtrlMgtCnt()) {
//				List<String> roleManager = null;
//				
//				ComnCodeVo alarmBCD = CodeUtil.getCode("alarm_stock_mtrl");
//				
//				Date time = new Date();
//				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//				String sendDate = dateFormat.format(time);
//				
//				//시스템 담당자 그룹 권한 보유자
//				roleManager = alarmMgtMapper.selectSystemManager("role_manager");
//				
//				for(String manager : roleManager) {
//					AlarmMgtDto alarmMgtDto = new AlarmMgtDto(
//							alarmBCD.getCdId(), 
//							kwangjinMtrlInfoDto.getMtrlMgtId(), 
//							String.format(alarmBCD.getCdReserve01(), ""),
//							String.format(alarmBCD.getCdReserve02(), kwangjinMtrlInfoDto.getMtrlMgtId()), 
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
