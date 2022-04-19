package jin.mes.cform.qualMgt.infergodsMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.item.itemStockMgt.NewItemStockMgtDto;
import jin.mes.cform.item.itemStockMgt.NewItemStockMgtMapper;
import jin.mes.cform.mfgMgt.wrkinTeamMgt.NewWrkinTeamMgtDto;
import jin.mes.cform.mfgMgt.wrkinWrkerMgt.NewWrkinWrkerMgtService;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlHistoryDto;
import jin.mes.cform.mtrl.mtrlMgt.NewMtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewInfergodsMgtService {
	@Resource
	NewInfergodsMgtMapper newInferGodsMgtMapper;
	
	@Resource
	NewItemStockMgtMapper newItemStockMgtMapper;

	@Autowired
	NewMtrlMgtService newMtrlMgtService;
	
	@Autowired
	NewWrkinWrkerMgtService newWorkInfoService;
	
	//자재 불량 관리 조회
		public PageInfo<NewInfergodsMgtDto> getMtrlBadList(NewInfergodsMgtDto mtrlBadDto, PageRequestVo pageRequestVo){
			List<NewInfergodsMgtDto> mtrlBadList = null;
			int rowCount = 0;

			// Page Setting
			mtrlBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			mtrlBadDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				//Count
				rowCount = newInferGodsMgtMapper.selectMtrlBadCount(mtrlBadDto);
				if (rowCount > 0) {
					//List
					mtrlBadList = newInferGodsMgtMapper.selectMtrlBadList(mtrlBadDto);
				}
			} catch (Exception e) {
				throw new BusinessException("자재불량 조회 에러입니다. : " + e.getMessage());
			}
			if (mtrlBadList == null) {
				mtrlBadList = new ArrayList<NewInfergodsMgtDto>();
			}
			return new PageInfo<NewInfergodsMgtDto>(mtrlBadList, pageRequestVo, rowCount);
		}
		
		//자재 불량 관리 저장
		@Transactional
		public String setMtrlBadSave(NewInfergodsMgtDto badDto){
			String returnKey = "";
			try {
				if(badDto.getAction().equals("C")) {
					//불량관리 저장
					newInferGodsMgtMapper.insertMtrlBad(badDto);
					returnKey = badDto.getBadId();
					
					//불량품 수량을 등록하기 위한 생성자
					NewMtrlHistoryDto mtrlCntDto = new NewMtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
							badDto.getBadQty()*-1, badDto.getChkDate(), badDto.getChkUser() ,badDto.getMtrlMgtId(), badDto.getLotId());
					
					//불량히스토리를 등록하고 자재수량을 갱신
					mtrlCntDto.setAction("SUBTRACT");					
					newMtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				}else if(badDto.getAction().equals("U")){
					//불량관리 저장
					newInferGodsMgtMapper.updateMtrlBad(badDto);
					returnKey =badDto.getBadId();
					
					//불량품 수량을 수정하기 위한 생성자
					NewMtrlHistoryDto badCntDto = new NewMtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
							badDto.getBadQty()*-1, badDto.getChkDate(), badDto.getChkUser() ,badDto.getMtrlMgtId(), badDto.getLotId());
					
					
					//불량히스토리를 수정하고 자재수량을 갱신
					badCntDto.setAction("U");
					newMtrlMgtService.setMtrlMgtPgSave(badCntDto);
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("자재/품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		
		//자재 불량 관리 삭제
		@Transactional
		public int setMtrlBadDelete(List<NewInfergodsMgtDto> mtrlBadList){
			int resultInt = -1;
			try {
				//불량관리 삭제
				for(NewInfergodsMgtDto mtrlBadDto : mtrlBadList){
					//불량품 수량을 삭제하기 위한 생성자
					newInferGodsMgtMapper.deleteMtrlBad(mtrlBadDto);
					NewMtrlHistoryDto mtrlCntDto = new NewMtrlHistoryDto();
					mtrlCntDto.setMtrlMgtId(mtrlBadDto.getMtrlMgtId());
					mtrlCntDto.setMtrlQtyTarget("mtrl_tagt03");
					mtrlCntDto.setMtrlQtyTargetCode(mtrlBadDto.getBadId());
					
					//불량품 수량을 삭제하고 자재수량 갱신
					mtrlCntDto.setAction("D");
					newMtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("자재불량 삭제 에러 : " + e.getMessage());
			}
			return resultInt;
		}
		
		//품목 불량 조회
		public PageInfo<NewInfergodsMgtDto> getItemBadList(NewInfergodsMgtDto itemBadDto, PageRequestVo pageRequestVo){
			List<NewInfergodsMgtDto> itemBadList = null;
			int rowCount = 0;
	
			// Page Setting
			itemBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			itemBadDto.setLastIndex(pageRequestVo.getBlockLastPage());
	
			try {
				//Count
				rowCount = newInferGodsMgtMapper.selectItemBadCount(itemBadDto);
				if (rowCount > 0) {
					//List
					itemBadList = newInferGodsMgtMapper.selectItemBadList(itemBadDto);
				}
			} catch (Exception e) {
				throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
			}
			if (itemBadList == null) {
				itemBadList = new ArrayList<NewInfergodsMgtDto>();
			}
			return new PageInfo<NewInfergodsMgtDto>(itemBadList, pageRequestVo, rowCount);
		}
		
		//품목 불량 저장
		@Transactional
		public String setItemBadSave(NewInfergodsMgtDto itemBadDto){
			String returnKey = "";
			try {
				if(itemBadDto.getAction().equals("C")) {
					itemBadDto.setChkUser(JteUtils.getUserId());
					itemBadDto.setBadTarget("qual_spec06");
					itemBadDto.setBadTargetCode("ADMIN");
					newInferGodsMgtMapper.insertItemBad(itemBadDto);
					returnKey = itemBadDto.getBadId();

					//생산 완료 된 품목에 한해서 관리자 불량 등록 시 수량 변경
					NewItemStockMgtDto itemStockMgtDto = new NewItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					newItemStockMgtMapper.insertItemStockHistory(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(itemStockMgtDto));
						
					newItemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					newItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
					
				} else if(itemBadDto.getAction().equals("U")){
					itemBadDto.setChkUser(JteUtils.getUserId());
					newInferGodsMgtMapper.updateMtrlBad(itemBadDto);
					
					NewItemStockMgtDto itemStockMgtDto = new NewItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					newItemStockMgtMapper.updateTargetStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(itemStockMgtDto));
					
					newItemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					newItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		
		//품목 불량 삭제
		@Transactional
		public int setItemBadDelete(List<NewInfergodsMgtDto> itemBadDeleteList){
			int resultInt = -1;
			int flag = -1;
			try {
				for(NewInfergodsMgtDto itemBadDto : itemBadDeleteList){
					resultInt = newInferGodsMgtMapper.deleteMtrlBad(itemBadDto);
					
					NewItemStockMgtDto itemStockMgtDto = new NewItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					flag = newItemStockMgtMapper.deleteTargetStock(itemStockMgtDto);
					if(flag == 0) {
						continue;
					}
					
					flag = newItemStockMgtMapper.selectItemStock(itemStockMgtDto);
					if(flag == 0) {
						continue;
					}
					itemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(itemStockMgtDto));
					
					newItemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					newItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
					
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("품목 불량 삭제 에러 : " + e.getMessage());
			}
			return resultInt;
		}
		
		
		//타모듈에서 품목 불량 저장 (불량에 의한 수량을 감소시키지 않는다.)
		@Transactional
		public String setItemBadPgSave(NewInfergodsMgtDto itemBadDto){
			String returnKey = "";
			try {
				//불량등록
				if(itemBadDto.getAction().equals("C")) {
					newInferGodsMgtMapper.insertItemBad(itemBadDto);
					returnKey = itemBadDto.getBadId();
				//불량수정
				}else if(itemBadDto.getAction().equals("U")) {
					newInferGodsMgtMapper.updateMtrlBad(itemBadDto);
					returnKey = itemBadDto.getBadId();
				//불량삭제
				}else if(itemBadDto.getAction().equals("D")) {
					newInferGodsMgtMapper.deleteMtrlBad(itemBadDto);
				}
				
				//작업 불량인 경우 해당 작업에  불량수 update 처리
				if(itemBadDto.getBadTarget().equals("qual_spec03")) {
					NewInfergodsMgtDto itemBadTotalDto = new NewInfergodsMgtDto();
					itemBadTotalDto.setBadTargetCode(itemBadDto.getBadTargetCode());
					itemBadTotalDto.setBadTarget(itemBadDto.getBadTarget());
					NewWrkinTeamMgtDto workInfoDto = new NewWrkinTeamMgtDto();
					workInfoDto.setProdWorkBad(newInferGodsMgtMapper.selectItemBadTotal(itemBadTotalDto));
					workInfoDto.setProdWorkId(itemBadDto.getBadTargetCode());
					workInfoDto.setAction("U");
					
					newWorkInfoService.setProdWorkSave(workInfoDto);
				}
				
				//아이템 수량 저장(아이템 수량 update가 필요한 경우 분기처리하여 주석해제해서 사용)
//				NewItemStockMgtDto itemStockMgtDto = new NewItemStockMgtDto(itemBadDto.getItemId(),itemBadDto.getLotId(),itemBadDto.getBadQty(),
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
		public PageInfo<NewInfergodsMgtDto> getBadRate(NewInfergodsMgtDto itemBadDto, PageRequestVo pageRequestVo){
			List<NewInfergodsMgtDto> itemBadRateList = null;
			int rowCount = 0;
		
			// Page Setting
			itemBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			itemBadDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
			try {
				//Count
				rowCount = newInferGodsMgtMapper.selectBadRateCount(itemBadDto);
				if (rowCount > 0) {
					//List
					itemBadRateList = newInferGodsMgtMapper.selectBadRate(itemBadDto);
				}
			} catch (Exception e) {
				throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
			}
			if (itemBadRateList == null) {
				itemBadRateList = new ArrayList<NewInfergodsMgtDto>();
			}
			return new PageInfo<NewInfergodsMgtDto>(itemBadRateList, pageRequestVo, rowCount);
		}
		
		//품목 불량율 조회
		public PageInfo<NewInfergodsMgtDto> getBadHistory(NewInfergodsMgtDto infergodsMgtDto, PageRequestVo pageRequestVo){
			List<NewInfergodsMgtDto> itemBadHistoryList = null;
			int rowCount = 0;
		
			// Page Setting
			infergodsMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			infergodsMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
			try {
				//Count
				rowCount = newInferGodsMgtMapper.selectBadHistoryCount(infergodsMgtDto);
				if (rowCount > 0) {
					//List
					itemBadHistoryList = newInferGodsMgtMapper.selectBadHistory(infergodsMgtDto);
				}
			} catch (Exception e) {
				throw new BusinessException("getBadHistory 에러입니다. : " + e.getMessage());
			}
			if (itemBadHistoryList == null) {
				itemBadHistoryList = new ArrayList<NewInfergodsMgtDto>();
			}
			return new PageInfo<NewInfergodsMgtDto>(itemBadHistoryList, pageRequestVo, rowCount);
		}
		
	}
