package jin.mes.cform.mfgMgt.wrkinWrkerMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.facilMgt.facilCorMgt.NewFacilCorMgtDto;
import jin.mes.cform.facilMgt.facilCorMgt.NewFacilCorMgtMapper;
import jin.mes.cform.facilMgt.facilToolMgt.NewFacilToolMgtDto;
import jin.mes.cform.facilMgt.facilToolMgt.NewFacilToolMgtService;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtService;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtService;
import jin.mes.cform.mtrl.mtrltoolMgt.NewMtrltoolMgtDto;
import jin.mes.cform.mtrl.mtrltoolMgt.NewMtrltoolMgtService;
import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.common.cache.CacheUtil;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//default
@Service
public class NewWrkinWrkerMgtService{
	@Resource
	NewWrkinWrkerMgtMapper newProdWorkMapper;
	
	@Resource
	NewFacilCorMgtMapper newEqmtMgtMapper;
	
	@Autowired
	NewMtrlMgtService newMtrlMgtService;
	
	@Autowired
	NewItemStockMgtService newItemStockService; 
	
	@Autowired
	NewFacilToolMgtService newFacilToolMgtService;
	
	@Autowired
	NewMtrltoolMgtService newToolMgtService;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	// 작업정보 조회
	
	public PageInfo<NewWrkinTeamMgtDto> getProdWorkList(NewWrkinTeamMgtDto newAsgnDto, PageRequestVo pageRequestVo) {
		List<NewWrkinTeamMgtDto> asgnList = null;
		int rowCount = 0;

		// Page Setting
		newAsgnDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newAsgnDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newProdWorkMapper.selectProdWorkCount(newAsgnDto);
			if (rowCount > 0) {
				// List
				asgnList = newProdWorkMapper.selectProdWorkList(newAsgnDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업정보 조회 에러입니다.(List)" + e.getMessage()); 
		}
		if (asgnList == null) {
			asgnList = new ArrayList<NewWrkinTeamMgtDto>();
		}
		return new PageInfo<NewWrkinTeamMgtDto>(asgnList, pageRequestVo, rowCount);
	}

	// 작업정보 팝업 조회
	
	public List<NewWrkinTeamMgtDto> getProdWorkPop(NewWrkinTeamMgtDto newAsgnDto) {
		List<NewWrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = newProdWorkMapper.selectProdWorkPop(newAsgnDto);
		} catch (Exception e) {
			throw new BusinessException("작업정보 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<NewWrkinTeamMgtDto>();
		}
		return asgnList;
	}
		
	// 작업정보 입력/수정
	@Transactional
	
	public String setProdWorkSave(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (newAsgnDto.getAction().equals("C")) {// 작업정보 등록
				// 작업정보 입력
				newProdWorkMapper.insertProdWork(newAsgnDto);
				returnKey = newAsgnDto.getProdWorkId();
				
				//알람생성자
				if(CacheUtil.getCode("alarmYN").getCdVal().equals("Y")) {
					BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_mfgplan_C");
					if(alarmBCD.getUseYn().equals("Y")) {
						SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); 
						Date prodPlanDate = format1.parse(newAsgnDto.getProdPlanYear() + "-" + String.format("%02d", newAsgnDto.getProdPlanMonth()) + "-" +String.format("%02d", newAsgnDto.getProdPlanDay()));
						String reserveDate = format1.format(prodPlanDate) + " " + alarmBCD.getCdReserve04();
						
						AlarmMgtDto alarmMgtDto = new AlarmMgtDto(alarmBCD.getCdId(), returnKey, String.format(alarmBCD.getCdReserve01(),""),
								String.format(alarmBCD.getCdReserve02(),returnKey), alarmBCD.getCdReserve03(), JteUtils.getUserId(), reserveDate,
								newAsgnDto.getProdWorkUser(), "NEW", null, JteUtils.getUserId());
						
						alarmMgtDto.setAction("C");
						//생산계획 알람등록
						alarmMgtService.setAlarmMgt(alarmMgtDto);
					}
				}
			} else if (newAsgnDto.getAction().equals("U")) {// 작업정보 수정
				// 작업정보 수정
				newProdWorkMapper.updateProdWork(newAsgnDto);
				returnKey = newAsgnDto.getProdAsmId();
			}
			//작업정보
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  입력 에러" + e.getMessage());
		}

		return returnKey;
	}

	// 작업정보 삭제
	@Transactional
	
	public int setProdWorkDelete(List<NewWrkinTeamMgtDto> asgnList) {
		int resultInt = -1;
		try {
			// 작업정보 삭제
			for (NewWrkinTeamMgtDto newAsgnDto : asgnList) {
				newProdWorkMapper.deleteProdWork(newAsgnDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("작업정보  삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	// 자재점검 팝업 조회(리스트)
	
	public List<NewMtrlMgtDto> getProdMtrlChkList(NewWrkinTeamMgtDto newAsgnDto) {
		List<NewMtrlMgtDto> mtrlMgtList = null;
		try {
			mtrlMgtList = newProdWorkMapper.selectProdMtrlChkList(newAsgnDto);
		} catch (Exception e) {
			throw new BusinessException("자재점검 리스트 조회 에러입니다." + e.getMessage());
		}
		if (mtrlMgtList == null) {
			mtrlMgtList = new ArrayList<NewMtrlMgtDto>();
		}
		return mtrlMgtList;
	}
	
	//설비공구 장착 해제 
	@Transactional
	
	public String setEqmtToolDelete(List<NewFacilToolMgtDto> eqmtToolList){
		String returnKey = "";
		try {
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = dateFormat.format(dateTime); 
			
			//설비공구 장착해제
			newFacilToolMgtService.setEqmtToolDelete(eqmtToolList);
			
			//설비공구 이력
			for(NewFacilToolMgtDto newEqmtToolDto : eqmtToolList){
				//if(!newEqmtToolDto.getToolMgtGbn().equals("tool_div03")) {}//팁 공구 카운트 예외처리 
				if(newEqmtToolDto.getHistoryYN().equals("Y")){
					//2-1 장비교체 이력이 있는지 확인하고 있다면 얼만큼 사용했는지 값을 가져온다.
					NewMtrltoolMgtDto newToolMgtDto = new NewMtrltoolMgtDto(newEqmtToolDto.getProdWorkId(),newEqmtToolDto.getToolId(), newEqmtToolDto.getToolMgtId(), 
							newEqmtToolDto.getEqmtMgtId(), newEqmtToolDto.getEqipPosition(), newEqmtToolDto.getLotId(),
							0, newEqmtToolDto.getProdWorkStart(), nowDateTime, "");
					int historyCount =  newToolMgtService.getToolUseChangeTotal(newToolMgtDto);
					
					//2-2 사용이력 등록 - 현재사용량 - 장비교체 이력 카운트 수
					newToolMgtDto.setToolUseQty(Math.round((newEqmtToolDto.getToolUseQty()*newEqmtToolDto.getToolCount()) - historyCount));
					newToolMgtDto.setAction("C");
					newToolMgtService.setToolUsePgSave(newToolMgtDto);	
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비공구 장착  입력 에러" + e.getMessage());
		}
		
		return returnKey;
	}
	
	// 작업정보 시작 저장
	@Transactional
	
	public String setProdWorkStartSave(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			
			newProdWorkMapper.updateProdWork(newAsgnDto);
			returnKey = newAsgnDto.getProdAsmId();
			
			//설비 가동 시작 -- PLC로 체크하는경우 설비가동 삭제
			if(!StringUtils.isEmpty(newAsgnDto.getEqmtMgtId()) && !newAsgnDto.getEqmtMgtId().equals("")) {
				NewFacilCorMgtDto newEqmtMgtDto = new NewFacilCorMgtDto();
				newEqmtMgtDto.setEqmtMgtId(newAsgnDto.getEqmtMgtId());
				newEqmtMgtDto.setEqmtWorkStart(newAsgnDto.getProdWorkStart());
				newEqmtMgtDto.setProdWorkId(newAsgnDto.getProdWorkId());
				newEqmtMgtMapper.insertEqmtWork(newEqmtMgtDto);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  시작 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	// 자재투입현황(종합, 상세, 불량)
	
	public List<NewMtrlUseDto> getMtrlUseList(NewMtrlUseDto newMtrlUseDto) {
		List<NewMtrlUseDto> mtrlUseList = null;
		try {
			if(newMtrlUseDto.getAction().equals("TOTAL")) {//종합집계
				mtrlUseList = newProdWorkMapper.selectMtrlUseList(newMtrlUseDto);
			}else if(newMtrlUseDto.getAction().equals("DETAIL")) { //상세정보
				mtrlUseList = newProdWorkMapper.selectMtrlUseDetailList(newMtrlUseDto);
			}else if(newMtrlUseDto.getAction().equals("BAD")) {//불량
				mtrlUseList = newProdWorkMapper.selectMtrlUseBadList(newMtrlUseDto);
			}else if(newMtrlUseDto.getAction().equals("DEVITEM")) {//개발품목
				mtrlUseList = newProdWorkMapper.selectMtrlUseDevItemList(newMtrlUseDto);
			}else if(newMtrlUseDto.getAction().equals("DEVITEMBAD")) {//개발품목(불량)
				mtrlUseList = newProdWorkMapper.selectMtrlUseDevItemBadList(newMtrlUseDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재투입현황 리스트 조회 에러입니다. (" + newMtrlUseDto.getAction() + ")" + e.getMessage());
		}
		if (mtrlUseList == null) {
			mtrlUseList = new ArrayList<NewMtrlUseDto>();
		}
		return mtrlUseList;
	}
	
	// 자재 사용정보 입력/수정
	@Transactional
	
	public String setMtrlUseSave(NewMtrlUseDto newMtrlUseDto) {
		String returnKey = "";
		try {
			if (newMtrlUseDto.getAction().equals("C")) {//자재 사용정보 등록
				// 자재 사용정보 입력
				newProdWorkMapper.insertMtrlUse(newMtrlUseDto);
				returnKey = newMtrlUseDto.getMtrlUseId();
				
				
				//자재수량을 저장하기 위한 생성자
				NewMtrlHistoryDto newMtrlCntDto = new NewMtrlHistoryDto(newMtrlUseDto.getMtrlId(), "mtrl_tagt02", returnKey,
						newMtrlUseDto.getMtrlUseCnt() * -1, newMtrlUseDto.getProdWorkStart(), newMtrlUseDto.getProdWorkUser(), newMtrlUseDto.getMtrlMgtId(), null);
				newMtrlCntDto.setAction("SUBTRACT");//자재 수량 차감
					
				//자재수량 저장
				newMtrlMgtService.setMtrlMgtPgSave(newMtrlCntDto);
				
				
			} else if (newMtrlUseDto.getAction().equals("U")) {//자재 사용정보 수정
				// 작업정보 수정
				newProdWorkMapper.updateMtrlUse(newMtrlUseDto);
				returnKey = newMtrlUseDto.getMtrlUseId();
				
				//자재수량을 저장하기 위한 생성자
				NewMtrlHistoryDto newMtrlCntDto = new NewMtrlHistoryDto(newMtrlUseDto.getMtrlId(), "mtrl_tagt02", returnKey,
						newMtrlUseDto.getMtrlUseCnt() * -1, newMtrlUseDto.getProdWorkStart(), newMtrlUseDto.getProdWorkUser(), newMtrlUseDto.getMtrlMgtId(), null);
				
				newMtrlCntDto.setAction("U");//자재 수량 업데이트
					
				//자재수량 저장
				newMtrlMgtService.setMtrlMgtPgSave(newMtrlCntDto);
			}
			//작업정보
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 사용정보 입력/수정 에러"  + e.getMessage());
		}

		return returnKey;
	}

	// 자재 사용정보 삭제
	@Transactional
	
	public int setMtrlUseDelete(List<NewMtrlUseDto> mtrlUseList) {
		int resultInt = -1;
		try {
			// 자재 사용정보 삭제
			for (NewMtrlUseDto newMtrlUseDto : mtrlUseList) {
				newProdWorkMapper.deleteMtrlUse(newMtrlUseDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용정보  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
	
	//작업종료 기본정보만 저장
	@Transactional
	
	public String setProdWorkEndPgSave(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			
			newProdWorkMapper.updateProdWork(newAsgnDto);
			returnKey = newAsgnDto.getProdWorkId();
						
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보 중간 저장 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	
	// 작업종료 저장
	//설비가동시간, 공구사용, 자재투입등
	@Transactional
	
	public String setProdWorkEndSave(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = ""; 
			
			//등록된 시간이 없다면 시스템 시간으로 계산하여 등록
			if(StringUtils.isEmpty(newAsgnDto.getProdWorkEnd())) {
				nowDateTime = dateFormat.format(dateTime);
			}else {
				nowDateTime = newAsgnDto.getProdWorkEnd(); 
			}
			
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			
			newProdWorkMapper.updateProdWork(newAsgnDto);
			returnKey = newAsgnDto.getProdWorkId();
			
			//설비 가동 종료 -- PLC로 체크하는경우 설비가동 삭제
			if(!StringUtils.isEmpty(newAsgnDto.getEqmtMgtId()) && !newAsgnDto.getEqmtMgtId().equals("")) {
				NewFacilCorMgtDto newEqmtMgtDto = new NewFacilCorMgtDto();
				newEqmtMgtDto.setEqmtMgtId(newAsgnDto.getEqmtMgtId());
				newEqmtMgtDto.setEqmtWorkEnd(nowDateTime);
				newEqmtMgtDto.setProdWorkId(newAsgnDto.getProdWorkId());
	 			newEqmtMgtMapper.updateEqmtWork(newEqmtMgtDto);
			}
			
			//품목 수량 관리 등록
			if(StringUtils.isNotEmpty(newAsgnDto.getBomTarget()) && newAsgnDto.getBomTarget().lastIndexOf("prcs_bom01") != -1) {//BOM 품목부분을 보유한라우팅만 재고를 쌓아준다.
				NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto(newAsgnDto.getItemId(),newAsgnDto.getLotId(),newAsgnDto.getProdWorkGood(),
						"prod_tagt01", returnKey, nowDateTime, newAsgnDto.getCreatorId());
				
				//히스토리 table에 등록되어 있다면 C 없다면  U
				newItemStockMgtDto.setAction(newAsgnDto.getQtyAction());
			
				newItemStockService.setItemStockPgSave(newItemStockMgtDto);	
			}
			//개발품목 예외처리
			if(!newAsgnDto.getItemId().equals(CacheUtil.getCode("devItem").getCdVal())) {
				//공구사용이력 저장
				//1. 현재 작업중인 설비에 장착된 공구 조회(ALL)
				NewFacilToolMgtDto newEqmtToolDto = new NewFacilToolMgtDto();
				newEqmtToolDto.setEqmtMgtId(newAsgnDto.getEqmtMgtId());
				newEqmtToolDto.setRoutingId(newAsgnDto.getRoutingId());
				List<NewFacilToolMgtDto> facilToolMgtList = newFacilToolMgtService.getEqmtToolListAll(newEqmtToolDto);
				
				//2.장착된 공구마다 공구교체가 있었는지 확인하고 여부에 따라 공구 사용량을 입력한다.
				if(facilToolMgtList.size() > 0) {
					for (NewFacilToolMgtDto newFacilToolMgtDto : facilToolMgtList) {
						//if(!newFacilToolMgtDto.getToolMgtGbn().equals("tool_div03")) {}//팁 공구 카운트 예외처리
						//2-1 장비교체 이력이 있는지 확인하고 있다면 얼만큼 사용했는지 값을 가져온다.
						NewMtrltoolMgtDto newToolMgtDto = new NewMtrltoolMgtDto(newAsgnDto.getProdWorkId(),newFacilToolMgtDto.getToolId(), newFacilToolMgtDto.getToolMgtId(), 
								newFacilToolMgtDto.getEqmtMgtId(), newFacilToolMgtDto.getEqipPosition(), newAsgnDto.getLotId(), 0, newAsgnDto.getProdWorkStart(), nowDateTime, "");
						
						int historyCount =  newToolMgtService.getToolUseChangeTotal(newToolMgtDto);
						
						//2-2 사용이력 등록 = 현재사용량 - 장비교체 이력 카운트 
						newToolMgtDto.setToolUseQty(Math.round((newAsgnDto.getProdWorkGood() * newFacilToolMgtDto.getToolCount()) + (newAsgnDto.getProdWorkBad()*newFacilToolMgtDto.getToolCount()) - historyCount));
						newToolMgtDto.setAction(newAsgnDto.getQtyAction());
						
						//최초등록시에만 공구수명 등록
						if(newToolMgtDto.getAction().equals("C")) {
							newToolMgtService.setToolUsePgSave(newToolMgtDto);
						}
					}
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보 저장 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	// 작업종료 관리자저장
	@Transactional
	
	public String setProdWorkAdminSave(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			
			newProdWorkMapper.updateProdWork(newAsgnDto);
			returnKey = newAsgnDto.getProdWorkId();
		
			//품목 수량 관리 등록
			if(StringUtils.isNotEmpty(newAsgnDto.getBomTarget()) && newAsgnDto.getBomTarget().lastIndexOf("prcs_bom01") != -1) {//BOM 품목부분을 보유한라우팅만 재고를 쌓아준다.
				NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto(newAsgnDto.getItemId(),newAsgnDto.getLotId(),newAsgnDto.getProdWorkGood(),
						"prod_tagt01", returnKey, newAsgnDto.getProdWorkEnd(), newAsgnDto.getCreatorId());
				
				//히스토리 table에 등록되어 있다면 C 없다면  U
				newItemStockMgtDto.setAction(newAsgnDto.getQtyAction());
			
				newItemStockService.setItemStockPgSave(newItemStockMgtDto);	
			}

		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  관리자 저장 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	//작업공구 등록 (관리자)
	@Transactional
	
	public int setWorkToolAdminInsert(List<NewMtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			returnKey = newToolMgtService.setWorkToolPgInsert(toolMgtList);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("작업공구 등록 (관리자)" + e.getMessage());
		}
		return returnKey;
	}
	
	//작업공구 수정(관리자)
	@Transactional
	
	public int setWorkToolAdminUpdate(NewMtrltoolMgtDto newToolMgtDto) {
		int returnKey = -1;
		try {
			returnKey = newToolMgtService.setWorkToolPgUpdate(newToolMgtDto);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("작업공구 수정 (관리자)" + e.getMessage());
		}
		return returnKey;
	}
	
	//작업공구 삭제 (관리자)
	@Transactional
	
	public int setWorkToolAdminDelete(List<NewMtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			returnKey = newToolMgtService.setWorkToolPgDelete(toolMgtList);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("작업공구 삭제 (관리자)" + e.getMessage());
		}
		return returnKey;
	}
}
