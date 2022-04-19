package jin.mes.form.basMgt.operMgt.mtrlInfo;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtMapper;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtDto;
import jin.mes.form.basMgt.operMgt.itemMgt.ItemMgtMapper;
import jin.mes.form.basMgt.userMgt.userAuth.UserAuthDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtMapper;
import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MtrlInfoService {

	@Resource
	MtrlInfoMapper mtrlInfoMapper;
	
	@Resource
	AlarmMgtMapper alarmMgtMapper;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Resource
	ItemMgtMapper itemMgtMapper;
	
	@Resource
	MtrlMgtMapper mtrlMgtMapper;
	
	//자재조회(page)
	public PageInfo<MtrlInfoDto> getMtrlInfoList(MtrlInfoDto mtrlInfoDto, PageRequestVo pageRequestVo){
		List<MtrlInfoDto> mtrlInfoList = null;
		int rowCount = 0;

		// Page Setting
		mtrlInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlInfoMapper.selectMtrlInfoCount(mtrlInfoDto);
			if (rowCount > 0) {
				//List
				mtrlInfoList = mtrlInfoMapper.selectMtrlInfoList(mtrlInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlInfoList == null) {
			mtrlInfoList = new ArrayList<MtrlInfoDto>();
		}
		return new PageInfo<MtrlInfoDto>(mtrlInfoList, pageRequestVo, rowCount);
	}
	
	//자재정보 팝업조회(mtrl-child)
	public MtrlInfoDto getMtrlPop(MtrlInfoDto mtrlInfoDto){
		MtrlInfoDto mtrlPop = null;
		
		try {
			
			mtrlPop = mtrlInfoMapper.selectMtrlOne(mtrlInfoDto);
			
			//해당 자재에 포함된 업체 정보 조회
			if(!mtrlPop.getMtrlId().equals(null)) {
				CompMgtDto compMgtDto = new CompMgtDto();
				compMgtDto.setMtrlId(mtrlPop.getMtrlId());
				mtrlPop.setChildCompList(mtrlInfoMapper.selectMtrlChild(compMgtDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return mtrlPop;
	}
	
		
	//자재정보 입력/수정
	@Transactional
	public String setMtrlInfoSave(MtrlInfoDto mtrlInfoDto){
		String returnKey = "";
		try {
			mtrlInfoDto.setCreatorId(JteUtils.getUserId());
			mtrlInfoDto.setUpdatorId(JteUtils.getUserId());
			
			if(mtrlInfoDto.getAction().equals("C")) {//
				//자재입력
				mtrlInfoMapper.insertMtrlInfo(mtrlInfoDto);
				returnKey = mtrlInfoDto.getMtrlId();
				
				//일반자재 등록
				if(mtrlInfoDto.getMtrlType().equals("mtrl_div01")) {//일반자재
					MtrlMgtDto mtrlMgtDto = new MtrlMgtDto();
					mtrlMgtDto.setCreatorId(JteUtils.getUserId());
					mtrlMgtDto.setUpdatorId(JteUtils.getUserId());
					mtrlMgtDto.setUse(true);
					mtrlMgtDto.setMtrlId(returnKey);
					mtrlMgtMapper.insertMtrlMgt(mtrlMgtDto);
				}
				
				//다국어 저장
				if(mtrlInfoDto.getMsgList() != null && mtrlInfoDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(mtrlInfoDto.getMsgList(), "mtrl", returnKey);
				}
				setMtrlCompSave (mtrlInfoDto);
			}else if(mtrlInfoDto.getAction().equals("U")){//자재 변경
				//자재수정
				mtrlInfoMapper.updateMtrlInfo(mtrlInfoDto);
				
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
				mtrlInfoMapper.updateMtrlInfo(mtrlInfoDto);
				
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
	public int setMtrlInfoDelete(List<MtrlInfoDto> mtrlInfoList){
		int resultInt = -1;
		try {
			CompMgtDto compMgtDto = new CompMgtDto();
			//자재삭제
			for(MtrlInfoDto mtrlInfoDto : mtrlInfoList){
				// 관련 업체 삭제_FK 삭제
				compMgtDto.setMtrlId(mtrlInfoDto.getMtrlId());
				mtrlInfoMapper.deleteMtrlRtlComp(compMgtDto);
				
				mtrlInfoMapper.deleteMtrlInfo(mtrlInfoDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	//자재구매업체 조회
	public PageInfo<CompMgtDto> getMtrlRtlCompList(CompMgtDto compMgtDto, PageRequestVo pageRequestVo){
		List<CompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		compMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlInfoMapper.selectMtrlRtlCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = mtrlInfoMapper.selectMtrlRtlCompList(compMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재구매업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<CompMgtDto>();
		}
		return new PageInfo<CompMgtDto>(compList, pageRequestVo, rowCount);
	}
	

	//업체정보 입력/수정/삭제(mtrl-child)
	@Transactional
	public String setMtrlCompSave (MtrlInfoDto mtrlInfoDto) {
		String returnKey = "";
		try {
			for(CompMgtDto compMgtDto : mtrlInfoDto.getChildCompList()) {
				compMgtDto.setCreatorId(JteUtils.getUserId());
				compMgtDto.setUpdatorId(JteUtils.getUserId());
				compMgtDto.setMtrlId(mtrlInfoDto.getMtrlId());
				
				if(compMgtDto.getAction().equals("C")) {
					//Comp 입력
					mtrlInfoMapper.insertMtrlRtlComp(compMgtDto);
					returnKey = compMgtDto.getCompId();
					
				}else if(compMgtDto.getAction().equals("D")) {
					mtrlInfoMapper.deleteMtrlRtlComp(compMgtDto);
					returnKey = compMgtDto.getCompId();
				}
			}
			
			List<String> rtlItemList = mtrlInfoMapper.selectMtrlRtlItemList(mtrlInfoDto.getMtrlId());
			
			/*** 품목 제조 원가 - 업체 별 자재 단가 평균 -> 업체 별 자재 단가 변경 시 Update ***/
			ItemMgtDto itemMgtDto = new ItemMgtDto();
			for(String item : rtlItemList) {
				itemMgtDto.setItemId(item);
				itemMgtDto.setItemMtrlCost(mtrlInfoMapper.selectItemMtrlCost(item));
				itemMgtMapper.updateItem(itemMgtDto);
			}
		}catch (Exception e) {
			throw new BusinessException("Comp 정보 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
		
	//자재구매업체 입력/수정(기본)
	@Transactional
	public String setMtrlRtlCompSave(CompMgtDto compMgtDto){
		String returnKey = "";
		try {
			compMgtDto.setCreatorId(JteUtils.getUserId());
			compMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(compMgtDto.getAction().equals("C")) {//
				//업체입력
				mtrlInfoMapper.insertMtrlRtlComp(compMgtDto);
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
	public int setMtrlRtlCompDelete(List<CompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(CompMgtDto compDto : compList){
				mtrlInfoMapper.deleteMtrlRtlComp(compDto);
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
//			MtrlInfoDto mtrlInfoDto = new MtrlInfoDto();
//			mtrlInfoDto = mtrlInfoMapper.selectMinOutOfStock(mtrlMgtId);
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
//				roleManager = alarmMgtMapper.selectSystemManager("role_manager");
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
