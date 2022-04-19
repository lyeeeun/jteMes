package jin.mes.form.mfgMgt.wrkinWrkerMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.alarm.AlarmMgtDto;
import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.common.cache.CacheUtil;
import jin.mes.form.basMgt.codMgt.baseCodeMgt.BaseCodeMgtDto;
import jin.mes.form.facilMgt.facilCorMgt.FacilCorMgtDto;
import jin.mes.form.facilMgt.facilCorMgt.FacilCorMgtMapper;
import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;
import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtService;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtService;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import jin.mes.form.tool.mtrltoolMgt.MtrltoolMgtDto;
import jin.mes.form.tool.mtrltoolMgt.MtrltoolMgtService;
import kr.co.itcall.jte.common.code.model.ComnCodeVo;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//default
@Service
public class WrkinWrkerMgtService{
	@Resource
	WrkinWrkerMgtMapper prodWorkMapper;
	
	@Resource
	FacilCorMgtMapper eqmtMgtMapper;
	
	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@Autowired
	ItemStockMgtService itemStockService; 
	
	@Autowired
	FacilToolMgtService facilToolMgtService;
	
	@Autowired
	MtrltoolMgtService toolMgtService;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	// 작업정보 조회
	
	public PageInfo<WrkinTeamMgtDto> getProdWorkList(WrkinTeamMgtDto asgnDto, PageRequestVo pageRequestVo) {
		List<WrkinTeamMgtDto> asgnList = null;
		int rowCount = 0;

		// Page Setting
		asgnDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		asgnDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = prodWorkMapper.selectProdWorkCount(asgnDto);
			if (rowCount > 0) {
				// List
				asgnList = prodWorkMapper.selectProdWorkList(asgnDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업정보 조회 에러입니다.(List)" + e.getMessage()); 
		}
		if (asgnList == null) {
			asgnList = new ArrayList<WrkinTeamMgtDto>();
		}
		return new PageInfo<WrkinTeamMgtDto>(asgnList, pageRequestVo, rowCount);
	}

	// 작업정보 팝업 조회
	
	public List<WrkinTeamMgtDto> getProdWorkPop(WrkinTeamMgtDto asgnDto) {
		List<WrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = prodWorkMapper.selectProdWorkPop(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("작업정보 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<WrkinTeamMgtDto>();
		}
		return asgnList;
	}
		
	// 작업정보 입력/수정
	@Transactional
	
	public String setProdWorkSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업정보 등록
				// 작업정보 입력
				prodWorkMapper.insertProdWork(asgnDto);
				returnKey = asgnDto.getProdWorkId();
				
				//알람생성자
				if(CacheUtil.getCode("alarmYN").getCdVal().equals("Y")) {
					BaseCodeMgtDto alarmBCD = CacheUtil.getCode("alarm_mfgplan_C");
					if(alarmBCD.getUseYn().equals("Y")) {
						SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); 
						Date prodPlanDate = format1.parse(asgnDto.getProdPlanYear() + "-" + String.format("%02d", asgnDto.getProdPlanMonth()) + "-" +String.format("%02d", asgnDto.getProdPlanDay()));
						String reserveDate = format1.format(prodPlanDate) + " " + alarmBCD.getCdReserve04();
						
						AlarmMgtDto alarmMgtDto = new AlarmMgtDto(alarmBCD.getCdId(), returnKey, String.format(alarmBCD.getCdReserve01(),""),
								String.format(alarmBCD.getCdReserve02(),returnKey), alarmBCD.getCdReserve03(), JteUtils.getUserId(), reserveDate,
								asgnDto.getProdWorkUser(), "NEW", null, JteUtils.getUserId());
						
						alarmMgtDto.setAction("C");
						//생산계획 알람등록
						alarmMgtService.setAlarmMgt(alarmMgtDto);
					}
				}
			} else if (asgnDto.getAction().equals("U")) {// 작업정보 수정
				// 작업정보 수정
				prodWorkMapper.updateProdWork(asgnDto);
				returnKey = asgnDto.getProdAsmId();
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
	
	public int setProdWorkDelete(List<WrkinTeamMgtDto> asgnList) {
		int resultInt = -1;
		try {
			// 작업정보 삭제
			for (WrkinTeamMgtDto asgnDto : asgnList) {
				prodWorkMapper.deleteProdWork(asgnDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("작업정보  삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	// 자재점검 팝업 조회(리스트)
	
	public List<MtrlMgtDto> getProdMtrlChkList(WrkinTeamMgtDto asgnDto) {
		List<MtrlMgtDto> mtrlMgtList = null;
		try {
			mtrlMgtList = prodWorkMapper.selectProdMtrlChkList(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("자재점검 리스트 조회 에러입니다." + e.getMessage());
		}
		if (mtrlMgtList == null) {
			mtrlMgtList = new ArrayList<MtrlMgtDto>();
		}
		return mtrlMgtList;
	}
	
	//설비공구 장착 해제 
	@Transactional
	
	public String setEqmtToolDelete(List<FacilToolMgtDto> eqmtToolList){
		String returnKey = "";
		try {
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = dateFormat.format(dateTime); 
			
			//설비공구 장착해제
			facilToolMgtService.setEqmtToolDelete(eqmtToolList);
			
			//설비공구 이력
			for(FacilToolMgtDto eqmtToolDto : eqmtToolList){
				//if(!eqmtToolDto.getToolMgtGbn().equals("tool_div03")) {}//팁 공구 카운트 예외처리 
				if(eqmtToolDto.getHistoryYN().equals("Y")){
					//2-1 장비교체 이력이 있는지 확인하고 있다면 얼만큼 사용했는지 값을 가져온다.
					MtrltoolMgtDto toolMgtDto = new MtrltoolMgtDto(eqmtToolDto.getProdWorkId(),eqmtToolDto.getToolId(), eqmtToolDto.getToolMgtId(), 
							eqmtToolDto.getEqmtMgtId(), eqmtToolDto.getEqipPosition(), eqmtToolDto.getLotId(),
							0, eqmtToolDto.getProdWorkStart(), nowDateTime, "");
					int historyCount =  toolMgtService.getToolUseChangeTotal(toolMgtDto);
					
					//2-2 사용이력 등록 - 현재사용량 - 장비교체 이력 카운트 수
					toolMgtDto.setToolUseQty(Math.round((eqmtToolDto.getToolUseQty()*eqmtToolDto.getToolCount()) - historyCount));
					toolMgtDto.setAction("C");
					toolMgtService.setToolUsePgSave(toolMgtDto);	
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
	public String setProdWorkStartSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			
			prodWorkMapper.updateProdWork(asgnDto);
			returnKey = asgnDto.getProdAsmId();
			
			//설비 가동 시작 -- PLC로 체크하는경우 설비가동 삭제
			if(!StringUtils.isEmpty(asgnDto.getEqmtMgtId()) && !asgnDto.getEqmtMgtId().equals("")) {
				FacilCorMgtDto eqmtMgtDto = new FacilCorMgtDto();
				eqmtMgtDto.setEqmtMgtId(asgnDto.getEqmtMgtId());
				eqmtMgtDto.setEqmtWorkStart(asgnDto.getProdWorkStart());
				eqmtMgtDto.setProdWorkId(asgnDto.getProdWorkId());
				eqmtMgtMapper.insertEqmtWork(eqmtMgtDto);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  시작 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	// 자재투입현황(종합, 상세, 불량)
	
	public List<MtrlUseDto> getMtrlUseList(MtrlUseDto mtrlUseDto) {
		List<MtrlUseDto> mtrlUseList = null;
		try {
			if(mtrlUseDto.getAction().equals("TOTAL")) {//종합집계
				mtrlUseList = prodWorkMapper.selectMtrlUseList(mtrlUseDto);
			}else if(mtrlUseDto.getAction().equals("DETAIL")) { //상세정보
				mtrlUseList = prodWorkMapper.selectMtrlUseDetailList(mtrlUseDto);
			}else if(mtrlUseDto.getAction().equals("BAD")) {//불량
				mtrlUseList = prodWorkMapper.selectMtrlUseBadList(mtrlUseDto);
			}else if(mtrlUseDto.getAction().equals("DEVITEM")) {//개발품목
				mtrlUseList = prodWorkMapper.selectMtrlUseDevItemList(mtrlUseDto);
			}else if(mtrlUseDto.getAction().equals("DEVITEMBAD")) {//개발품목(불량)
				mtrlUseList = prodWorkMapper.selectMtrlUseDevItemBadList(mtrlUseDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재투입현황 리스트 조회 에러입니다. (" + mtrlUseDto.getAction() + ")" + e.getMessage());
		}
		if (mtrlUseList == null) {
			mtrlUseList = new ArrayList<MtrlUseDto>();
		}
		return mtrlUseList;
	}
	
	// 자재 사용정보 입력/수정
	@Transactional
	public String setMtrlUseSave(MtrlUseDto mtrlUseDto) {
		String returnKey = "";
		try {
			if (mtrlUseDto.getAction().equals("C")) {//자재 사용정보 등록
				// 자재 사용정보 입력
				prodWorkMapper.insertMtrlUse(mtrlUseDto);
				returnKey = mtrlUseDto.getMtrlUseId();
				
				
				//자재수량을 저장하기 위한 생성자
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(mtrlUseDto.getMtrlId(), "mtrl_tagt02", returnKey,
						mtrlUseDto.getMtrlUseCnt() * -1, mtrlUseDto.getProdWorkStart(), mtrlUseDto.getProdWorkUser(), mtrlUseDto.getMtrlMgtId(), null);
				mtrlCntDto.setAction("SUBTRACT");//자재 수량 차감
					
				//자재수량 저장
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				
				
			} else if (mtrlUseDto.getAction().equals("U")) {//자재 사용정보 수정
				// 작업정보 수정
				prodWorkMapper.updateMtrlUse(mtrlUseDto);
				returnKey = mtrlUseDto.getMtrlUseId();
				
				//자재수량을 저장하기 위한 생성자
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(mtrlUseDto.getMtrlId(), "mtrl_tagt02", returnKey,
						mtrlUseDto.getMtrlUseCnt() * -1, mtrlUseDto.getProdWorkStart(), mtrlUseDto.getProdWorkUser(), mtrlUseDto.getMtrlMgtId(), null);
				
				mtrlCntDto.setAction("U");//자재 수량 업데이트
					
				//자재수량 저장
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
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
	
	public int setMtrlUseDelete(List<MtrlUseDto> mtrlUseList) {
		int resultInt = -1;
		try {
			// 자재 사용정보 삭제
			for (MtrlUseDto mtrlUseDto : mtrlUseList) {
				prodWorkMapper.deleteMtrlUse(mtrlUseDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용정보  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
	
	//작업종료 기본정보만 저장
	@Transactional
	
	public String setProdWorkEndPgSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			
			prodWorkMapper.updateProdWork(asgnDto);
			returnKey = asgnDto.getProdWorkId();
						
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보 중간 저장 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	
	// 작업종료 저장
	//설비가동시간, 공구사용, 자재투입등
	@Transactional
	
	public String setProdWorkEndSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = ""; 
			
			//등록된 시간이 없다면 시스템 시간으로 계산하여 등록
			if(StringUtils.isEmpty(asgnDto.getProdWorkEnd())) {
				nowDateTime = dateFormat.format(dateTime);
			}else {
				nowDateTime = asgnDto.getProdWorkEnd(); 
			}
			
			asgnDto.setCreatorId(JteUtils.getUserId());
			
			prodWorkMapper.updateProdWork(asgnDto);
			returnKey = asgnDto.getProdWorkId();
			
			//설비 가동 종료 -- PLC로 체크하는경우 설비가동 삭제
			if(!StringUtils.isEmpty(asgnDto.getEqmtMgtId()) && !asgnDto.getEqmtMgtId().equals("")) {
				FacilCorMgtDto eqmtMgtDto = new FacilCorMgtDto();
				eqmtMgtDto.setEqmtMgtId(asgnDto.getEqmtMgtId());
				eqmtMgtDto.setEqmtWorkEnd(nowDateTime);
				eqmtMgtDto.setProdWorkId(asgnDto.getProdWorkId());
	 			eqmtMgtMapper.updateEqmtWork(eqmtMgtDto);
			}
			
			//품목 수량 관리 등록
			if(StringUtils.isNotEmpty(asgnDto.getBomTarget()) && asgnDto.getBomTarget().lastIndexOf("prcs_bom01") != -1) {//BOM 품목부분을 보유한라우팅만 재고를 쌓아준다.
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(asgnDto.getItemId(),asgnDto.getLotId(),Integer.parseInt(asgnDto.getProdWorkGood()),
						"prod_tagt01", returnKey, nowDateTime, asgnDto.getCreatorId());
				
				//히스토리 table에 등록되어 있다면 C 없다면  U
				itemStockMgtDto.setAction(asgnDto.getQtyAction());
			
				itemStockService.setItemStockPgSave(itemStockMgtDto);	
			}
			//개발품목 예외처리
			if(!asgnDto.getItemId().equals(CacheUtil.getCode("devItem").getCdVal())) {
				//공구사용이력 저장
				//1. 현재 작업중인 설비에 장착된 공구 조회(ALL)
				FacilToolMgtDto eqmtToolDto = new FacilToolMgtDto();
				eqmtToolDto.setEqmtMgtId(asgnDto.getEqmtMgtId());
				eqmtToolDto.setRoutingId(asgnDto.getRoutingId());
				List<FacilToolMgtDto> facilToolMgtList = facilToolMgtService.getEqmtToolListAll(eqmtToolDto);
				
				//2.장착된 공구마다 공구교체가 있었는지 확인하고 여부에 따라 공구 사용량을 입력한다.
				if(facilToolMgtList.size() > 0) {
					for (FacilToolMgtDto facilToolMgtDto : facilToolMgtList) {
						//if(!facilToolMgtDto.getToolMgtGbn().equals("tool_div03")) {}//팁 공구 카운트 예외처리
						//2-1 장비교체 이력이 있는지 확인하고 있다면 얼만큼 사용했는지 값을 가져온다.
						MtrltoolMgtDto toolMgtDto = new MtrltoolMgtDto(asgnDto.getProdWorkId(),facilToolMgtDto.getToolId(), facilToolMgtDto.getToolMgtId(), 
								facilToolMgtDto.getEqmtMgtId(), facilToolMgtDto.getEqipPosition(), asgnDto.getLotId(), 0, asgnDto.getProdWorkStart(), nowDateTime, "");
						
						int historyCount =  toolMgtService.getToolUseChangeTotal(toolMgtDto);
						
						//2-2 사용이력 등록 = 현재사용량 - 장비교체 이력 카운트 
						toolMgtDto.setToolUseQty(Math.round((Integer.parseInt(asgnDto.getProdWorkGood()) * facilToolMgtDto.getToolCount()) + (Integer.parseInt(asgnDto.getProdWorkBad())*facilToolMgtDto.getToolCount()) - historyCount));
						toolMgtDto.setAction(asgnDto.getQtyAction());
						
						//최초등록시에만 공구수명 등록
						if(toolMgtDto.getAction().equals("C")) {
							toolMgtService.setToolUsePgSave(toolMgtDto);
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
	
	public String setProdWorkAdminSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			
			asgnDto.setCreatorId(JteUtils.getUserId());
			
			prodWorkMapper.updateProdWork(asgnDto);
			returnKey = asgnDto.getProdWorkId();
		
			//품목 수량 관리 등록
			if(StringUtils.isNotEmpty(asgnDto.getBomTarget()) && asgnDto.getBomTarget().lastIndexOf("prcs_bom01") != -1) {//BOM 품목부분을 보유한라우팅만 재고를 쌓아준다.
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(asgnDto.getItemId(),asgnDto.getLotId(),Integer.parseInt(asgnDto.getProdWorkGood()),
						"prod_tagt01", returnKey, asgnDto.getProdWorkEnd(), asgnDto.getCreatorId());
				
				//히스토리 table에 등록되어 있다면 C 없다면  U
				itemStockMgtDto.setAction(asgnDto.getQtyAction());
			
				itemStockService.setItemStockPgSave(itemStockMgtDto);	
			}

		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  관리자 저장 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	//작업공구 등록 (관리자)
	@Transactional
	
	public int setWorkToolAdminInsert(List<MtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			returnKey = toolMgtService.setWorkToolPgInsert(toolMgtList);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("작업공구 등록 (관리자)" + e.getMessage());
		}
		return returnKey;
	}
	
	//작업공구 수정(관리자)
	@Transactional
	
	public int setWorkToolAdminUpdate(MtrltoolMgtDto toolMgtDto) {
		int returnKey = -1;
		try {
			returnKey = toolMgtService.setWorkToolPgUpdate(toolMgtDto);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("작업공구 수정 (관리자)" + e.getMessage());
		}
		return returnKey;
	}
	
	//작업공구 삭제 (관리자)
	@Transactional
	
	public int setWorkToolAdminDelete(List<MtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			returnKey = toolMgtService.setWorkToolPgDelete(toolMgtList);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("작업공구 삭제 (관리자)" + e.getMessage());
		}
		return returnKey;
	}
}
