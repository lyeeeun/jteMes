package jin.mes.cform.item.itemStockMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewItemStockMgtService {

	@Resource
    protected NewItemStockMgtMapper newItemStockMgtMapper;

    public PageInfo<NewItemStockMgtDto> getItemStockList(NewItemStockMgtDto newItemStockMgtDto, PageRequestVo pageRequestVo){
    	List<NewItemStockMgtDto> itemStockList = null;
		int rowCount = 0;

		newItemStockMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newItemStockMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newItemStockMgtMapper.rowCount(newItemStockMgtDto);
			if (rowCount > 0) {
				itemStockList = newItemStockMgtMapper.selectItemStockList(newItemStockMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemStockList == null) {
			itemStockList = new ArrayList<NewItemStockMgtDto>();
		}
 		return new PageInfo<NewItemStockMgtDto>(itemStockList, pageRequestVo, rowCount);
	}
    
    
    public PageInfo<NewItemStockMgtDto> getItemStockHistory(NewItemStockMgtDto newItemStockMgtDto, PageRequestVo pageRequestVo){
    	List<NewItemStockMgtDto> itemStockHistory = null;
		int rowCount = 0;

		newItemStockMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newItemStockMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newItemStockMgtMapper.itemStockHistoryCount(newItemStockMgtDto);
			if (rowCount > 0) {
				itemStockHistory = newItemStockMgtMapper.selectItemStockHistory(newItemStockMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemStockHistory == null) {
			itemStockHistory = new ArrayList<NewItemStockMgtDto>();
		}
 		return new PageInfo<NewItemStockMgtDto>(itemStockHistory, pageRequestVo, rowCount);
	}

    
    public void insertItemStock(NewItemStockMgtDto newItemStockMgtDto) {
    	try {
    		newItemStockMgtMapper.insertItemStock(newItemStockMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: insertItemStock Error " + e.getMessage());
		}
    }
    
    //품목 관리 관리자 저장
  	@Transactional
  	public String updateItemStock(NewItemStockMgtDto newItemStockMgtDto) {
  		String keyItemId = "";
  		
  		try {
  			keyItemId = newItemStockMgtDto.getItemId();
  			
  			newItemStockMgtDto.setCreatorId(JteUtils.getUserId());
  			newItemStockMgtDto.setUpdatorId(JteUtils.getUserId());
  			
  			newItemStockMgtMapper.insertManualInfo(newItemStockMgtDto);
  			newItemStockMgtMapper.insertItemStockHistory(newItemStockMgtDto);
  			
  			newItemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(newItemStockMgtDto));
			
  			newItemStockMgtMapper.updateItemStock(newItemStockMgtDto);
  			
  			newItemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(newItemStockMgtDto));
  			
  			newItemStockMgtMapper.updateItemTotalStock(newItemStockMgtDto);
  			
  		} catch (Exception e) {
  			keyItemId = "";
  			throw new BusinessException("Service: updateItemStock Error " + e.getMessage());
  		}
  		return keyItemId;
  	}
  	
  	
	// 타모듈에서 품목 재고 저장(입력/수정/삭제) - jkkim(생산 작업)  
	@Transactional
	public String setItemStockPgSave(NewItemStockMgtDto newItemStockMgtDto){
		String returnKey = "";
		try {
			//등록자/수정자 등록
			newItemStockMgtDto.setCreatorId(JteUtils.getUserId());
  			newItemStockMgtDto.setUpdatorId(JteUtils.getUserId());
  			
			//신규등록
			if(newItemStockMgtDto.getAction().equals("C")) {
				//품목 히스토리 - 등록
				newItemStockMgtMapper.insertItemStockHistory(newItemStockMgtDto);
				returnKey = newItemStockMgtDto.getItemMgtId();
			} else if(newItemStockMgtDto.getAction().equals("U")){
				//품목 히스토리 - 수정
				newItemStockMgtMapper.updateTargetStock(newItemStockMgtDto);
				returnKey = newItemStockMgtDto.getItemMgtId();
			}else if(newItemStockMgtDto.getAction().equals("D")){
				//품목 히스토리 - 삭제
				newItemStockMgtMapper.deleteTargetStock(newItemStockMgtDto);
				returnKey = newItemStockMgtDto.getItemMgtId();
			}
			
			//품목관리 - 수량 업데이트
			newItemStockMgtDto.setItemStock(newItemStockMgtMapper.selectItemStock(newItemStockMgtDto));
			newItemStockMgtMapper.updateItemStock(newItemStockMgtDto);
			
			//폼목정보 - 총 수량 업데이트
			newItemStockMgtDto.setItemTotalStock(newItemStockMgtMapper.selectItemTotalStock(newItemStockMgtDto));
			newItemStockMgtMapper.updateItemTotalStock(newItemStockMgtDto);
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("품목 수량 저장 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//품목 관리 관리자 저장
	@Transactional
	public void itemCompleteUse(NewItemStockMgtDto newItemStockMgtDto) {
		try {
			newItemStockMgtDto.setUpdatorId(JteUtils.getUserId());
			newItemStockMgtMapper.updateItemMgtIsDel(newItemStockMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: itemCompleteUse Error " + e.getMessage());
		}
	}	
}
