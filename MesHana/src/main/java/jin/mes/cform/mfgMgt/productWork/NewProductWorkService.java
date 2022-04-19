package jin.mes.cform.mfgMgt.productWork;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.facilMgt.NewFacilMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.NewRoutingMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.NewRoutingMgtService;
import jin.mes.cform.facilMgt.facilCorMgt.NewFacilCorMgtDto;
import jin.mes.cform.facilMgt.facilCorMgt.NewFacilCorMgtMapper;
import jin.mes.cform.facilMgt.facilToolMgt.NewFacilToolMgtDto;
import jin.mes.cform.facilMgt.facilToolMgt.NewFacilToolMgtService;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtService;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.NewMtrlUseDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtService;
import jin.mes.cform.mtrl.mtrltoolMgt.NewMtrltoolMgtDto;
import jin.mes.cform.mtrl.mtrltoolMgt.NewMtrltoolMgtService;
import jin.mes.cform.orderMgt.orderDetailMgt.NewLotInfoDto;
import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;
import jin.mes.common.alarm.AlarmMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewProductWorkService {
	@Resource
	NewProductWorkMapper newProductWorkMapper;
	
	@Autowired
	NewRoutingMgtService newRoutingMgtService;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
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
	
	// 작업정보 조회
	public PageInfo<NewLotInfoDto> getProductWorkLotList(NewLotInfoDto newLotInfoDto, PageRequestVo pageRequestVo) {
		List<NewLotInfoDto> lotList = null;
		int rowCount = 0;
		// Page Setting
		newLotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newLotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newProductWorkMapper.selectProdWorkLotCount(newLotInfoDto);
			if (rowCount > 0) {
				// List
				lotList = newProductWorkMapper.selectProdWorkLotList(newLotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업정보 Lot조회 에러입니다.(List)" + e.getMessage()); 
		}
		if (lotList == null) {
			lotList = new ArrayList<NewLotInfoDto>();
		}
		return new PageInfo<NewLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	// 작업지시 정보 조회
	public List<NewWrkinTeamMgtDto> getProdWorkAsgnList(NewWrkinTeamMgtDto newWrkinTeamMgtDto) {
		List<NewWrkinTeamMgtDto> wrkinTeamMgtList = null;
		try {
			wrkinTeamMgtList = newProductWorkMapper.selectProdWorkAsgnList(newWrkinTeamMgtDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 정보 조회에러입니다.(List)" + e.getMessage());
		}
		if (wrkinTeamMgtList == null) {
			wrkinTeamMgtList = new ArrayList<NewWrkinTeamMgtDto>();
		}
		return wrkinTeamMgtList;
	}
	
	// 작업지시 팝업 조회
	public List<NewWrkinTeamMgtDto> getProdWorkAsgnDetail(NewWrkinTeamMgtDto newAsgnDto) {
		List<NewWrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = newProductWorkMapper.selectProdWorkAsgnDetail(newAsgnDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<NewWrkinTeamMgtDto>();
		}
		return asgnList;
	}
			
	// 작업지시 입력/수정
	@Transactional
	public String setProdWorkAsgnSave(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (newAsgnDto.getAction().equals("C")) {// 작업지시 등록
				if(StringUtils.isEmpty(newAsgnDto.getProdAsmUser())) {
					newAsgnDto.setProdAsmUser(JteUtils.getUserId());
				}
				// 작업지시 입력
				newProductWorkMapper.insertProdWorkAsgn(newAsgnDto);
				returnKey = newAsgnDto.getProdAsmId();
				
				//아이템값으로 라우팅 조회
				NewRoutingMgtDto newRoutingMgtDto = new NewRoutingMgtDto();
				newRoutingMgtDto.setItemId(newAsgnDto.getItemId());
				List<NewRoutingMgtDto> routingMgtList = newRoutingMgtService.getRoutingInfo(newRoutingMgtDto);
				
				//라우팅마다 기본 작업정보 생성
				for(NewRoutingMgtDto routingInfo : routingMgtList) {
					
					//작업정보 생성자
					NewWrkinTeamMgtDto newProdWorkRoutSheetDto = new NewWrkinTeamMgtDto(returnKey, null, newAsgnDto.getLotId(), null, 
							routingInfo.getRoutingId(), routingInfo.getEqmtMgtId(), null, newAsgnDto.getProdAsmQty(), null);
				
					//작업정보 입력
					newProductWorkMapper.insertProdWorkRoutSheet(newProdWorkRoutSheetDto);
				}
			} else if (newAsgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				newProductWorkMapper.updateProdWorkAsgn(newAsgnDto);
				returnKey = newAsgnDto.getProdAsmId();
				
				//작업지시 수정시 작업정보도 수정 필요
				
			}
			//작업정보
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업지시  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 작업지시 삭제
	@Transactional
	public int setProdWorkAsgnDelete(List<NewWrkinTeamMgtDto> asgnList) {
		int resultInt = -1;
		try {
			// 작업지시 삭제
			for (NewWrkinTeamMgtDto newAsgnDto : asgnList) {
				newProductWorkMapper.deleteProdWorkAsgn(newAsgnDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("작업지시  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
	
	//라우팅시트 조회
	public List<NewWrkinTeamMgtDto> getProdWorkRoutSheetList(NewWrkinTeamMgtDto newAsgnDto) {
		List<NewWrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = newProductWorkMapper.selectProdWorkRoutSheetList(newAsgnDto);
		} catch (Exception e) {
			throw new BusinessException("라우팅시트 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<NewWrkinTeamMgtDto>();
		}
		return asgnList;
	}
	
	//작업지시 저장
	@Transactional
	public String setProdWorkRoutSheetSave(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (newAsgnDto.getAction().equals("C")) {// 작업지시 등록
				// 작업지시 입력
				newProductWorkMapper.insertProdWorkRoutSheet(newAsgnDto);
				returnKey = newAsgnDto.getProdAsmId();
			} else if (newAsgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				newProductWorkMapper.updateProdWorkRoutSheet(newAsgnDto);
				returnKey = newAsgnDto.getProdAsmId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업지시  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}
	
	//설비교체 리스트 조회
	public List<NewFacilMgtDto> getProdWorkEqmtChangeList(NewWrkinTeamMgtDto newWrkinTeamMgtDto) {
		List<NewFacilMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = newProductWorkMapper.selectProdWorkEqmtChangeList(newWrkinTeamMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비교체 리스트 조회.(List)" + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilMgtDto>();
		}
		return eqmtMgtList;
	}
	
	// 작업정보 시작 저장
	@Transactional
	public String setProdWorkRoutSheetStart(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			newAsgnDto.setProdWorkUser(JteUtils.getUserId());
			
			newProductWorkMapper.updateProdWorkRoutSheet(newAsgnDto);
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
	
	// 작업종료 저장
	//설비가동시간, 공구사용, 자재투입등
	@Transactional
	public String setProdWorkRoutSheetEnd(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = "";
			
			//등록된 시간이 없다면 시스템 시간으로 계산하여 등록
			if(StringUtils.isEmpty(newAsgnDto.getProdWorkEnd())){
				nowDateTime = dateFormat.format(dateTime);
			}else {
				nowDateTime = newAsgnDto.getProdWorkEnd(); 
			}
			
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			
			newProductWorkMapper.updateProdWorkRoutSheet(newAsgnDto);
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
			
			//공구사용이력 저장
			//1. 현재 작업중인 설비에 장착된 공구 조회(ALL)
			NewFacilToolMgtDto newEqmtToolDto = new NewFacilToolMgtDto();
			newEqmtToolDto.setEqmtMgtId(newAsgnDto.getEqmtMgtId());
			newEqmtToolDto.setRoutingId(newAsgnDto.getRoutingId());
			List<NewFacilToolMgtDto> facilToolMgtList = newProductWorkMapper.selectEqmtToolList(newEqmtToolDto);
			
			//2.장착된 공구마다 공구교체가 있었는지 확인하고 여부에 따라 공구 사용량을 입력한다.
			if(facilToolMgtList.size() > 0) {
				for (NewFacilToolMgtDto newFacilToolMgtDto : facilToolMgtList) {
					//if(!newFacilToolMgtDto.getToolMgtGbn().equals("tool_div03")) {}//팁 공구 카운트 예외처리
					//2-1 장비교체 이력이 있는지 확인하고 있다면 얼만큼 사용했는지 값을 가져온다.
					NewMtrltoolMgtDto newToolMgtDto = new NewMtrltoolMgtDto(newAsgnDto.getProdWorkId(),newFacilToolMgtDto.getToolId(), newFacilToolMgtDto.getToolMgtId(), 
							newFacilToolMgtDto.getEqmtMgtId(), newFacilToolMgtDto.getEqipPosition(), newAsgnDto.getLotId(), 0, newAsgnDto.getProdWorkStart(), nowDateTime, "");
					
  					int historyCount =  newToolMgtService.getToolUseChangeTotal(newToolMgtDto);
					
					//2-2 사용이력 등록 = 현재사용량 - 장비교체 이력 카운트 
					newToolMgtDto.setToolUseQty(Math.round((newAsgnDto.getProdWorkGood() * newFacilToolMgtDto.getToolChange()) + (newAsgnDto.getProdWorkBad()*newFacilToolMgtDto.getToolChange()) - historyCount));
					newToolMgtDto.setAction(newAsgnDto.getQtyAction());
					
					//최초등록시에만 공구수명 등록
					if(newToolMgtDto.getAction().equals("C")) {
						newToolMgtService.setToolUsePgSave(newToolMgtDto);
					}
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보 저장(종료) 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	
	//장착된 공구 조회
	public List<NewFacilToolMgtDto> getProdWorkEqmtToolList(NewFacilToolMgtDto newEqmtToolDto) {
		List<NewFacilToolMgtDto> eqmtToolList = null;
		try {
			eqmtToolList = newProductWorkMapper.selectProdWorkEqmtToolList(newEqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("장착된 공구 조회에러입니다.(List)" + e.getMessage());
		}
		if (eqmtToolList == null) {
			eqmtToolList = new ArrayList<NewFacilToolMgtDto>();
		}
		return eqmtToolList;
	}
	
	//사용가능한 공구 조회
	public List<NewFacilToolMgtDto> getProdWorkToolUseableList(NewFacilToolMgtDto newEqmtToolDto) {
		List<NewFacilToolMgtDto> eqmtToolList = null;
		try {
			eqmtToolList = newProductWorkMapper.selectProdWorkToolUseableList(newEqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("사용가능한 공구 조회에러입니다.(List)" + e.getMessage());
		}
		if (eqmtToolList == null) {
			eqmtToolList = new ArrayList<NewFacilToolMgtDto>();
		}
		return eqmtToolList;
	}
			
	//공구등록
	@Transactional
	public String setProdWorkEqmtTool(List<NewFacilToolMgtDto> eqmtToolList) {
		String returnKey = "";
		try {
			//설비공구 장착 입력
			for(NewFacilToolMgtDto newEqmtToolDto : eqmtToolList){
				newEqmtToolDto.setCreatorId(JteUtils.getUserId());
				newEqmtToolDto.setUpdatorId(JteUtils.getUserId());
				newProductWorkMapper.insertProdWorkEqmtTool(newEqmtToolDto);
				returnKey = newEqmtToolDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비-공구등록 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구해제
	@Transactional
	public String setProdWorkEqmtToolDel(List<NewFacilToolMgtDto> eqmtToolList) {
		String returnKey = "";
		try {
			//설비공구 장착 입력
			for(NewFacilToolMgtDto newEqmtToolDto : eqmtToolList){
				newEqmtToolDto.setCreatorId(JteUtils.getUserId());
				newEqmtToolDto.setUpdatorId(JteUtils.getUserId());
				newProductWorkMapper.deleteProdWorkEqmtTool(newEqmtToolDto);
				returnKey = newEqmtToolDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비-공구해제 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구 카운트 등록/수정
//	@Transactional
//	
//	public String setProdWorkEqmtToolCount(NewFacilToolMgtDto newEqmtToolDto) {
//	String returnKey = "";
//	try {
//		newAsgnDto.setCreatorId(JteUtils.getUserId());
//		//생산지시
//		if (newAsgnDto.getAction().equals("C")) {// 작업지시 등록
//			// 작업지시 입력
//			newProductWorkMapper.insertProdWorkEqmtToolCount(newEqmtToolDto);
//		} else if (newAsgnDto.getAction().equals("U")) {// 작업지시 수정
//			// 작업지시 수정
//			newProductWorkMapper.updateProdWorkEqmtToolCount(newEqmtToolDto);
//		}
//	} catch (Exception e) {
//		returnKey = "";
//		throw new BusinessException("작업지시  입력 에러 : " + e.getMessage());
//	}
//	return returnKey;
//	}	
		
		
	// 자재투입현황(종합, 상세, 불량)
	
	public List<NewMtrlUseDto> getProdWorkMtrl(NewMtrlUseDto newMtrlUseDto) {
		List<NewMtrlUseDto> mtrlUseList = null;
		try {
			if(newMtrlUseDto.getAction().equals("TOTAL")) {//종합집계
				mtrlUseList = newProductWorkMapper.selectProdWorkMtrlTotal(newMtrlUseDto);
			}else if(newMtrlUseDto.getAction().equals("DETAIL")) { //상세정보
				mtrlUseList = newProductWorkMapper.selectProdWorkMtrlDetail(newMtrlUseDto);
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
	
	public String setProdWorkMtrlSave(NewMtrlUseDto newMtrlUseDto) {
		String returnKey = "";
		try {
			if (newMtrlUseDto.getAction().equals("C")) {//자재 사용정보 등록
				// 자재 사용정보 입력
				newProductWorkMapper.insertProdWorkMtrl(newMtrlUseDto);
				returnKey = newMtrlUseDto.getMtrlUseId();
				
				
				//자재수량을 저장하기 위한 생성자
				NewMtrlHistoryDto newMtrlCntDto = new NewMtrlHistoryDto(newMtrlUseDto.getMtrlId(), "mtrl_tagt02", returnKey,
						newMtrlUseDto.getMtrlUseCnt() * -1, newMtrlUseDto.getProdWorkStart(), newMtrlUseDto.getProdWorkUser(), newMtrlUseDto.getMtrlMgtId(), null);
				newMtrlCntDto.setAction("SUBTRACT");//자재 수량 차감
					
				//자재수량 저장
				newMtrlMgtService.setMtrlMgtPgSave(newMtrlCntDto);
				
				
			} else if (newMtrlUseDto.getAction().equals("U")) {//자재 사용정보 수정
				// 작업정보 수정
				newProductWorkMapper.updateProdWorkMtrl(newMtrlUseDto);
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
	public int setProdWorkMtrlDelete(List<NewMtrlUseDto> mtrlUseList) {
		int resultInt = -1;
		try {
			// 자재 사용정보 삭제
			for (NewMtrlUseDto newMtrlUseDto : mtrlUseList) {
				newProductWorkMapper.deleteProdWorkMtrl(newMtrlUseDto);
				//사용하려면 추가 개발 필요
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용정보  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
	
	//품목 불량 조회
	public List<NewInfergodsMgtDto> getProdWorkItemBadList(NewInfergodsMgtDto newItemBadDto){
		List<NewInfergodsMgtDto> itemBadList = null;
		try {
			itemBadList = newProductWorkMapper.selectItemBadList(newItemBadDto);
			
		} catch (Exception e) {
			throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
		}
		if (itemBadList == null) {
			itemBadList = new ArrayList<NewInfergodsMgtDto>();
		}
		return itemBadList;
	}
	
	//타모듈에서 품목 불량 저장 (불량에 의한 수량을 감소시키지 않는다.)
	@Transactional
	public String setProdWorkItemBadSave(NewInfergodsMgtDto newItemBadDto){
		String returnKey = "";
		try {
			//불량등록
			if(newItemBadDto.getAction().equals("C")) {
				newProductWorkMapper.insertItemBad(newItemBadDto);
				returnKey = newItemBadDto.getBadId();
			//불량수정
			}else if(newItemBadDto.getAction().equals("U")) {
				newProductWorkMapper.updateItemBad(newItemBadDto);
				returnKey = newItemBadDto.getBadId();
			//불량삭제
			}else if(newItemBadDto.getAction().equals("D")) {
				newProductWorkMapper.deleteItemBad(newItemBadDto);
			}
			
			//작업 불량인 경우 해당 작업에  불량수 update 처리
			if(newItemBadDto.getBadTarget().equals("qual_spec03")) {
				NewInfergodsMgtDto newItemBadTotalDto = new NewInfergodsMgtDto();
				newItemBadTotalDto.setBadTargetCode(newItemBadDto.getBadTargetCode());
				newItemBadTotalDto.setBadTarget(newItemBadDto.getBadTarget());
				NewWrkinTeamMgtDto newWorkInfoDto = new NewWrkinTeamMgtDto();
				newWorkInfoDto.setProdWorkBad(newProductWorkMapper.selectItemBadTotal(newItemBadTotalDto));
				newWorkInfoDto.setProdWorkId(newItemBadDto.getBadTargetCode());
				newWorkInfoDto.setAction("U");
				
				newProductWorkMapper.updateProdWorkRoutSheet(newWorkInfoDto);
			}
			
			//아이템 수량 저장(아이템 수량 update가 필요한 경우 분기처리하여 주석해제해서 사용)
//					NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto(newItemBadDto.getItemId(),newItemBadDto.getLotId(),newItemBadDto.getBadQty(),
//							"prod_tagt01","LOT",null,newItemBadDto.getChkUser());
//					
//					newItemStockService.setItemStockPgSave(newItemStockMgtDto);
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
}
