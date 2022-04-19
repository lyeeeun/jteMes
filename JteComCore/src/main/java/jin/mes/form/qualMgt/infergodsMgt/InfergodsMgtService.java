package jin.mes.form.qualMgt.infergodsMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtMapper;
import jin.mes.form.mfgMgt.wrkinTeamMgt.WrkinTeamMgtDto;
import jin.mes.form.mfgMgt.wrkinWrkerMgt.WrkinWrkerMgtService;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class InfergodsMgtService {
	@Resource
	InfergodsMgtMapper infergodsMgtMapper;
	
	@Resource
	ItemStockMgtMapper itemStockMgtMapper;

	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@Autowired
	WrkinWrkerMgtService workInfoService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	//자재 불량 관리 조회
	public PageInfo<InfergodsMgtDto> getMtrlBadList(InfergodsMgtDto mtrlBadDto, PageRequestVo pageRequestVo){
		List<InfergodsMgtDto> mtrlBadList = null;
		int rowCount = 0;

		// Page Setting
		mtrlBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlBadDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = infergodsMgtMapper.selectMtrlBadCount(mtrlBadDto);
			if (rowCount > 0) {
				//List
				mtrlBadList = infergodsMgtMapper.selectMtrlBadList(mtrlBadDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재불량 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlBadList == null) {
			mtrlBadList = new ArrayList<InfergodsMgtDto>();
		}
		return new PageInfo<InfergodsMgtDto>(mtrlBadList, pageRequestVo, rowCount);
	}
		
		//자재 불량 관리 저장
		@Transactional
		public String setMtrlBadSave(InfergodsMgtDto badDto){
			String returnKey = "";
			try {
				if(badDto.getAction().equals("C")) {
					//불량관리 저장
					infergodsMgtMapper.insertMtrlBad(badDto);
					returnKey = badDto.getBadId();
					
					//불량품 수량을 등록하기 위한 생성자
					MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
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
					infergodsMgtMapper.updateMtrlBad(badDto);
					returnKey =badDto.getBadId();
					
					//불량품 수량을 수정하기 위한 생성자
					MtrlHistoryDto badCntDto = new MtrlHistoryDto(badDto.getMtrlId(), "mtrl_tagt03", returnKey,
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
		public int setMtrlBadDelete(List<InfergodsMgtDto> mtrlBadList){
			int resultInt = -1;
			try {
				//불량관리 삭제
				for(InfergodsMgtDto mtrlBadDto : mtrlBadList){
					//불량품 수량을 삭제하기 위한 생성자
					infergodsMgtMapper.deleteMtrlBad(mtrlBadDto);
					MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto();
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
		public PageInfo<InfergodsMgtDto> getItemBadList(InfergodsMgtDto itemBadDto, PageRequestVo pageRequestVo){
			List<InfergodsMgtDto> itemBadList = null;
			int rowCount = 0;
	
			// Page Setting
			itemBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			itemBadDto.setLastIndex(pageRequestVo.getBlockLastPage());
	
			try {
				//Count
				rowCount = infergodsMgtMapper.selectItemBadCount(itemBadDto);
				if (rowCount > 0) {
					//List
					itemBadList = infergodsMgtMapper.selectItemBadList(itemBadDto);
				}
			} catch (Exception e) {
				throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
			}
			if (itemBadList == null) {
				itemBadList = new ArrayList<InfergodsMgtDto>();
			}
			return new PageInfo<InfergodsMgtDto>(itemBadList, pageRequestVo, rowCount);
		}
		
		//품목 불량 저장
		@Transactional
		public String setItemBadSave(InfergodsMgtDto itemBadDto){
			String returnKey = "";
			try {
				if(itemBadDto.getAction().equals("C")) {
					itemBadDto.setChkUser(JteUtils.getUserId());
					itemBadDto.setBadTarget("qual_spec06");
					itemBadDto.setBadTargetCode("ADMIN");
					infergodsMgtMapper.insertItemBad(itemBadDto);
					returnKey = itemBadDto.getBadId();

					//생산 완료 된 품목에 한해서 관리자 불량 등록 시 수량 변경
					ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					itemStockMgtMapper.insertItemStockHistory(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(itemStockMgtMapper.selectItemStock(itemStockMgtDto));
						
					itemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(itemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					itemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
					
				} else if(itemBadDto.getAction().equals("U")){
					itemBadDto.setChkUser(JteUtils.getUserId());
					infergodsMgtMapper.updateMtrlBad(itemBadDto);
					
					ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					itemStockMgtMapper.updateTargetStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(itemStockMgtMapper.selectItemStock(itemStockMgtDto));
					
					itemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(itemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					itemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		//품목 불량 저장
		@Transactional
		public String setItemBadQualSave(InfergodsMgtDto itemBadDto){
			String returnKey = "";
			try {
				if(itemBadDto.getAction().equals("C")) {
					itemBadDto.setChkUser(JteUtils.getUserId());
					itemBadDto.setBadTarget("qual_spec07");
					itemBadDto.setBadTargetCode("FINAL");
					infergodsMgtMapper.insertItemBad(itemBadDto);
					returnKey = itemBadDto.getBadId();

					//생산 완료 된 품목에 한해서 관리자 불량 등록 시 수량 변경
					ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTarget("prod_tagt04"); //불량
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					itemStockMgtMapper.insertItemStockHistory(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(itemStockMgtMapper.selectItemStock(itemStockMgtDto));
						
					itemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(itemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					itemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
					
				} else if(itemBadDto.getAction().equals("U")){
					itemBadDto.setChkUser(JteUtils.getUserId());
					infergodsMgtMapper.updateMtrlBad(itemBadDto);
					
					ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					itemStockMgtDto.setItemQtyTotal(-itemBadDto.getBadQty());
					itemStockMgtDto.setCreatorId(JteUtils.getUserId());
					itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
					
					itemStockMgtMapper.updateTargetStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemStock(itemStockMgtMapper.selectItemStock(itemStockMgtDto));
					
					itemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(itemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					itemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("품목 불량 저장 에러 : " + e.getMessage());
			}
			return returnKey;
		}
		//품목 불량 삭제
		@Transactional
		public int setItemBadDelete(List<InfergodsMgtDto> itemBadDeleteList){
			int resultInt = -1;
			int flag = -1;
			try {
				for(InfergodsMgtDto itemBadDto : itemBadDeleteList){
					resultInt = infergodsMgtMapper.deleteMtrlBad(itemBadDto);
					
					ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto();
					itemStockMgtDto.setItemId(itemBadDto.getItemId());
					itemStockMgtDto.setItemMgtId(itemBadDto.getLotId());
					itemStockMgtDto.setItemQtyTargetCode(itemBadDto.getBadId());
					flag = itemStockMgtMapper.deleteTargetStock(itemStockMgtDto);
					if(flag == 0) {
						continue;
					}
					
					flag = itemStockMgtMapper.selectItemStock(itemStockMgtDto);
					if(flag == 0) {
						continue;
					}
					itemStockMgtDto.setItemStock(itemStockMgtMapper.selectItemStock(itemStockMgtDto));
					
					itemStockMgtMapper.updateItemStock(itemStockMgtDto);
					
					itemStockMgtDto.setItemTotalStock(itemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
					
					itemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
					
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("품목 불량 삭제 에러 : " + e.getMessage());
			}
			return resultInt;
		}
		
		
		//타모듈에서 품목 불량 저장 (불량에 의한 수량을 감소시키지 않는다.)
		@Transactional
		public String setItemBadPgSave(InfergodsMgtDto itemBadDto){
			String returnKey = "";
			try {
				//불량등록
				if(itemBadDto.getAction().equals("C")) {
					infergodsMgtMapper.insertItemBad(itemBadDto);
					returnKey = itemBadDto.getBadId();
				//불량수정
				}else if(itemBadDto.getAction().equals("U")) {
					infergodsMgtMapper.updateMtrlBad(itemBadDto);
					returnKey = itemBadDto.getBadId();
				//불량삭제
				}else if(itemBadDto.getAction().equals("D")) {
					infergodsMgtMapper.deleteMtrlBad(itemBadDto);
				}
				
				//작업 불량인 경우 해당 작업에  불량수 update 처리
				if(itemBadDto.getBadTarget().equals("qual_spec03")) {
					InfergodsMgtDto itemBadTotalDto = new InfergodsMgtDto();
					itemBadTotalDto.setBadTargetCode(itemBadDto.getBadTargetCode());
					itemBadTotalDto.setBadTarget(itemBadDto.getBadTarget());
					WrkinTeamMgtDto workInfoDto = new WrkinTeamMgtDto();
					workInfoDto.setProdWorkBad(String.valueOf(infergodsMgtMapper.selectItemBadTotal(itemBadTotalDto)));
					workInfoDto.setProdWorkId(itemBadDto.getBadTargetCode());
					workInfoDto.setAction("U");
					
					workInfoService.setProdWorkSave(workInfoDto);
				}
				
				//아이템 수량 저장(아이템 수량 update가 필요한 경우 분기처리하여 주석해제해서 사용)
//				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(itemBadDto.getItemId(),itemBadDto.getLotId(),itemBadDto.getBadQty(),
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
		public PageInfo<InfergodsMgtDto> getBadRate(InfergodsMgtDto itemBadDto, PageRequestVo pageRequestVo){
			List<InfergodsMgtDto> itemBadRateList = null;
			int rowCount = 0;
		
			// Page Setting
			itemBadDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			itemBadDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
			try {
				//Count
				rowCount = infergodsMgtMapper.selectBadRateCount(itemBadDto);
				if (rowCount > 0) {
					//List
					itemBadRateList = infergodsMgtMapper.selectBadRate(itemBadDto);
				}
			} catch (Exception e) {
				throw new BusinessException("품목 불량 조회 에러입니다. : " + e.getMessage());
			}
			if (itemBadRateList == null) {
				itemBadRateList = new ArrayList<InfergodsMgtDto>();
			}
			return new PageInfo<InfergodsMgtDto>(itemBadRateList, pageRequestVo, rowCount);
		}
		
		//품목 불량율 조회
		public PageInfo<InfergodsMgtDto> getBadHistory(InfergodsMgtDto infergodsMgtDto, PageRequestVo pageRequestVo){
			List<InfergodsMgtDto> itemBadHistoryList = null;
			int rowCount = 0;
		
			// Page Setting
			infergodsMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			infergodsMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
			try {
				//Count
				rowCount = infergodsMgtMapper.selectBadHistoryCount(infergodsMgtDto);
				if (rowCount > 0) {
					//List
					itemBadHistoryList = infergodsMgtMapper.selectBadHistory(infergodsMgtDto);
				}
			} catch (Exception e) {
				throw new BusinessException("getBadHistory 에러입니다. : " + e.getMessage());
			}
			if (itemBadHistoryList == null) {
				itemBadHistoryList = new ArrayList<InfergodsMgtDto>();
			}
			return new PageInfo<InfergodsMgtDto>(itemBadHistoryList, pageRequestVo, rowCount);
		}
		
	}
