package jin.mes.cform.mtrl.itemRecevingMgt;


import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtDto;
import jin.mes.cform.mtrl.itemRecevingMgt.KwangjinItemRecevingMgtMapper;
import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinItemRecevingMgtService {
	
	@Resource
	KwangjinItemRecevingMgtMapper kwangjinItemRecevingMgtMapper;
	
	//제품 관리 조회
	public PageInfo<KwangjinItemRecevingMgtDto> getItemRecevingMgtList(KwangjinItemRecevingMgtDto itemRecevingMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinItemRecevingMgtDto> itemMgtList = null;
		int rowCount = 0;

		// Page Setting
		itemRecevingMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemRecevingMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinItemRecevingMgtMapper.selectItemRecevingMgtCount(itemRecevingMgtDto);
			if (rowCount > 0) {
				//List
				itemMgtList = kwangjinItemRecevingMgtMapper.selectItemRecevingMgtList(itemRecevingMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("제품정보 조회 에러입니다. : " + e.getMessage());
		}
		if (itemMgtList == null) {
			itemMgtList = new ArrayList<KwangjinItemRecevingMgtDto>();
		}
		return new PageInfo<KwangjinItemRecevingMgtDto>(itemMgtList, pageRequestVo, rowCount);
	}
	
	  //라우팅시트 조회
  	public List<KwangjinItemRecevingMgtDto> getStockList(KwangjinItemRecevingMgtDto itemRecevingMgtDto) {
  		List<KwangjinItemRecevingMgtDto> stockList = null;
  		try {
  			stockList = kwangjinItemRecevingMgtMapper.selectStockList(itemRecevingMgtDto);
  		} catch (Exception e) {
  			throw new BusinessException("제품 관리 조회 에러입니다.(Pop) : " + e.getMessage());
  		}
  		if (stockList == null) {
  			stockList = new ArrayList<KwangjinItemRecevingMgtDto>();
		}
  		
  		return stockList;
  	}
  	
    public void insertItemRecevingMgt(KwangjinItemRecevingMgtDto itemRecevingMgtDto) {
    	try {
    		kwangjinItemRecevingMgtMapper.insertItemRecevingMgt(itemRecevingMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: insertItemStock Error " + e.getMessage());
		}
    }
    
	//제품 관리 조회
	public PageInfo<KwangjinItemRecevingMgtDto> getItemLotList(KwangjinItemRecevingMgtDto itemRecevingMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinItemRecevingMgtDto> itemMgtList = null;
		int rowCount = 0;

		// Page Setting
		itemRecevingMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemRecevingMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = kwangjinItemRecevingMgtMapper.selectItemLotCount(itemRecevingMgtDto);
			if (rowCount > 0) {
				//List
				itemMgtList = kwangjinItemRecevingMgtMapper.selectItemLotList(itemRecevingMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("제품정보 조회 에러입니다. : " + e.getMessage());
		}
		if (itemMgtList == null) {
			itemMgtList = new ArrayList<KwangjinItemRecevingMgtDto>();
		}
		return new PageInfo<KwangjinItemRecevingMgtDto>(itemMgtList, pageRequestVo, rowCount);
	}
	
	//제품관리 입력/수정
	@Transactional
	public String setItemRecevingMgtSave(KwangjinItemRecevingMgtDto itemRecevingMgtDto){
		String returnKey = "";
		try {
			itemRecevingMgtDto.setCreatorId(JteUtils.getUserId());
			itemRecevingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(itemRecevingMgtDto.getAction().equals("C")) {//
				//제품입력
				kwangjinItemRecevingMgtMapper.insertItemRecevingMgt(itemRecevingMgtDto);
				
				//kwangjinItemRecevingMgtMapper.updateItemDupl(itemRecevingMgtDto);
				
				returnKey = itemRecevingMgtDto.getItemMgtId();
			}else if(itemRecevingMgtDto.getAction().equals("U")){//제품 변경
				//제품수정
				kwangjinItemRecevingMgtMapper.updateItemRecevingMgt(itemRecevingMgtDto);
				
				returnKey =itemRecevingMgtDto.getItemMgtId();
			}else if(itemRecevingMgtDto.getAction().equals("D")){//isdel 처리
				itemRecevingMgtDto.setDel(true);
				//isdel 처리
				kwangjinItemRecevingMgtMapper.updateItemRecevingMgtIsDel(itemRecevingMgtDto);
				
				returnKey =itemRecevingMgtDto.getItemMgtId();
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("제품 관리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public int deleteItemStock(List<KwangjinItemRecevingMgtDto> itemStockList){
		int resultInt = -1;
		try {
			//자재삭제
			for(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto : itemStockList){
				kwangjinItemRecevingMgtMapper.deleteItemStock(kwangjinItemRecevingMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("제품 관리 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	@Transactional
	public int selectItemLotDupleKeyCount(KwangjinItemRecevingMgtDto itemRecevingMgtDto){
		int resultInt = -1;
		try {
			resultInt = kwangjinItemRecevingMgtMapper.selectItemLotDupleKeyCount(itemRecevingMgtDto);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("Lot정보 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	//제품 수량 히스토리(내역) 조회
	public PageInfo<KwangjinItemRecevingMgtDto> getItemRecevingHisList(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinItemRecevingMgtDto> itemHisList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinItemRecevingMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinItemRecevingMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinItemRecevingMgtMapper.selectItemRecevingHisCount(kwangjinItemRecevingMgtDto);
			if (rowCount > 0) {
				//List
				itemHisList = kwangjinItemRecevingMgtMapper.selectItemRecevingHisList(kwangjinItemRecevingMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("제품 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (itemHisList == null) {
			itemHisList = new ArrayList<KwangjinItemRecevingMgtDto>();
		}
		return new PageInfo<KwangjinItemRecevingMgtDto>(itemHisList, pageRequestVo, rowCount);
	}
	
	//제품 수량이력 수동입력
	@Transactional
	public String setItemManualSave(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto){
		String returnKey = "";
		try {
			kwangjinItemRecevingMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinItemRecevingMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinItemRecevingMgtDto.getAction().equals("C")) {//
				//제품 수량이력 수동 입력
				kwangjinItemRecevingMgtMapper.insertManualInfo(kwangjinItemRecevingMgtDto);
				
				//제품 수량관리 입력
				kwangjinItemRecevingMgtMapper.insertItemRecevingHis(kwangjinItemRecevingMgtDto);
				
				returnKey = kwangjinItemRecevingMgtDto.getItemMgtId();
				
				//제품관리 합계 total
				KwangjinItemRecevingMgtDto itemStock = new KwangjinItemRecevingMgtDto();
				itemStock.setItemMgtId(returnKey);
				itemStock.setItemStock(kwangjinItemRecevingMgtMapper.selectItemRecevingHisTotal(kwangjinItemRecevingMgtDto));
				itemStock.setCreatorId(JteUtils.getUserId());
				itemStock.setUpdatorId(JteUtils.getUserId());
				kwangjinItemRecevingMgtMapper.updateItemRecevingMgt(itemStock);
			}
			else if(kwangjinItemRecevingMgtDto.getAction().equals("U")){//제품 사용 히스토리 변경
				//제품 사용dlfur 수동 수정
				kwangjinItemRecevingMgtMapper.updateManualInfo(kwangjinItemRecevingMgtDto);
				
				//제품 수량관리 tnwjd
				kwangjinItemRecevingMgtMapper.updateItemRecevingHis(kwangjinItemRecevingMgtDto);
				
				returnKey = kwangjinItemRecevingMgtDto.getItemMgtId();
				
				//제품관리 합계 total
				KwangjinItemRecevingMgtDto itemStock = new KwangjinItemRecevingMgtDto();
				itemStock.setItemMgtId(returnKey);
				itemStock.setItemStock(kwangjinItemRecevingMgtMapper.selectItemRecevingHisTotal(kwangjinItemRecevingMgtDto));
				itemStock.setCreatorId(JteUtils.getUserId());
				itemStock.setUpdatorId(JteUtils.getUserId());
				kwangjinItemRecevingMgtMapper.updateItemRecevingMgt(itemStock);
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("제품 사용 히스토리 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//제품 사용 히스토리 삭제
	@Transactional
	public int setItemManualDelete(List<KwangjinItemRecevingMgtDto> itemHisList){
		int resultInt = -1;
		try {
			//제품 사용 히스토리 삭제
			for(KwangjinItemRecevingMgtDto kwangjinItemRecevingMgtDto : itemHisList){
				kwangjinItemRecevingMgtMapper.deleteManualInfo(kwangjinItemRecevingMgtDto);
				kwangjinItemRecevingMgtMapper.deleteItemRecevingHis(kwangjinItemRecevingMgtDto);
			}
			
			KwangjinItemRecevingMgtDto itemMgtCnt = new KwangjinItemRecevingMgtDto();
			itemMgtCnt.setItemMgtId(itemHisList.get(0).getItemMgtId());
			itemMgtCnt.setItemStock(kwangjinItemRecevingMgtMapper.selectItemRecevingHisTotal(itemHisList.get(0)));
			itemMgtCnt.setCreatorId(JteUtils.getUserId());
			itemMgtCnt.setUpdatorId(JteUtils.getUserId());
			kwangjinItemRecevingMgtMapper.updateItemRecevingMgt(itemMgtCnt);
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("제품 사용 히스토리 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
}
