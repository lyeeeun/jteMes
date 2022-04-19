package jin.mes.cform.qualMgt.infergodsMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.ZinixItemStockMgtMapper;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.ZinixWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.ZinixWrkinWrkerMgtService;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.ZinixMtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixInfergodsMgtService {
	@Resource
	ZinixInfergodsMgtMapper zinixInfergodsMgtMapper;
	
	@Resource
	ZinixItemStockMgtMapper zinixItemStockMgtMapper;

	@Autowired
	ZinixMtrlMgtService mtrlMgtService;
	
	@Autowired
	ZinixWrkinWrkerMgtService workInfoService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	//자재 불량 관리 조회
	public PageInfo<ZinixInfergodsMgtDto> getMtrlBadList(ZinixInfergodsMgtDto mtrlBadDto, PageRequestVo pageRequestVo){
		List<ZinixInfergodsMgtDto> mtrlBadList = null;
		int rowCount = 0;

		// Page Setting
		mtrlBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlBadDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixInfergodsMgtMapper.selectMtrlBadCount(mtrlBadDto);
			if (rowCount > 0) {
				//List
				mtrlBadList = zinixInfergodsMgtMapper.selectMtrlBadList(mtrlBadDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재불량 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlBadList == null) {
			mtrlBadList = new ArrayList<ZinixInfergodsMgtDto>();
		}
		return new PageInfo<ZinixInfergodsMgtDto>(mtrlBadList, pageRequestVo, rowCount);
	}
		
		//자재 불량 관리 저장
		@Transactional
		public String setMtrlBadSave(ZinixInfergodsMgtDto badDto){
			String returnKey = "";
			try {
				if(badDto.getAction().equals("C")) {
					//불량관리 저장
					zinixInfergodsMgtMapper.insertMtrlBad(badDto);
					returnKey = badDto.getBadId();
					
					//불량품 수량을 등록하기 위한 생성자
					ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
							badDto.getBadQty()*-1, badDto.getChkDate(), badDto.getChkUser() ,badDto.getMtrlMgtId(), badDto.getLotId());
					
					//불량히스토리를 등록하고 자재수량을 갱신
					mtrlCntDto.setAction("SUBTRACT");
					mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
					
					//첨부파일 저장
					if(badDto.getInsertAttach() != null && badDto.getInsertAttach().size() > 0) {
						String target = badDto.getCurrentMenuId();
						String targetCode = returnKey;
						attachMgtService.attachFilesSave(badDto.getInsertAttach(), target, targetCode);
					}
					//첨부파일 삭제
					if(badDto.getDeleteAttach() != null && badDto.getDeleteAttach().size() > 0) {
						attachMgtService.attachFilesDelete(badDto.getDeleteAttach());
					}
					
				}else if(badDto.getAction().equals("U")){
					//불량관리 저장
					zinixInfergodsMgtMapper.updateMtrlBad(badDto);
					returnKey =badDto.getBadId();
					
					//불량품 수량을 수정하기 위한 생성자
					ZinixMtrlHistoryDto badCntDto = new ZinixMtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
							badDto.getBadQty()*-1, badDto.getChkDate(), badDto.getChkUser() ,badDto.getMtrlMgtId(), badDto.getLotId());
					
					
					//불량히스토리를 수정하고 자재수량을 갱신
					badCntDto.setAction("U");
					mtrlMgtService.setMtrlMgtPgSave(badCntDto);
					
					//첨부파일 저장
					if(badDto.getInsertAttach() != null && badDto.getInsertAttach().size() > 0) {
						String target = badDto.getCurrentMenuId();
						String targetCode = returnKey;
						attachMgtService.attachFilesSave(badDto.getInsertAttach(), target, targetCode);
					}
					//첨부파일 삭제
					if(badDto.getDeleteAttach() != null && badDto.getDeleteAttach().size() > 0) {
						attachMgtService.attachFilesDelete(badDto.getDeleteAttach());
					}
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("자재/품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		
		//자재 불량 관리 삭제
		@Transactional
		public int setMtrlBadDelete(List<ZinixInfergodsMgtDto> mtrlBadList){
			int resultInt = -1;
			try {
				//불량관리 삭제
				for(ZinixInfergodsMgtDto mtrlBadDto : mtrlBadList){
					//불량품 수량을 삭제하기 위한 생성자
					zinixInfergodsMgtMapper.deleteMtrlBad(mtrlBadDto);
					ZinixMtrlHistoryDto mtrlCntDto = new ZinixMtrlHistoryDto();
					mtrlCntDto.setMtrlMgtId(mtrlBadDto.getMtrlMgtId());
					mtrlCntDto.setMtrlQtyTarget("mtrl_tagt03");
					mtrlCntDto.setMtrlQtyTargetCode(mtrlBadDto.getBadId());
					
					//불량품 수량을 삭제하고 자재수량 갱신
					mtrlCntDto.setAction("D");
					mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
					
					//첨부파일 삭제
					if(mtrlBadDto.getDeleteAttach() != null && mtrlBadDto.getDeleteAttach().size() > 0) {
						attachMgtService.attachFilesDelete(mtrlBadDto.getDeleteAttach());
					}
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("자재불량 삭제 에러 : " + e.getMessage());
			}
			return resultInt;
		}
		
		//품목 불량 조회
		public PageInfo<ZinixInfergodsMgtDto> getItemBadList(ZinixInfergodsMgtDto itemBadDto, PageRequestVo pageRequestVo){
			List<ZinixInfergodsMgtDto> itemBadList = null;
			int rowCount = 0;
	
			// Page Setting
			itemBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			itemBadDto.setLastIndex(pageRequestVo.getBlockLastPage());
	
			try {
				//Count
				rowCount = zinixInfergodsMgtMapper.selectItemBadCount(itemBadDto);
				if (rowCount > 0) {
					//List
					itemBadList = zinixInfergodsMgtMapper.selectItemBadList(itemBadDto);
				}
			} catch (Exception e) {
				throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
			}
			if (itemBadList == null) {
				itemBadList = new ArrayList<ZinixInfergodsMgtDto>();
			}
			return new PageInfo<ZinixInfergodsMgtDto>(itemBadList, pageRequestVo, rowCount);
		}
		
		//품목 불량 저장
		@Transactional
		public String setItemBadSave(ZinixInfergodsMgtDto itemBadDto){
			String returnKey = "";
			try {
				if(itemBadDto.getAction().equals("C")) {
					itemBadDto.setChkUser(JteUtils.getUserId());
					itemBadDto.setBadTarget("qual_spec06");
					itemBadDto.setBadTargetCode("ADMIN");
					zinixInfergodsMgtMapper.insertItemBad(itemBadDto);
					returnKey = itemBadDto.getBadId();

					//생산 완료 된 품목에 한해서 관리자 불량 등록 시 수량 변경
					ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					zinixItemStockMgtMapper.insertItemStockHistory(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(zinixItemStockMgtMapper.selectItemStock(itemStockMgtDto));
						
					zinixItemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(zinixItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					zinixItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
					
				} else if(itemBadDto.getAction().equals("U")){
					itemBadDto.setChkUser(JteUtils.getUserId());
					zinixInfergodsMgtMapper.updateMtrlBad(itemBadDto);
					
					ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					zinixItemStockMgtMapper.updateTargetStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(zinixItemStockMgtMapper.selectItemStock(itemStockMgtDto));
					
					zinixItemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(zinixItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					zinixItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		//품목 불량 저장
		@Transactional
		public String setItemBadQualSave(ZinixInfergodsMgtDto itemBadDto){
			String returnKey = "";
			try {
				if(itemBadDto.getAction().equals("C")) {
					itemBadDto.setChkUser(JteUtils.getUserId());
					itemBadDto.setBadTarget("qual_spec07");
					itemBadDto.setBadTargetCode("FINAL");
					zinixInfergodsMgtMapper.insertItemBad(itemBadDto);
					returnKey = itemBadDto.getBadId();

					//생산 완료 된 품목에 한해서 관리자 불량 등록 시 수량 변경
					ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					zinixItemStockMgtMapper.insertItemStockHistory(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(zinixItemStockMgtMapper.selectItemStock(itemStockMgtDto));
						
					zinixItemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(zinixItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					zinixItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
					
				} else if(itemBadDto.getAction().equals("U")){
					itemBadDto.setChkUser(JteUtils.getUserId());
					zinixInfergodsMgtMapper.updateMtrlBad(itemBadDto);
					
					ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					zinixItemStockMgtMapper.updateTargetStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(zinixItemStockMgtMapper.selectItemStock(itemStockMgtDto));
					
					zinixItemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(zinixItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					zinixItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		//품목 불량 삭제
		@Transactional
		public int setItemBadDelete(List<ZinixInfergodsMgtDto> itemBadDeleteList){
			int resultInt = -1;
			int flag = -1;
			try {
				for(ZinixInfergodsMgtDto itemBadDto : itemBadDeleteList){
					resultInt = zinixInfergodsMgtMapper.deleteMtrlBad(itemBadDto);
					
					ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					flag = zinixItemStockMgtMapper.deleteTargetStock(itemStockMgtDto);
					if(flag == 0) {
						continue;
					}
					
					flag = zinixItemStockMgtMapper.selectItemStock(itemStockMgtDto);
					if(flag == 0) {
						continue;
					}
					itemStockMgtDto.setItemStock(zinixItemStockMgtMapper.selectItemStock(itemStockMgtDto));
					
					zinixItemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(zinixItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					zinixItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
					
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("품목 불량 삭제 에러 : " + e.getMessage());
			}
			return resultInt;
		}
		
		
		//타모듈에서 품목 불량 저장 (불량에 의한 수량을 감소시키지 않는다.)
		@Transactional
		public String setItemBadPgSave(ZinixInfergodsMgtDto itemBadDto){
			String returnKey = "";
			try {
				//불량등록
				if(itemBadDto.getAction().equals("C")) {
					zinixInfergodsMgtMapper.insertItemBad(itemBadDto);
					returnKey = itemBadDto.getBadId();
				//불량수정
				}else if(itemBadDto.getAction().equals("U")) {
					zinixInfergodsMgtMapper.updateMtrlBad(itemBadDto);
					returnKey = itemBadDto.getBadId();
				//불량삭제
				}else if(itemBadDto.getAction().equals("D")) {
					zinixInfergodsMgtMapper.deleteMtrlBad(itemBadDto);
				}
				
				//작업 불량인 경우 해당 작업에  불량수 update 처리
				if(itemBadDto.getBadTarget().equals("qual_spec03")) {
					ZinixInfergodsMgtDto itemBadTotalDto = new ZinixInfergodsMgtDto();
					itemBadTotalDto.setBadTargetCode(itemBadDto.getBadTargetCode());
					itemBadTotalDto.setBadTarget(itemBadDto.getBadTarget());
					ZinixWrkinTeamMgtDto workInfoDto = new ZinixWrkinTeamMgtDto();
					workInfoDto.setProdWorkBad(String.valueOf(zinixInfergodsMgtMapper.selectItemBadTotal(itemBadTotalDto)));
					workInfoDto.setProdWorkId(itemBadDto.getBadTargetCode());
					workInfoDto.setAction("U");
					
					workInfoService.setProdWorkSave(workInfoDto);
				}
				
				//아이템 수량 저장(아이템 수량 update가 필요한 경우 분기처리하여 주석해제해서 사용)
//				ZinixItemStockMgtDto itemStockMgtDto = new ZinixItemStockMgtDto(itemBadDto.getItemId(),itemBadDto.getLotId(),itemBadDto.getBadQty(),
//						"prod_tagt01","LOT",null,itemBadDto.getChkUser());
//				
//				itemStockService.setItemStockPgSave(itemStockMgtDto);
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		
		//품목 불량율 조회
		public PageInfo<ZinixInfergodsMgtDto> getBadRate(ZinixInfergodsMgtDto itemBadDto, PageRequestVo pageRequestVo){
			List<ZinixInfergodsMgtDto> itemBadRateList = null;
			int rowCount = 0;
		
			// Page Setting
			itemBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			itemBadDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
			try {
				//Count
				rowCount = zinixInfergodsMgtMapper.selectBadRateCount(itemBadDto);
				if (rowCount > 0) {
					//List
					itemBadRateList = zinixInfergodsMgtMapper.selectBadRate(itemBadDto);
				}
			} catch (Exception e) {
				throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
			}
			if (itemBadRateList == null) {
				itemBadRateList = new ArrayList<ZinixInfergodsMgtDto>();
			}
			return new PageInfo<ZinixInfergodsMgtDto>(itemBadRateList, pageRequestVo, rowCount);
		}
		
		//품목 불량율 조회
		public PageInfo<ZinixInfergodsMgtDto> getBadHistory(ZinixInfergodsMgtDto zinixInfergodsMgtDto, PageRequestVo pageRequestVo){
			List<ZinixInfergodsMgtDto> itemBadHistoryList = null;
			int rowCount = 0;
		
			// Page Setting
			zinixInfergodsMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			zinixInfergodsMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
			try {
				//Count
				rowCount = zinixInfergodsMgtMapper.selectBadHistoryCount(zinixInfergodsMgtDto);
				if (rowCount > 0) {
					//List
					itemBadHistoryList = zinixInfergodsMgtMapper.selectBadHistory(zinixInfergodsMgtDto);
				}
			} catch (Exception e) {
				throw new BusinessException("getBadHistory 에러입니다. : " + e.getMessage());
			}
			if (itemBadHistoryList == null) {
				itemBadHistoryList = new ArrayList<ZinixInfergodsMgtDto>();
			}
			return new PageInfo<ZinixInfergodsMgtDto>(itemBadHistoryList, pageRequestVo, rowCount);
		}
		
	}
