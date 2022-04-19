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
import jin.mes.cform.basMgt.bom.bomMgt.ZinixBomMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.ZinixRoutingMgtDto;
import jin.mes.cform.basMgt.routing.routingMgt.ZinixRoutingMgtService;
import jin.mes.cform.facilMgt.facilCorMgt.ZinixFacilCorMgtMapper;
import jin.mes.cform.facilMgt.facilToolMgt.ZinixFacilToolMgtService;
import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtService;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtService;
import jin.mes.cform.mtrl.mtrltoolMgt.ZinixMtrltoolMgtService;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixOrderDetailMgtMapper;
import jin.mes.cform.qualMgt.infergodsMgt.ZinixInfergodsMgtDto;
import jin.mes.cform.qualMgt.infergodsMgt.ZinixInfergodsMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//default
@Service
public class ZinixProductWorkService{
	@Resource
	ZinixProductWorkMapper zinixProductWorkMapper;
	
	@Autowired
	ZinixRoutingMgtService routingMgtService;
	
	@Autowired
	AlarmMgtService alarmMgtService;
	
	@Resource
	ZinixFacilCorMgtMapper zinixEqmtMgtMapper;
	
	@Autowired
	ZinixMtrlMgtService mtrlMgtService;
	
	@Autowired
	ZinixItemStockMgtService itemStockService; 
	
	@Autowired
	ZinixFacilToolMgtService facilToolMgtService;
	
	@Autowired
	ZinixMtrltoolMgtService toolMgtService;
	
	@Autowired
	ZinixInfergodsMgtMapper zinixInferGodsMgtMapper;
	
	@Resource
	ZinixOrderDetailMgtMapper zinixOrderDetailMgtMapper;
	
	// 작업정보 조회
	
	public PageInfo<ZinixLotInfoDto> getProductWorkLotList(ZinixLotInfoDto lotInfoDto, PageRequestVo pageRequestVo) {
		List<ZinixLotInfoDto> lotList = null;
		int rowCount = 0;
		// Page Setting
		lotInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		lotInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = zinixProductWorkMapper.selectProdWorkLotCount(lotInfoDto);
			if (rowCount > 0) {
				// List
				lotList = zinixProductWorkMapper.selectProdWorkLotList(lotInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업정보 Lot조회 에러입니다.(List)" + e.getMessage()); 
		}
		if (lotList == null) {
			lotList = new ArrayList<ZinixLotInfoDto>();
		}
		return new PageInfo<ZinixLotInfoDto>(lotList, pageRequestVo, rowCount);
	}
	
	// 작업지시 정보 조회
	
	public List<ZinixWrkinTeamMgtDto> getProdWorkAsgnList(ZinixWrkinTeamMgtDto wrkinTeamMgtDto) {
		List<ZinixWrkinTeamMgtDto> wrkinTeamMgtList = null;
		try {
			wrkinTeamMgtList = zinixProductWorkMapper.selectProdWorkAsgnList(wrkinTeamMgtDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 정보 조회에러입니다.(List)" + e.getMessage());
		}
		if (wrkinTeamMgtList == null) {
			wrkinTeamMgtList = new ArrayList<ZinixWrkinTeamMgtDto>();
		}
		return wrkinTeamMgtList;
	}
	
	// 작업지시 팝업 조회
	public List<ZinixWrkinTeamMgtDto> getProdWorkAsgnDetail(ZinixWrkinTeamMgtDto asgnDto) {
		List<ZinixWrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = zinixProductWorkMapper.selectProdWorkAsgnDetail(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("작업지시 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<ZinixWrkinTeamMgtDto>();
		}
		return asgnList;
	}
			
	// 작업지시 입력/수정
	@Transactional
	public String setProdWorkAsgnSave(ZinixWrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업지시 등록
				if(StringUtils.isEmpty(asgnDto.getProdAsmUser())) {
					asgnDto.setProdAsmUser(JteUtils.getUserId());
				}
				// 작업지시 입력
				zinixProductWorkMapper.insertProdWorkAsgn(asgnDto);
				returnKey = asgnDto.getProdAsmId();
				
				//아이템값으로 라우팅 조회
				ZinixRoutingMgtDto routingMgtDto = new ZinixRoutingMgtDto();
				routingMgtDto.setItemId(asgnDto.getItemId());
				List<ZinixRoutingMgtDto> routingMgtList = routingMgtService.getRoutingInfo(routingMgtDto);
				
				//라우팅마다 기본 작업정보 생성
				for(ZinixRoutingMgtDto routingInfo : routingMgtList) {
					
					//작업정보 생성자
					ZinixWrkinTeamMgtDto prodWorkRoutSheetDto = new ZinixWrkinTeamMgtDto(returnKey, null, asgnDto.getLotId(), null, 
							routingInfo.getRoutingId(), routingInfo.getEqmtMgtId(), null, asgnDto.getProdAsmQty(), null);

					//작업정보 입력
					zinixProductWorkMapper.insertProdWorkRoutSheet(prodWorkRoutSheetDto);
				}
			} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				zinixProductWorkMapper.updateProdWorkAsgn(asgnDto);
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
	public String setProdWorkAsgnDelete(List<ZinixWrkinTeamMgtDto> asgnList) {
		String resultStr = "success";
		try {
			// 작업지시 삭제
			ZinixWrkinTeamMgtDto wrkinTeamMgtDto = new ZinixWrkinTeamMgtDto();
			
			//작업지시 반복
			for (ZinixWrkinTeamMgtDto asgnDto : asgnList) {
				
				wrkinTeamMgtDto.setProdAsmId(asgnDto.getProdAsmId());
				
				List<ZinixWrkinTeamMgtDto> workInfoList = getProdWorkRoutSheetList(wrkinTeamMgtDto);
				
				//작업정보 반복
				for(ZinixWrkinTeamMgtDto workInfo : workInfoList) {
					if(!workInfo.getProdWorkStatus().equals("work_wait")) {
						resultStr="workBad";
						throw new Exception();
					}
					
					//작업정보 삭제 
					zinixProductWorkMapper.deleteProdWorkRoutSheet(asgnDto);
				}
				
				//작업지시 삭제
				zinixProductWorkMapper.deleteProdWorkAsgn(asgnDto);
			}
		} catch (Exception e) {
			if(!resultStr.equals("workBad")) {
				resultStr = "bad";
			}
		}
		return resultStr;
	}
	

	//라우팅시트 조회
	public List<ZinixWrkinTeamMgtDto> getProdWorkRoutSheetList(ZinixWrkinTeamMgtDto asgnDto) {
		List<ZinixWrkinTeamMgtDto> asgnList = null;
		try {
			asgnList = zinixProductWorkMapper.selectProdWorkRoutSheetList(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("라우팅시트 조회 에러입니다.(Pop) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<ZinixWrkinTeamMgtDto>();
		}
		return asgnList;
	}
	
	//작업지시 저장
	@Transactional
	public String setProdWorkRoutSheetSave(ZinixWrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업지시 등록
				// 작업지시 입력
				zinixProductWorkMapper.insertProdWorkRoutSheet(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				zinixProductWorkMapper.updateProdWork(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업지시  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}
	
	// 현재작업 사용자재 조회
	public List<ZinixBomMgtDto> getBomDetailInfo(ZinixWrkinTeamMgtDto asgnDto) {
		List<ZinixBomMgtDto> bomMgtList = null;
		try {
			bomMgtList = zinixProductWorkMapper.selectWorkUseMtrlList(asgnDto);
		} catch (Exception e) {
			throw new BusinessException("현재작업 사용자재 조회에러 : " + e.getMessage());
		}
		return bomMgtList;
	}
	
	// 작업정보 시작 저장
	@Transactional
	public String setProdWorkStart(ZinixWrkinTeamMgtDto asgnDto) {
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
			
			//작업 시작시 LOT 상태변경
			ZinixLotInfoDto lotInfoDto = new ZinixLotInfoDto();
			lotInfoDto.setLotId(asgnDto.getLotId());
			
			//lot 조회
			lotInfoDto = zinixOrderDetailMgtMapper.selectLotList(lotInfoDto).get(0);
			
			//작업대기상태인 경우 작업 진행으로 변경(LOT)
			if(lotInfoDto.getLotState().equals("ord_sta01")) {
				lotInfoDto.setUpdatorId(JteUtils.getUserId());
				lotInfoDto.setLotState("ord_sta01");
				zinixOrderDetailMgtMapper.updateLotInfo(lotInfoDto);
			}
			
			
			//작업진행중으로 상태 변경
			asgnDto.setProdAsmState("prod_sta01");
			
			zinixProductWorkMapper.updateProdWork(asgnDto);
			// 작업지시 수정
			zinixProductWorkMapper.updateProdWorkAsgn(asgnDto);
			
			returnKey = asgnDto.getProdWorkId();
			
			//자재수량 차감을 위한 데이터 insert(초기값 0으로 insert)
			List<ZinixBomMgtDto> workUseMtrlList = zinixProductWorkMapper.selectWorkUseMtrlList(asgnDto);
			
			for(ZinixBomMgtDto workUseMtrl : workUseMtrlList) {
				//자재수량을 저장하기 위한 생성자
				if(workUseMtrl.getBomTarget().equals("prcs_bom02")) {
					ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto(workUseMtrl.getBomTargetId(), "mtrl_tagt02", returnKey,
							0, asgnDto.getProdWorkStart(), asgnDto.getProdWorkUser(), workUseMtrl.getMtrlMgtId(), asgnDto.getLotId());
					mtrlCntDto.setAction("SUBTRACT");//자재 수량 차감
						
					//자재수량 저장
					mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보  시작 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	// 작업정보 카운트(+1)
	@Transactional
	public String setProdWorkCount(ZinixWrkinTeamMgtDto asgnDto) {
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
			zinixProductWorkMapper.updateProdWork(asgnDto);
			
			returnKey = asgnDto.getProdWorkId();
			
			//2.품목수량 등록
			if(asgnDto.getBomTarget().equals("prcs_bom01")) {
				ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto(asgnDto.getItemId(),asgnDto.getLotId(),Integer.parseInt(asgnDto.getProdWorkGood()),
						"prod_tagt01", returnKey, nowDateTime, asgnDto.getCreatorId());
				
				//히스토리 table에 등록되어 있다면 C 없다면  U
				if(zinixProductWorkMapper.countQmItemInfo(itemStockMgtDto) > 0) {
					itemStockMgtDto.setAction("U");
				}else {
					itemStockMgtDto.setAction("C");
				}
				
				//품목 생산 저장
				itemStockService.setItemStockPgSave(itemStockMgtDto);	
			}
			
			
			//해당 작업에서 사용되는 자재 조회
			List<ZinixBomMgtDto> workUseMtrlList = zinixProductWorkMapper.selectWorkUseMtrlList(asgnDto);
			
			//3.자재사용이력 + 자재관리 수량 저장
			for(ZinixBomMgtDto workUseMtrl : workUseMtrlList) {
				//자재수량을 저장하기 위한 생성자
				if(workUseMtrl.getBomTarget().equals("prcs_bom02")) {
					ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto(workUseMtrl.getBomTargetId(), "mtrl_tagt02", returnKey,
							workUseMtrl.getBomTargetCnt()*Integer.parseInt(asgnDto.getProdWorkGood()) * -1, asgnDto.getProdWorkStart(), asgnDto.getProdWorkUser(), workUseMtrl.getMtrlMgtId(), asgnDto.getLotId());
					
					//자재사용이력에 등록되어 있는지 확인하고 있으면 update 없으면 insert 해줌
					if(zinixProductWorkMapper.countQmMtrlInfo(mtrlCntDto) > 0) {
						mtrlCntDto.setAction("U");//자재 사용수량 변경
					}else {
						mtrlCntDto.setAction("SUBTRACT");//자재 수량 차감
					}
					
					//자재수량 저장
					mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
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
	public String setProdWorkEnd(ZinixWrkinTeamMgtDto asgnDto) {
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
			
			zinixProductWorkMapper.updateProdWork(asgnDto);
			returnKey = asgnDto.getProdWorkId();
			
			//마지막 공정 종료시 작업지시 상태값 변경
			if(asgnDto.getBomTarget().equals("prcs_bom01")) {
				asgnDto.setProdAsmState("prod_sta02");
				zinixProductWorkMapper.updateProdWorkAsgn(asgnDto);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업정보 저장(종료) 에러" + e.getMessage());
		}
		return returnKey;
	}
	
	//bom기준 자재소요량  조회
	public List<ZinixBomMtrlDto> getBomMtrlList(ZinixBomMtrlDto zinixBomMtrlDto) {
		List<ZinixBomMtrlDto> bomMtrlList = null;
		try {
			bomMtrlList = zinixProductWorkMapper.selectBomMtrlList(zinixBomMtrlDto);
		} catch (Exception e) {
			throw new BusinessException("bom기준 자재소요량 조회 에러입니다.: " + e.getMessage());
		}
		if (bomMtrlList == null) {
			bomMtrlList = new ArrayList<ZinixBomMtrlDto>();
		}
		return bomMtrlList;
	}
	
	//bom기준 자재소요량 상세 조회
	public List<ZinixBomMtrlDto> getBomMtrlDetail(ZinixBomMtrlDto zinixBomMtrlDto) {
		List<ZinixBomMtrlDto> bomMtrlList = null;
		try {
			bomMtrlList = zinixProductWorkMapper.selectBomMtrlDetail(zinixBomMtrlDto);
		} catch (Exception e) {
			throw new BusinessException("bom기준 자재소요량 상세 조회 에러입니다. : " + e.getMessage());
		}
		if (bomMtrlList == null) {
			bomMtrlList = new ArrayList<ZinixBomMtrlDto>();
		}
		return bomMtrlList;
	}
	
	//자재불량 조회 - 작업불량만
	public List<ZinixInfergodsMgtDto> getMtrlBadInfo(ZinixInfergodsMgtDto mtrlBadDto) {
		List<ZinixInfergodsMgtDto> bomMtrlList = null;
		try {
			bomMtrlList = zinixProductWorkMapper.selectMtrlBadInfo(mtrlBadDto);
		} catch (Exception e) {
			throw new BusinessException("자재불량 조회 에러입니다. : " + e.getMessage());
		}
		if (bomMtrlList == null) {
			bomMtrlList = new ArrayList<ZinixInfergodsMgtDto>();
		}
		return bomMtrlList;
	}
	
	//자재 불량 저장
	@Transactional
	public String setMtrlBadSave(ZinixInfergodsMgtDto badDto){
		String returnKey = "";
		try {
			if(badDto.getAction().equals("C")) {
				//불량관리 저장
				zinixInferGodsMgtMapper.insertMtrlBad(badDto);
				returnKey = badDto.getBadId();
				
				//불량품 수량을 등록하기 위한 생성자
				ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
						badDto.getBadQty()*-1, badDto.getChkDate(), badDto.getChkUser() ,badDto.getMtrlMgtId(), badDto.getLotId());
				
				//불량히스토리를 등록하고 자재수량을 갱신
				mtrlCntDto.setAction("SUBTRACT");					
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
			}else if(badDto.getAction().equals("U")){
				//불량관리 저장
				zinixInferGodsMgtMapper.updateMtrlBad(badDto);
				returnKey =badDto.getBadId();
				
				//불량품 수량을 수정하기 위한 생성자
				ZinixMtrlHistoryDto badCntDto = new ZinixMtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
						badDto.getBadQty()*-1, badDto.getChkDate(), badDto.getChkUser() ,badDto.getMtrlMgtId(), badDto.getLotId());
				
				//불량히스토리를 수정하고 자재수량을 갱신
				badCntDto.setAction("U");
				mtrlMgtService.setMtrlMgtPgSave(badCntDto);
			}
			
			//불량건수만큼 불량량 카운트 - 주의 : 불량필드의 값은 소모한 자재이기 때문에 불량rows로 계산한다.
			ZinixWrkinTeamMgtDto prodWorkDto = new ZinixWrkinTeamMgtDto();
			prodWorkDto.setProdWorkId(badDto.getBadTargetCode());
			
			//불량건수 조회
			prodWorkDto.setProdWorkBad(String.valueOf(zinixProductWorkMapper.countMtrlBadWorkInfo(badDto)));
			
			//작업정보 불량 저장
			zinixProductWorkMapper.updateProdWork(prodWorkDto);
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재  러 : " + e.getMessage());
		}
		return returnKey;
	}
}
