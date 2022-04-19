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
		public PageInfo<NewInfergodsMgtDto> getMtrlBadList(NewInfergodsMgtDto newMtrlBadDto, PageRequestVo pageRequestVo){
			List<NewInfergodsMgtDto> mtrlBadList = null;
			int rowCount = 0;

			// Page Setting
			newMtrlBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			newMtrlBadDto.setLastIndex(pageRequestVo.getBlockLastPage());

			try {
				//Count
				rowCount = newInferGodsMgtMapper.selectMtrlBadCount(newMtrlBadDto);
				if (rowCount > 0) {
					//List
					mtrlBadList = newInferGodsMgtMapper.selectMtrlBadList(newMtrlBadDto);
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
		public String setMtrlBadSave(NewInfergodsMgtDto newBadDto){
			String returnKey = "";
			try {
				if(newBadDto.getAction().equals("C")) {
					//불량관리 저장
					newInferGodsMgtMapper.insertMtrlBad(newBadDto);
					returnKey = newBadDto.getBadId();
					
					//불량품 수량을 등록하기 위한 생성자
					NewMtrlHistoryDto newMtrlCntDto = new NewMtrlHistoryDto(newBadDto.getMtrlId(), "mtrl_tagt03", returnKey,
							newBadDto.getBadQty()*-1, newBadDto.getChkDate(), newBadDto.getChkUser() ,newBadDto.getMtrlMgtId(), newBadDto.getLotId());
					
					//불량히스토리를 등록하고 자재수량을 갱신
					newMtrlCntDto.setAction("SUBTRACT");					
					newMtrlMgtService.setMtrlMgtPgSave(newMtrlCntDto);
				}else if(newBadDto.getAction().equals("U")){
					//불량관리 저장
					newInferGodsMgtMapper.updateMtrlBad(newBadDto);
					returnKey =newBadDto.getBadId();
					
					//불량품 수량을 수정하기 위한 생성자
					NewMtrlHistoryDto newBadCntDto = new NewMtrlHistoryDto(newBadDto.getMtrlId(), "mtrl_tagt03", returnKey,
							newBadDto.getBadQty()*-1, newBadDto.getChkDate(), newBadDto.getChkUser() ,newBadDto.getMtrlMgtId(), newBadDto.getLotId());
					
					
					//불량히스토리를 수정하고 자재수량을 갱신
					newBadCntDto.setAction("U");
					newMtrlMgtService.setMtrlMgtPgSave(newBadCntDto);
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
				for(NewInfergodsMgtDto newMtrlBadDto : mtrlBadList){
					//불량품 수량을 삭제하기 위한 생성자
					newInferGodsMgtMapper.deleteMtrlBad(newMtrlBadDto);
					NewMtrlHistoryDto newMtrlCntDto = new NewMtrlHistoryDto();
					newMtrlCntDto.setMtrlMgtId(newMtrlBadDto.getMtrlMgtId());
					newMtrlCntDto.setMtrlQtyTarget("mtrl_tagt03");
					newMtrlCntDto.setMtrlQtyTargetCode(newMtrlBadDto.getBadId());
					
					//불량품 수량을 삭제하고 자재수량 갱신
					newMtrlCntDto.setAction("D");
					newMtrlMgtService.setMtrlMgtPgSave(newMtrlCntDto);
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("자재불량 삭제 에러 : " + e.getMessage());
			}
			return resultInt;
		}
		
		//품목 불량 조회
		public PageInfo<NewInfergodsMgtDto> getItemBadList(NewInfergodsMgtDto newItemBadDto, PageRequestVo pageRequestVo){
			List<NewInfergodsMgtDto> itemBadList = null;
			int rowCount = 0;
	
			// Page Setting
			newItemBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			newItemBadDto.setLastIndex(pageRequestVo.getBlockLastPage());
	
			try {
				//Count
				rowCount = newInferGodsMgtMapper.selectItemBadCount(newItemBadDto);
				if (rowCount > 0) {
					//List
					itemBadList = newInferGodsMgtMapper.selectItemBadList(newItemBadDto);
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
		public String setItemBadSave(NewInfergodsMgtDto newItemBadDto){
			String returnKey = "";
			try {
				if(newItemBadDto.getAction().equals("C")) {
					newItemBadDto.setChkUser(JteUtils.getUserId());
					newItemBadDto.setBadTarget("qual_spec06");
					newItemBadDto.setBadTargetCode("ADMIN");
					newInferGodsMgtMapper.insertItemBad(newItemBadDto);
					returnKey = newItemBadDto.getBadId();

					//생산 완료 된 품목에 한해서 관리자 불량 등록 시 수량 변경
					NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto();
					newItemStockMgtDto.setItemId(newItemBadDto.getItemId());
					newItemStockMgtDto.setItemMgtId(newItemBadDto.getLotId());
					newItemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					newItemStockMgtDto.setItemQtyTargetCode(newItemBadDto.getBadId());
					newItemStockMgtDto.setItemQtyTotal(-newItemBadDto.getBadQty());
					newItemStockMgtDto.setCreatorId(JteUtils.getUserId());
					newItemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					newItemStockMgtMapper.insertItemStockHistory(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(newItemStockMgtDto));
						
					newItemStockMgtMapper.updateItemStock(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(newItemStockMgtDto));
					
					newItemStockMgtMapper.updateItemTotalStock(newItemStockMgtDto);
					
				} else if(newItemBadDto.getAction().equals("U")){
					newItemBadDto.setChkUser(JteUtils.getUserId());
					newInferGodsMgtMapper.updateMtrlBad(newItemBadDto);
					
					NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto();
					newItemStockMgtDto.setItemId(newItemBadDto.getItemId());
					newItemStockMgtDto.setItemMgtId(newItemBadDto.getLotId());
					newItemStockMgtDto.setItemQtyTargetCode(newItemBadDto.getBadId());
					newItemStockMgtDto.setItemQtyTotal(-newItemBadDto.getBadQty());
					newItemStockMgtDto.setCreatorId(JteUtils.getUserId());
					newItemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					newItemStockMgtMapper.updateTargetStock(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(newItemStockMgtDto));
					
					newItemStockMgtMapper.updateItemStock(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(newItemStockMgtDto));
					
					newItemStockMgtMapper.updateItemTotalStock(newItemStockMgtDto);
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		//품목 불량 저장
		@Transactional
		public String setItemBadQualSave(NewInfergodsMgtDto newItemBadDto){
			String returnKey = "";
			try {
				if(newItemBadDto.getAction().equals("C")) {
					newItemBadDto.setChkUser(JteUtils.getUserId());
					newItemBadDto.setBadTarget("qual_spec07");
					newItemBadDto.setBadTargetCode("FINAL");
					newInferGodsMgtMapper.insertItemBad(newItemBadDto);
					returnKey = newItemBadDto.getBadId();

					//생산 완료 된 품목에 한해서 관리자 불량 등록 시 수량 변경
					NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto();
					newItemStockMgtDto.setItemId(newItemBadDto.getItemId());
					newItemStockMgtDto.setItemMgtId(newItemBadDto.getLotId());
					newItemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					newItemStockMgtDto.setItemQtyTargetCode(newItemBadDto.getBadId());
					newItemStockMgtDto.setItemQtyTotal(-newItemBadDto.getBadQty());
					newItemStockMgtDto.setCreatorId(JteUtils.getUserId());
					newItemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					newItemStockMgtMapper.insertItemStockHistory(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(newItemStockMgtDto));
						
					newItemStockMgtMapper.updateItemStock(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(newItemStockMgtDto));
					
					newItemStockMgtMapper.updateItemTotalStock(newItemStockMgtDto);
					
				} else if(newItemBadDto.getAction().equals("U")){
					newItemBadDto.setChkUser(JteUtils.getUserId());
					newInferGodsMgtMapper.updateMtrlBad(newItemBadDto);
					
					NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto();
					newItemStockMgtDto.setItemId(newItemBadDto.getItemId());
					newItemStockMgtDto.setItemMgtId(newItemBadDto.getLotId());
					newItemStockMgtDto.setItemQtyTargetCode(newItemBadDto.getBadId());
					newItemStockMgtDto.setItemQtyTotal(-newItemBadDto.getBadQty());
					newItemStockMgtDto.setCreatorId(JteUtils.getUserId());
					newItemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					newItemStockMgtMapper.updateTargetStock(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(newItemStockMgtDto));
					
					newItemStockMgtMapper.updateItemStock(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(newItemStockMgtDto));
					
					newItemStockMgtMapper.updateItemTotalStock(newItemStockMgtDto);
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
				for(NewInfergodsMgtDto newItemBadDto : itemBadDeleteList){
					resultInt = newInferGodsMgtMapper.deleteMtrlBad(newItemBadDto);
					
					NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto();
					newItemStockMgtDto.setItemId(newItemBadDto.getItemId());
					newItemStockMgtDto.setItemMgtId(newItemBadDto.getLotId());
					newItemStockMgtDto.setItemQtyTargetCode(newItemBadDto.getBadId());
					flag = newItemStockMgtMapper.deleteTargetStock(newItemStockMgtDto);
					if(flag == 0) {
						continue;
					}
					
					flag = newItemStockMgtMapper.selectItemStock(newItemStockMgtDto);
					if(flag == 0) {
						continue;
					}
					newItemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(newItemStockMgtDto));
					
					newItemStockMgtMapper.updateItemStock(newItemStockMgtDto);
					
					newItemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(newItemStockMgtDto));
					
					newItemStockMgtMapper.updateItemTotalStock(newItemStockMgtDto);
					
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("품목 불량 삭제 에러 : " + e.getMessage());
			}
			return resultInt;
		}
		
		
		//타모듈에서 품목 불량 저장 (불량에 의한 수량을 감소시키지 않는다.)
		@Transactional
		public String setItemBadPgSave(NewInfergodsMgtDto newItemBadDto){
			String returnKey = "";
			try {
				//불량등록
				if(newItemBadDto.getAction().equals("C")) {
					newInferGodsMgtMapper.insertItemBad(newItemBadDto);
					returnKey = newItemBadDto.getBadId();
				//불량수정
				}else if(newItemBadDto.getAction().equals("U")) {
					newInferGodsMgtMapper.updateMtrlBad(newItemBadDto);
					returnKey = newItemBadDto.getBadId();
				//불량삭제
				}else if(newItemBadDto.getAction().equals("D")) {
					newInferGodsMgtMapper.deleteMtrlBad(newItemBadDto);
				}
				
				//작업 불량인 경우 해당 작업에  불량수 update 처리
				if(newItemBadDto.getBadTarget().equals("qual_spec03")) {
					NewInfergodsMgtDto newItemBadTotalDto = new NewInfergodsMgtDto();
					newItemBadTotalDto.setBadTargetCode(newItemBadDto.getBadTargetCode());
					newItemBadTotalDto.setBadTarget(newItemBadDto.getBadTarget());
					NewWrkinTeamMgtDto newWorkInfoDto = new NewWrkinTeamMgtDto();
					newWorkInfoDto.setProdWorkBad(newInferGodsMgtMapper.selectItemBadTotal(newItemBadTotalDto));
					newWorkInfoDto.setProdWorkId(newItemBadDto.getBadTargetCode());
					newWorkInfoDto.setAction("U");
					
					newWorkInfoService.setProdWorkSave(newWorkInfoDto);
				}
				
				//아이템 수량 저장(아이템 수량 update가 필요한 경우 분기처리하여 주석해제해서 사용)
//				NewItemStockMgtDto newItemStockMgtDto = new NewItemStockMgtDto(newItemBadDto.getItemId(),newItemBadDto.getLotId(),newItemBadDto.getBadQty(),
//						"prod_tagt01","LOT",null,newItemBadDto.getChkUser());
//				
//				itemStockService.setItemStockPgSave(newItemStockMgtDto);
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		
		//품목 불량율 조회
		public PageInfo<NewInfergodsMgtDto> getBadRate(NewInfergodsMgtDto newItemBadDto, PageRequestVo pageRequestVo){
			List<NewInfergodsMgtDto> itemBadRateList = null;
			int rowCount = 0;
		
			// Page Setting
			newItemBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			newItemBadDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
			try {
				//Count
				rowCount = newInferGodsMgtMapper.selectBadRateCount(newItemBadDto);
				if (rowCount > 0) {
					//List
					itemBadRateList = newInferGodsMgtMapper.selectBadRate(newItemBadDto);
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
		public PageInfo<NewInfergodsMgtDto> getBadHistory(NewInfergodsMgtDto newInfergodsMgtDto, PageRequestVo pageRequestVo){
			List<NewInfergodsMgtDto> itemBadHistoryList = null;
			int rowCount = 0;
		
			// Page Setting
			newInfergodsMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			newInfergodsMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
			try {
				//Count
				rowCount = newInferGodsMgtMapper.selectBadHistoryCount(newInfergodsMgtDto);
				if (rowCount > 0) {
					//List
					itemBadHistoryList = newInferGodsMgtMapper.selectBadHistory(newInfergodsMgtDto);
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
