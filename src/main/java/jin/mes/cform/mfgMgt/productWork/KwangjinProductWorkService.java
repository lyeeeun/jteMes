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

import jin.mes.common.alarm.AlarmMgtService;
import jin.mes.form.basMgt.bom.bomMgt.BomMgtDto;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtDto;
import jin.mes.form.basMgt.routing.routingMgt.RoutingMgtService;
import jin.mes.cform.facilMgt.facilCorMgt.KwangjinFacilCorMgtDto;
import jin.mes.cform.facilMgt.facilCorMgt.KwangjinFacilCorMgtMapper;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtService;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import jin.mes.cform.orderMgt.orderDetailMgt.KwangjinLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.KwangjinOrderDetailMgtMapper;
import jin.mes.cform.qualMgt.infergodsMgt.KwangjinInfergodsMgtDto;
import jin.mes.cform.qualMgt.infergodsMgt.KwangjinInfergodsMgtMapper;
import jin.mes.cform.facilMgt.mtrltoolMgt.KwangjinMtrltoolMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//default
@Service
public class KwangjinProductWorkService{
	@Resource
	KwangjinProductWorkMapper kwangjinProductWorkMapper;
	
	@Autowired
	RoutingMgtService routingMgtService;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	@Resource
	KwangjinFacilCorMgtMapper kwangjinFacilCorMgtMapper;
	
	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@Autowired
	ItemStockMgtService itemStockService; 
	
	@Autowired
	KwangjinMtrltoolMgtService toolMgtService;
	
	@Autowired
	KwangjinInfergodsMgtMapper kwangjinInferGodsMgtMapper;
	
	@Resource
	KwangjinOrderDetailMgtMapper kwangjinOrderDetailMgtMapper;
	
	// 작업정보 조회
	
	public PageInfo<KwangjinLotInfoDto> getProductWorkLotList(KwangjinLotInfoDto lotInfoDto, PageRequestVo pageRequestVo) {
		List<KwangjinLotInfoDto> lotList = null;
		int rowCount = 0;
		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = kwangjinProductWorkMapper.selectProdWorkLotCount(lotInfoDto);
			if (rowCount > 0) {
				// List
				lotList = kwangjinProductWorkMapper.selectProdWorkLotList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업정보 Lot조회 에러입니다.(List)" + e.getMessage()); 
		}
		if (lotList == null) {
			lotList = new ArrayList<KwangjinLotInfoDto>();
		}
		return new PageInfo<KwangjinLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	// 작업지시 정보 조회
	public List<WrkinTeamMgtDto> getProdWorkAsgnList(WrkinTeamMgtDto wrkinTeamMgtDto) {
		List<WrkinTeamMgtDto> wrkinTeamMgtList = null;
		try {
			wrkinTeamMgtList = kwangjinProductWorkMapper.selectProdWorkAsgnList(wrkinTeamMgtDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 정보 조회에러입니다.(List)" + e.getMessage());
		}
		if (wrkinTeamMgtList == null) {
			wrkinTeamMgtList = new ArrayList<WrkinTeamMgtDto>();
		}
		return wrkinTeamMgtList;
	}
	
	// 작업지시 팝업 조회
	public List<WrkinTeamMgtDto> getProdWorkAsgnDetail(WrkinTeamMgtDto asgnDto) {
		List<WrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = kwangjinProductWorkMapper.selectProdWorkAsgnDetail(asgnDto);
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
				kwangjinProductWorkMapper.insertProdWorkAsgn(asgnDto);
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
					kwangjinProductWorkMapper.insertProdWorkRoutSheet(prodWorkRoutSheetDto);
				}
			} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				kwangjinProductWorkMapper.updateProdWorkAsgn(asgnDto);
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
	@Transactional(rollbackFor = {Exception.class})
	public String setProdWorkAsgnDelete(List<WrkinTeamMgtDto> asgnList) {
		String resultStr = "success";
		try {
			// 작업지시 삭제
			WrkinTeamMgtDto wrkinTeamMgtDto = new WrkinTeamMgtDto();
			
			//작업지시 반복
			for (WrkinTeamMgtDto asgnDto : asgnList) {
				
				wrkinTeamMgtDto.setProdAsmId(asgnDto.getProdAsmId());
				
				List<WrkinTeamMgtDto> workInfoList = getProdWorkRoutSheetList(wrkinTeamMgtDto);
				
				//작업정보 반복
				for(WrkinTeamMgtDto workInfo : workInfoList) {
					if(!workInfo.getProdWorkStatus().equals("work_wait")) {
						resultStr="workBad";
						throw new Exception();
					}
					
					//작업정보 삭제 
					kwangjinProductWorkMapper.deleteProdWorkRoutSheet(asgnDto);
				}
				
				//작업지시 삭제
				kwangjinProductWorkMapper.deleteProdWorkAsgn(asgnDto);
			}
		} catch (Exception e) {
			if(!resultStr.equals("workBad")) {
				resultStr = "bad";
			}
		}
		return resultStr;
	}
	

	//라우팅시트 조회
	public List<WrkinTeamMgtDto> getProdWorkRoutSheetList(WrkinTeamMgtDto asgnDto) {
		List<WrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = kwangjinProductWorkMapper.selectProdWorkRoutSheetList(asgnDto);
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
	public String setProdWorkRoutSheetSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업지시 등록
				// 작업지시 입력
				kwangjinProductWorkMapper.insertProdWorkRoutSheet(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				kwangjinProductWorkMapper.updateProdWork(asgnDto);
				
				kwangjinProductWorkMapper.updateProdWorkEqmtOff(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업지시  입력 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//설비교체 리스트 조회
	public List<FacilMgtDto> getProdWorkEqmtChangeList(WrkinTeamMgtDto wrkinTeamMgtDto) {
		List<FacilMgtDto> eqmtMgtList = null;
		try {
			eqmtMgtList = kwangjinProductWorkMapper.selectProdWorkEqmtChangeList(wrkinTeamMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비교체 리스트 조회.(List)" + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilMgtDto>();
		}
		return eqmtMgtList;
	}

	// 현재작업 사용자재 조회
	public List<BomMgtDto> getBomDetailInfo(WrkinTeamMgtDto asgnDto) {
		List<BomMgtDto> bomMgtList = null;
		try {
			bomMgtList = kwangjinProductWorkMapper.selectWorkUseMtrlList(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("현재작업 사용자재 조회에러 : " + e.getMessage());
		}
		return bomMgtList;
	}
	
	
	// 작업정보 시작 저장
	@Transactional
	public String setProdWorkStart(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setProdWorkUser(JteUtils.getUserId());
			
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = ""; 
			
			//등록된 시간이 없다면 시스템 시간으로 계산하여 등록
			if(StringUtils.isEmpty(asgnDto.getProdWorkStart())) {
				nowDateTime = dateFormat.format(dateTime);
			}else {
				nowDateTime = asgnDto.getProdWorkStart(); 
			}
			
			//현재시간 세팅
			asgnDto.setProdWorkStart(nowDateTime);
			
			asgnDto.setProdWorkStatus("work_prs");
			
//			//작업 시작시 LOT 상태변경
//			KwangjinLotInfoDto lotInfoDto = new KwangjinLotInfoDto();
//			lotInfoDto.setLotId(asgnDto.getLotId());
//			
//			//lot 조회
//			lotInfoDto = kwangjinOrderDetailMgtMapper.selectLotList(lotInfoDto).get(0);
//			
//			//작업대기상태인 경우 작업 진행으로 변경(LOT)
//			if(lotInfoDto.getLotState().equals("ord_sta01")) {
//				lotInfoDto.setUpdatorId(JteUtils.getUserId());
//				lotInfoDto.setLotState("ord_sta02");
//				kwangjinOrderDetailMgtMapper.updateLotInfo(lotInfoDto);
//			}
			
			
			//작업진행중으로 상태 변경
			asgnDto.setProdAsmState("prod_sta01");
			
			kwangjinProductWorkMapper.updateProdWork(asgnDto);
			// 작업지시 수정
			kwangjinProductWorkMapper.updateAsgnState(asgnDto);
			
			returnKey = asgnDto.getProdWorkId();
			
			//자재수량 차감을 위한 데이터 insert(초기값 0으로 insert)
//			List<BomMgtDto> workUseMtrlList = kwangjinProductWorkMapper.selectWorkUseMtrlList(asgnDto);
//			
//			for(BomMgtDto workUseMtrl : workUseMtrlList) {
//				//자재수량을 저장하기 위한 생성자
//				if(workUseMtrl.getBomTarget().equals("prcs_bom02")) {
//					MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(workUseMtrl.getBomTargetId(), "mtrl_tagt02", returnKey,
//							0, asgnDto.getProdWorkStart(), asgnDto.getProdWorkUser(), workUseMtrl.getMtrlMgtId(), asgnDto.getLotId());
//					mtrlCntDto.setAction("SUBTRACT");//자재 수량 차감
//					
//					//자재수량 저장
//					mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
//				}
//			}
			
			//설비 가동 시작 -- PLC로 체크하는경우 설비가동 삭제
			if(!StringUtils.isEmpty(asgnDto.getEqmtMgtId()) && !asgnDto.getEqmtMgtId().equals("")) {
				KwangjinFacilCorMgtDto eqmtMgtDto = new KwangjinFacilCorMgtDto();
				eqmtMgtDto.setEqmtMgtId(asgnDto.getEqmtMgtId());
				eqmtMgtDto.setEqmtWorkStart(asgnDto.getProdWorkStart());
				eqmtMgtDto.setProdWorkId(asgnDto.getProdWorkId());
				kwangjinFacilCorMgtMapper.insertEqmtWork(eqmtMgtDto);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  시작 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	// 작업정보 카운트(+1)
	@Transactional
	public String setProdWorkCount(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			//현재시각
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = dateFormat.format(dateTime);

			
			if(asgnDto.getWorkAction().equals("P")) {
				//작업수량 +1 증가
				asgnDto.setProdWorkGood(String.valueOf(Integer.parseInt(asgnDto.getProdWorkGood())+1));
			}else if(asgnDto.getWorkAction().equals("M")) {
				//작업수량 -1 감소
				asgnDto.setProdWorkGood(String.valueOf(Integer.parseInt(asgnDto.getProdWorkGood())-1));
			}
			
			// 1.작업정보 저장
			kwangjinProductWorkMapper.updateProdWork(asgnDto);
			
			returnKey = asgnDto.getProdWorkId();
			
			//2.품목수량 등록
			if(asgnDto.getBomTarget().equals("prcs_bom01")) {
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(asgnDto.getItemId(),asgnDto.getLotId(),Integer.parseInt(asgnDto.getProdWorkGood()),
						"prod_tagt01", returnKey, nowDateTime, asgnDto.getCreatorId());
				
				//히스토리 table에 등록되어 있다면 C 없다면  U
				if(kwangjinProductWorkMapper.countQmItemInfo(itemStockMgtDto) > 0) {
					itemStockMgtDto.setAction("U");
				}else {
					itemStockMgtDto.setAction("C");
				}
			}
			
			
			//해당 작업에서 사용되는 자재 조회
			List<BomMgtDto> workUseMtrlList = kwangjinProductWorkMapper.selectWorkUseMtrlList(asgnDto);
			
			//3.자재사용이력 + 자재관리 수량 저장
			for(BomMgtDto workUseMtrl : workUseMtrlList) {
				//자재수량을 저장하기 위한 생성자
				if(workUseMtrl.getBomTarget().equals("prcs_bom02")) {
					MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(workUseMtrl.getBomTargetId(), "mtrl_tagt02", returnKey,
							workUseMtrl.getBomTargetCnt()*Integer.parseInt(asgnDto.getProdWorkGood()) * -1, asgnDto.getProdWorkStart(), asgnDto.getProdWorkUser(), workUseMtrl.getMtrlMgtId(), asgnDto.getLotId());
					
					//자재사용이력에 등록되어 있는지 확인하고 있으면 update 없으면 insert 해줌
					if(kwangjinProductWorkMapper.countQmMtrlInfo(mtrlCntDto) > 0) {
						mtrlCntDto.setAction("U");//자재 사용수량 변경
					}else {
						mtrlCntDto.setAction("SUBTRACT");//자재 수량 차감
					}
					
					//자재수량 저장
					//mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  카운트 증가 에러 : " + e.getMessage());
		}
		return returnKey;
	}

	// 작업종료 저장
	@Transactional
	public String setProdWorkEnd(WrkinTeamMgtDto asgnDto) {
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
			
			//작업종료 상태
			asgnDto.setProdWorkStatus("work_end");
			
			//종료시간 세팅
			asgnDto.setProdWorkEnd(nowDateTime);
			
			kwangjinProductWorkMapper.updateProdWork(asgnDto);
			
			kwangjinProductWorkMapper.updateProdWorkEqmtOn(asgnDto);
			returnKey = asgnDto.getProdWorkId();
			
			//마지막 공정 종료시 작업지시 상태값 변경
			if(asgnDto.getBomTarget().equals("prcs_bom01")) {
				asgnDto.setProdAsmState("prod_sta02");
				kwangjinProductWorkMapper.updateAsgnState(asgnDto);
			}
			
			//작업 시작시 LOT 상태변경
			KwangjinLotInfoDto lotInfoDto = new KwangjinLotInfoDto();
			lotInfoDto.setLotId(asgnDto.getLotId());
			
			//lot 조회
			lotInfoDto = kwangjinOrderDetailMgtMapper.selectLotList(lotInfoDto).get(0);
			
			if(lotInfoDto.getLotQty() == Integer.parseInt(asgnDto.getProdAsmQty()) || lotInfoDto.getLotQty() < Integer.parseInt(asgnDto.getProdAsmQty())) {
				//작업대기상태인 경우 작업 진행으로 변경(LOT)
				if(lotInfoDto.getLotState().equals("ord_sta01")) {
					lotInfoDto.setUpdatorId(JteUtils.getUserId());
					lotInfoDto.setLotState("ord_sta02");
					kwangjinOrderDetailMgtMapper.updateLotInfo(lotInfoDto);
				}
			}
			
			//설비 가동 종료 -- PLC로 체크하는경우 설비가동 삭제
			if(!StringUtils.isEmpty(asgnDto.getEqmtMgtId()) && !asgnDto.getEqmtMgtId().equals("")) {
				KwangjinFacilCorMgtDto eqmtMgtDto = new KwangjinFacilCorMgtDto();
				eqmtMgtDto.setEqmtMgtId(asgnDto.getEqmtMgtId());
				eqmtMgtDto.setEqmtWorkEnd(asgnDto.getProdWorkEnd());
				eqmtMgtDto.setProdWorkId(asgnDto.getProdWorkId());
	 			kwangjinFacilCorMgtMapper.updateEqmtWork(eqmtMgtDto);
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보 저장(종료) 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public String setProdWorkStop(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = dateFormat.format(dateTime);
			
			//작업중지 상태
			asgnDto.setProdWorkStatus("workStop");
			
			kwangjinProductWorkMapper.updateProdWork(asgnDto);
			
			returnKey = asgnDto.getProdWorkId();
			
			
			//설비 가동 종료 -- PLC로 체크하는경우 설비가동 삭제
			if(!StringUtils.isEmpty(asgnDto.getEqmtMgtId()) && !asgnDto.getEqmtMgtId().equals("")) {
				KwangjinFacilCorMgtDto eqmtMgtDto = new KwangjinFacilCorMgtDto();
				eqmtMgtDto.setEqmtMgtId(asgnDto.getEqmtMgtId());
				eqmtMgtDto.setEqmtWorkEnd(nowDateTime);
				eqmtMgtDto.setProdWorkId(asgnDto.getProdWorkId());
				kwangjinFacilCorMgtMapper.updateEqmtWork(eqmtMgtDto);
			}
		
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보 저장(종료) 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	//bom기준 자재소요량  조회
	public List<KwangjinBomMtrlDto> getBomMtrlList(KwangjinBomMtrlDto bomMtrlDto) {
		List<KwangjinBomMtrlDto> bomMtrlList = null;
		try {
			bomMtrlList = kwangjinProductWorkMapper.selectBomMtrlList(bomMtrlDto);
		} catch (Exception e) {
			throw new BusinessException("bom기준 자재소요량 조회 에러입니다.: " + e.getMessage());
		}
		if (bomMtrlList == null) {
			bomMtrlList = new ArrayList<KwangjinBomMtrlDto>();
		}
		return bomMtrlList;
	}
	
	//bom기준 자재소요량 상세 조회
	public List<KwangjinBomMtrlDto> getBomMtrlDetail(KwangjinBomMtrlDto bomMtrlDto) {
		List<KwangjinBomMtrlDto> bomMtrlList = null;
		try {
			bomMtrlList = kwangjinProductWorkMapper.selectBomMtrlDetail(bomMtrlDto);
		} catch (Exception e) {
			throw new BusinessException("bom기준 자재소요량 상세 조회 에러입니다. : " + e.getMessage());
		}
		if (bomMtrlList == null) {
			bomMtrlList = new ArrayList<KwangjinBomMtrlDto>();
		}
		return bomMtrlList;
	}
	
	//자재불량 조회 - 작업불량만
	public List<KwangjinInfergodsMgtDto> getMtrlBadInfo(KwangjinInfergodsMgtDto mtrlBadDto) {
		List<KwangjinInfergodsMgtDto> bomMtrlList = null;
		try {
			bomMtrlList = kwangjinProductWorkMapper.selectMtrlBadInfo(mtrlBadDto);
		} catch (Exception e) {
			throw new BusinessException("자재불량 조회 에러입니다. : " + e.getMessage());
		}
		if (bomMtrlList == null) {
			bomMtrlList = new ArrayList<KwangjinInfergodsMgtDto>();
		}
		return bomMtrlList;
	}
	
	//자재 불량 저장
	@Transactional
	public String setMtrlBadSave(KwangjinInfergodsMgtDto badDto){
		String returnKey = "";
		try {
			if(badDto.getAction().equals("C")) {
				//불량관리 저장
				kwangjinInferGodsMgtMapper.insertMtrlBad(badDto);
				returnKey = badDto.getBadId();
				
				//불량품 수량을 등록하기 위한 생성자
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
						badDto.getBadQty()*-1, badDto.getChkDate(), badDto.getChkUser() ,badDto.getMtrlMgtId(), badDto.getLotId());
				
				//불량히스토리를 등록하고 자재수량을 갱신
				mtrlCntDto.setAction("SUBTRACT");					
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
			}else if(badDto.getAction().equals("U")){
				//불량관리 저장
				kwangjinInferGodsMgtMapper.updateMtrlBad(badDto);
				returnKey =badDto.getBadId();
				
				//불량품 수량을 수정하기 위한 생성자
				MtrlHistoryDto badCntDto = new MtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
						badDto.getBadQty()*-1, badDto.getChkDate(), badDto.getChkUser() ,badDto.getMtrlMgtId(), badDto.getLotId());
				
				//불량히스토리를 수정하고 자재수량을 갱신
				badCntDto.setAction("U");
				mtrlMgtService.setMtrlMgtPgSave(badCntDto);
			}
			
			//불량건수만큼 불량량 카운트 - 주의 : 불량필드의 값은 소모한 자재이기 때문에 불량rows로 계산한다.
			WrkinTeamMgtDto prodWorkDto = new WrkinTeamMgtDto();
			prodWorkDto.setProdWorkId(badDto.getBadTargetCode());
			
			//불량건수 조회
			prodWorkDto.setProdWorkBad(String.valueOf(kwangjinProductWorkMapper.countMtrlBadWorkInfo(badDto)));
			
			//작업정보 불량 저장
			kwangjinProductWorkMapper.updateProdWork(prodWorkDto);
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재 불량 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
}
