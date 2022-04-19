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
public class ZinixItemStockMgtService {

	@Resource
    protected ZinixItemStockMgtMapper zinixItemStockMgtMapper;

    public PageInfo<ZinixItemStockMgtDto> getItemStockList(ZinixItemStockMgtDto itemStockMgtDto, PageRequestVo pageRequestVo){
    	List<ZinixItemStockMgtDto> itemStockList = null;
		int rowCount = 0;

		itemStockMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemStockMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = zinixItemStockMgtMapper.rowCount(itemStockMgtDto);
			if (rowCount > 0) {
				itemStockList = zinixItemStockMgtMapper.selectItemStockList(itemStockMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemStockList == null) {
			itemStockList = new ArrayList<ZinixItemStockMgtDto>();
		}
 		return new PageInfo<ZinixItemStockMgtDto>(itemStockList, pageRequestVo, rowCount);
	}
    
  //라우팅시트 조회
  	public List<ZinixItemStockMgtDto> getStockList(ZinixItemStockMgtDto itemStockMgtDto) {
  		List<ZinixItemStockMgtDto> stockList = null;
  		try {
  			stockList = zinixItemStockMgtMapper.selectStockList(itemStockMgtDto);
  		} catch (Exception e) {
  			throw new BusinessException("제품 관리 조회 에러입니다.(Pop) : " + e.getMessage());
  		}
  		if (stockList == null) {
  			stockList = new ArrayList<ZinixItemStockMgtDto>();
		}
  		
  		return stockList;
  	}
    
    
    public PageInfo<ZinixItemStockMgtDto> getItemStockHistory(ZinixItemStockMgtDto itemStockMgtDto, PageRequestVo pageRequestVo){
    	List<ZinixItemStockMgtDto> itemStockHistory = null;
		int rowCount = 0;

		itemStockMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemStockMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = zinixItemStockMgtMapper.itemStockHistoryCount(itemStockMgtDto);
			if (rowCount > 0) {
				itemStockHistory = zinixItemStockMgtMapper.selectItemStockHistory(itemStockMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (itemStockHistory == null) {
			itemStockHistory = new ArrayList<ZinixItemStockMgtDto>();
		}
 		return new PageInfo<ZinixItemStockMgtDto>(itemStockHistory, pageRequestVo, rowCount);
	}

    
    public void insertItemStock(ZinixItemStockMgtDto itemStockMgtDto) {
    	try {
    		zinixItemStockMgtMapper.insertItemMgtStock(itemStockMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: insertItemStock Error " + e.getMessage());
		}
    }
    public void updateItemMgt(ZinixItemStockMgtDto itemStockMgtDto) {
    	try {
    		zinixItemStockMgtMapper.updateItemMgtStock(itemStockMgtDto);
    	} catch (Exception e) {
    		throw new BusinessException("Service: updateItemMgt Error " + e.getMessage());
    	}
    }
    
	@Transactional
	public int deleteItemStock(List<ZinixItemStockMgtDto> itemStockList){
		int resultInt = -1;
		try {
			//자재삭제
			for(ZinixItemStockMgtDto itemStockMgtDto : itemStockList){
				zinixItemStockMgtMapper.deleteItemStock(itemStockMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("제품 관리 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
    
    //품목 관리 관리자 저장
  	@Transactional
  	public String updateItemStock(ZinixItemStockMgtDto itemStockMgtDto) {
  		String keyItemId = "";
  		
  		try {
  			keyItemId = itemStockMgtDto.getItemId();
  			
  			itemStockMgtDto.setCreatorId(JteUtils.getUserId());
  			itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
  			
  			zinixItemStockMgtMapper.insertManualInfo(itemStockMgtDto);
  			zinixItemStockMgtMapper.insertItemStockHistory(itemStockMgtDto);
  			
  			itemStockMgtDto.setItemStock(zinixItemStockMgtMapper.selectItemStock(itemStockMgtDto));
			
  			zinixItemStockMgtMapper.updateItemStock(itemStockMgtDto);
  			
  			itemStockMgtDto.setItemTotalStock(zinixItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
  			
  			zinixItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
  			
  		} catch (Exception e) {
  			keyItemId = "";
  			throw new BusinessException("Service: updateItemStock Error " + e.getMessage());
  		}
  		return keyItemId;
  	}
  	
  	
	// 타모듈에서 품목 재고 저장(입력/수정/삭제) - jkkim(생산 작업)  
	@Transactional
	public String setItemStockPgSave(ZinixItemStockMgtDto itemStockMgtDto){
		String returnKey = "";
		try {
			//등록자/수정자 등록
			itemStockMgtDto.setCreatorId(JteUtils.getUserId());
  			itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
  			
			//신규등록
			if(itemStockMgtDto.getAction().equals("C")) {
				//품목 히스토리 - 등록
				zinixItemStockMgtMapper.insertItemStockHistory(itemStockMgtDto);
				returnKey = itemStockMgtDto.getItemMgtId();
			} else if(itemStockMgtDto.getAction().equals("U")){
				//품목 히스토리 - 수정
				zinixItemStockMgtMapper.updateTargetStock(itemStockMgtDto);
				returnKey = itemStockMgtDto.getItemMgtId();
			}else if(itemStockMgtDto.getAction().equals("D")){
				//품목 히스토리 - 삭제
				zinixItemStockMgtMapper.deleteTargetStock(itemStockMgtDto);
				returnKey = itemStockMgtDto.getItemMgtId();
			}
			
			//품목관리 - 수량 업데이트
			itemStockMgtDto.setItemStock(zinixItemStockMgtMapper.selectItemStock(itemStockMgtDto));
			zinixItemStockMgtMapper.updateItemStock(itemStockMgtDto);
			
			//폼목정보 - 총 수량 업데이트
			itemStockMgtDto.setItemTotalStock(zinixItemStockMgtMapper.selectItemTotalStock(itemStockMgtDto));
			zinixItemStockMgtMapper.updateItemTotalStock(itemStockMgtDto);
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("품목 수량 저장 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//품목 관리 관리자 저장
	@Transactional
	public void itemCompleteUse(ZinixItemStockMgtDto itemStockMgtDto) {
		try {
			itemStockMgtDto.setUpdatorId(JteUtils.getUserId());
			zinixItemStockMgtMapper.updateItemMgtIsDel(itemStockMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: itemCompleteUse Error " + e.getMessage());
		}
	}	
}
