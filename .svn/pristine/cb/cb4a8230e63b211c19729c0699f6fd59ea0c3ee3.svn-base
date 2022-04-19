package jin.mes.form.mfgMgt.productWork;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtService;
import jin.mes.form.facilMgt.facilCorMgt.FacilCorMgtDto;
import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtDto;
import jin.mes.form.facilMgt.facilToolMgt.FacilToolMgtService;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtService;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mfgMgt.wrkinWrkerMgt.MtrlUseDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import jin.mes.form.mtrl.mtrltoolMgt.MtrltoolMgtDto;
import jin.mes.form.mtrl.mtrltoolMgt.MtrltoolMgtService;
import jin.mes.form.orderMgt.orderDetailMgt.LotInfoDto;
import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import jin.mes.mapper.facilMgt.facilCorMgt.FacilCorMgtMapper;
import jin.mes.mapper.mfgMgt.productWork.ProductWorkMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.CodeUtil;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//default
@Service
public class ProductWorkServiceImpl implements ProductWorkService{
	@Resource
	ProductWorkMapper productWorkMapper;
	
	@Autowired
	RoutingMgtService routingMgtService;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
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
	
	// 작업정보 조회
	@Override
	public PageInfo<LotInfoDto> getProductWorkLotList(LotInfoDto lotInfoDto, PageRequestVo pageRequestVo) {
		List<LotInfoDto> lotList = null;
		int rowCount = 0;
		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = productWorkMapper.selectProdWorkLotCount(lotInfoDto);
			if (rowCount > 0) {
				// List
				lotList = productWorkMapper.selectProdWorkLotList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업정보 Lot조회 에러입니다.(List)" + e.getMessage()); 
		}
		if (lotList == null) {
			lotList = new ArrayList<LotInfoDto>();
		}
		return new PageInfo<LotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	// 작업지시 정보 조회
	@Override
	public List<WrkinTeamMgtDto> getProdWorkAsgnList(WrkinTeamMgtDto wrkinTeamMgtDto) {
		List<WrkinTeamMgtDto> wrkinTeamMgtList = null;
		try {
			wrkinTeamMgtList = productWorkMapper.selectProdWorkAsgnList(wrkinTeamMgtDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 정보 조회에러입니다.(List)" + e.getMessage());
		}
		if (wrkinTeamMgtList == null) {
			wrkinTeamMgtList = new ArrayList<WrkinTeamMgtDto>();
		}
		return wrkinTeamMgtList;
	}
	
	// 작업지시 팝업 조회
	@Override
	public List<WrkinTeamMgtDto> getProdWorkAsgnDetail(WrkinTeamMgtDto asgnDto) {
		List<WrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = productWorkMapper.selectProdWorkAsgnDetail(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<WrkinTeamMgtDto>();
		}
		return asgnList;
	}
			
	// 작업지시 입력/수정
	@Transactional
	@Override
	public String setProdWorkAsgnSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업지시 등록
				if(StringUtils.isEmpty(asgnDto.getProdAsmUser())) {
					asgnDto.setProdAsmUser(JteUtils.getUserId());
				}
				// 작업지시 입력
				productWorkMapper.insertProdWorkAsgn(asgnDto);
				returnKey = asgnDto.getProdAsmId();
				
				//아이템값으로 라우팅 조회
				RoutingMgtDto routingMgtDto = new RoutingMgtDto();
				routingMgtDto.setItemId(asgnDto.getItemId());
				List<RoutingMgtDto> routingMgtList = routingMgtService.getRoutingInfo(routingMgtDto);
				
				//라우팅마다 기본 작업정보 생성
				for(RoutingMgtDto routingInfo : routingMgtList) {
					
					//작업정보 생성자
					WrkinTeamMgtDto prodWorkRoutSheetDto = new WrkinTeamMgtDto(returnKey, null, asgnDto.getLotId(), null, 
							routingInfo.getRoutingId(), routingInfo.getEqmtMgtId(), null, asgnDto.getProdAsmQty(), null);
				
					//작업정보 입력
					productWorkMapper.insertProdWorkRoutSheet(prodWorkRoutSheetDto);
				}
			} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				productWorkMapper.updateProdWorkAsgn(asgnDto);
				returnKey = asgnDto.getProdAsmId();
				
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
	@Override
	public int setProdWorkAsgnDelete(List<WrkinTeamMgtDto> asgnList) {
		int resultInt = -1;
		try {
			// 작업지시 삭제
			for (WrkinTeamMgtDto asgnDto : asgnList) {
				productWorkMapper.deleteProdWorkAsgn(asgnDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("작업지시  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
	
	//라우팅시트 조회
	@Override
	public List<WrkinTeamMgtDto> getProdWorkRoutSheetList(WrkinTeamMgtDto asgnDto) {
		List<WrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = productWorkMapper.selectProdWorkRoutSheetList(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("라우팅시트 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<WrkinTeamMgtDto>();
		}
		return asgnList;
	}
	
	//작업지시 저장
	@Transactional
	@Override
	public String setProdWorkRoutSheetSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업지시 등록
				// 작업지시 입력
				productWorkMapper.insertProdWorkRoutSheet(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				productWorkMapper.updateProdWorkRoutSheet(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업지시  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}
	
	//설비교체 리스트 조회
	@Override
	public List<FacilMgtDto> getProdWorkEqmtChangeList(WrkinTeamMgtDto wrkinTeamMgtDto) {
		List<FacilMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = productWorkMapper.selectProdWorkEqmtChangeList(wrkinTeamMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비교체 리스트 조회.(List)" + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilMgtDto>();
		}
		return eqmtMgtList;
	}
	
	// 작업정보 시작 저장
	@Transactional
	@Override
	public String setProdWorkRoutSheetStart(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setProdWorkUser(JteUtils.getUserId());
			
			productWorkMapper.updateProdWorkRoutSheet(asgnDto);
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
	
	// 작업종료 저장
	//설비가동시간, 공구사용, 자재투입등
	@Transactional
	@Override
	public String setProdWorkRoutSheetEnd(WrkinTeamMgtDto asgnDto) {
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
			
			productWorkMapper.updateProdWorkRoutSheet(asgnDto);
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
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(asgnDto.getItemId(),asgnDto.getLotId(),asgnDto.getProdWorkGood(),
						"prod_tagt01", returnKey, nowDateTime, asgnDto.getCreatorId());
				
				//히스토리 table에 등록되어 있다면 C 없다면  U
				itemStockMgtDto.setAction(asgnDto.getQtyAction());
			
				itemStockService.setItemStockPgSave(itemStockMgtDto);	
			}
			
			//공구사용이력 저장
			//1. 현재 작업중인 설비에 장착된 공구 조회(ALL)
			FacilToolMgtDto eqmtToolDto = new FacilToolMgtDto();
			eqmtToolDto.setEqmtMgtId(asgnDto.getEqmtMgtId());
			eqmtToolDto.setRoutingId(asgnDto.getRoutingId());
			List<FacilToolMgtDto> facilToolMgtList = productWorkMapper.selectEqmtToolList(eqmtToolDto);
			
			//2.장착된 공구마다 공구교체가 있었는지 확인하고 여부에 따라 공구 사용량을 입력한다.
			if(facilToolMgtList.size() > 0) {
				for (FacilToolMgtDto facilToolMgtDto : facilToolMgtList) {
					//if(!facilToolMgtDto.getToolMgtGbn().equals("tool_div03")) {}//팁 공구 카운트 예외처리
					//2-1 장비교체 이력이 있는지 확인하고 있다면 얼만큼 사용했는지 값을 가져온다.
					MtrltoolMgtDto toolMgtDto = new MtrltoolMgtDto(asgnDto.getProdWorkId(),facilToolMgtDto.getToolId(), facilToolMgtDto.getToolMgtId(), 
							facilToolMgtDto.getEqmtMgtId(), facilToolMgtDto.getEqipPosition(), asgnDto.getLotId(), 0, asgnDto.getProdWorkStart(), nowDateTime, "");
					
  					int historyCount =  toolMgtService.getToolUseChangeTotal(toolMgtDto);
					
					//2-2 사용이력 등록 = 현재사용량 - 장비교체 이력 카운트 
					toolMgtDto.setToolUseQty(Math.round((asgnDto.getProdWorkGood() * facilToolMgtDto.getToolChange()) + (asgnDto.getProdWorkBad()*facilToolMgtDto.getToolChange()) - historyCount));
					toolMgtDto.setAction(asgnDto.getQtyAction());
					
					//최초등록시에만 공구수명 등록
					if(toolMgtDto.getAction().equals("C")) {
						toolMgtService.setToolUsePgSave(toolMgtDto);
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
	@Override
	public List<FacilToolMgtDto> getProdWorkEqmtToolList(FacilToolMgtDto eqmtToolDto) {
		List<FacilToolMgtDto> eqmtToolList = null;
		try {
			eqmtToolList = productWorkMapper.selectProdWorkEqmtToolList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("장착된 공구 조회에러입니다.(List)" + e.getMessage());
		}
		if (eqmtToolList == null) {
			eqmtToolList = new ArrayList<FacilToolMgtDto>();
		}
		return eqmtToolList;
	}
	
	//사용가능한 공구 조회
	@Override
	public List<FacilToolMgtDto> getProdWorkToolUseableList(FacilToolMgtDto eqmtToolDto) {
		List<FacilToolMgtDto> eqmtToolList = null;
		try {
			eqmtToolList = productWorkMapper.selectProdWorkToolUseableList(eqmtToolDto);
		} catch (Exception e) {
			throw new BusinessException("사용가능한 공구 조회에러입니다.(List)" + e.getMessage());
		}
		if (eqmtToolList == null) {
			eqmtToolList = new ArrayList<FacilToolMgtDto>();
		}
		return eqmtToolList;
	}
			
	//공구등록
	@Transactional
	@Override
	public String setProdWorkEqmtTool(List<FacilToolMgtDto> eqmtToolList) {
		String returnKey = "";
		try {
			//설비공구 장착 입력
			for(FacilToolMgtDto eqmtToolDto : eqmtToolList){
				eqmtToolDto.setCreatorId(JteUtils.getUserId());
				eqmtToolDto.setUpdatorId(JteUtils.getUserId());
				productWorkMapper.insertProdWorkEqmtTool(eqmtToolDto);
				returnKey = eqmtToolDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비-공구등록 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구해제
	@Transactional
	@Override
	public String setProdWorkEqmtToolDel(List<FacilToolMgtDto> eqmtToolList) {
		String returnKey = "";
		try {
			//설비공구 장착 입력
			for(FacilToolMgtDto eqmtToolDto : eqmtToolList){
				eqmtToolDto.setCreatorId(JteUtils.getUserId());
				eqmtToolDto.setUpdatorId(JteUtils.getUserId());
				productWorkMapper.deleteProdWorkEqmtTool(eqmtToolDto);
				returnKey = eqmtToolDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비-공구해제 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구 카운트 등록/수정
//	@Transactional
//	@Override
//	public String setProdWorkEqmtToolCount(FacilToolMgtDto eqmtToolDto) {
//	String returnKey = "";
//	try {
//		asgnDto.setCreatorId(JteUtils.getUserId());
//		//생산지시
//		if (asgnDto.getAction().equals("C")) {// 작업지시 등록
//			// 작업지시 입력
//			productWorkMapper.insertProdWorkEqmtToolCount(eqmtToolDto);
//		} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
//			// 작업지시 수정
//			productWorkMapper.updateProdWorkEqmtToolCount(eqmtToolDto);
//		}
//	} catch (Exception e) {
//		returnKey = "";
//		throw new BusinessException("작업지시  입력 에러 : " + e.getMessage());
//	}
//	return returnKey;
//	}	
		
		
	// 자재투입현황(종합, 상세, 불량)
	@Override
	public List<MtrlUseDto> getProdWorkMtrl(MtrlUseDto mtrlUseDto) {
		List<MtrlUseDto> mtrlUseList = null;
		try {
			if(mtrlUseDto.getAction().equals("TOTAL")) {//종합집계
				mtrlUseList = productWorkMapper.selectProdWorkMtrlTotal(mtrlUseDto);
			}else if(mtrlUseDto.getAction().equals("DETAIL")) { //상세정보
				mtrlUseList = productWorkMapper.selectProdWorkMtrlDetail(mtrlUseDto);
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
	@Override
	public String setProdWorkMtrlSave(MtrlUseDto mtrlUseDto) {
		String returnKey = "";
		try {
			if (mtrlUseDto.getAction().equals("C")) {//자재 사용정보 등록
				// 자재 사용정보 입력
				productWorkMapper.insertProdWorkMtrl(mtrlUseDto);
				returnKey = mtrlUseDto.getMtrlUseId();
				
				
				//자재수량을 저장하기 위한 생성자
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(mtrlUseDto.getMtrlId(), "mtrl_tagt02", returnKey,
						mtrlUseDto.getMtrlUseCnt() * -1, mtrlUseDto.getProdWorkStart(), mtrlUseDto.getProdWorkUser(), mtrlUseDto.getMtrlMgtId(), null);
				mtrlCntDto.setAction("SUBTRACT");//자재 수량 차감
					
				//자재수량 저장
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				
				
			} else if (mtrlUseDto.getAction().equals("U")) {//자재 사용정보 수정
				// 작업정보 수정
				productWorkMapper.updateProdWorkMtrl(mtrlUseDto);
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
	@Override
	public int setProdWorkMtrlDelete(List<MtrlUseDto> mtrlUseList) {
		int resultInt = -1;
		try {
			// 자재 사용정보 삭제
			for (MtrlUseDto mtrlUseDto : mtrlUseList) {
				productWorkMapper.deleteProdWorkMtrl(mtrlUseDto);
				//사용하려면 추가 개발 필요
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재 사용정보  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
	
	//품목 불량 조회
	public List<InfergodsMgtDto> getProdWorkItemBadList(InfergodsMgtDto itemBadDto){
		List<InfergodsMgtDto> itemBadList = null;
		try {
			itemBadList = productWorkMapper.selectItemBadList(itemBadDto);
			
		} catch (Exception e) {
			throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
		}
		if (itemBadList == null) {
			itemBadList = new ArrayList<InfergodsMgtDto>();
		}
		return itemBadList;
	}
	
	//타모듈에서 품목 불량 저장 (불량에 의한 수량을 감소시키지 않는다.)
	@Transactional
	public String setProdWorkItemBadSave(InfergodsMgtDto itemBadDto){
		String returnKey = "";
		try {
			//불량등록
			if(itemBadDto.getAction().equals("C")) {
				productWorkMapper.insertItemBad(itemBadDto);
				returnKey = itemBadDto.getBadId();
			//불량수정
			}else if(itemBadDto.getAction().equals("U")) {
				productWorkMapper.updateItemBad(itemBadDto);
				returnKey = itemBadDto.getBadId();
			//불량삭제
			}else if(itemBadDto.getAction().equals("D")) {
				productWorkMapper.deleteItemBad(itemBadDto);
			}
			
			//작업 불량인 경우 해당 작업에  불량수 update 처리
			if(itemBadDto.getBadTarget().equals("qual_spec03")) {
				InfergodsMgtDto itemBadTotalDto = new InfergodsMgtDto();
				itemBadTotalDto.setBadTargetCode(itemBadDto.getBadTargetCode());
				itemBadTotalDto.setBadTarget(itemBadDto.getBadTarget());
				WrkinTeamMgtDto workInfoDto = new WrkinTeamMgtDto();
				workInfoDto.setProdWorkBad(productWorkMapper.selectItemBadTotal(itemBadTotalDto));
				workInfoDto.setProdWorkId(itemBadDto.getBadTargetCode());
				workInfoDto.setAction("U");
				
				productWorkMapper.updateProdWorkRoutSheet(workInfoDto);
			}
			
			//아이템 수량 저장(아이템 수량 update가 필요한 경우 분기처리하여 주석해제해서 사용)
//					ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(itemBadDto.getItemId(),itemBadDto.getLotId(),itemBadDto.getBadQty(),
//							"prod_tagt01","LOT",null,itemBadDto.getChkUser());
//					
//					itemStockService.setItemStockPgSave(itemStockMgtDto);
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
}
