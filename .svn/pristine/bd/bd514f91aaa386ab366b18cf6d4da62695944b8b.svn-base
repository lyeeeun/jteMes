package jin.mes.form.ship.pickMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.item.itemStockMgt.ItemStockMgtDto;
import jin.mes.form.item.itemStockMgt.ItemStockMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class PickMgtService {

	@Resource
    protected PickMgtMapper pickMgtMapper;
	
	@Autowired
	ItemStockMgtService itemStockService; 

	public PageInfo<PickMgtDto> selectPickInfo(PickMgtDto pickMgtDto, PageRequestVo pageRequestVo){
		List<PickMgtDto> pickInfoList = null;
		int rowCount = 0;

		pickMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		pickMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = pickMgtMapper.selectPickInfoCount(pickMgtDto);
			if (rowCount > 0) {
				pickInfoList = pickMgtMapper.selectPickInfo(pickMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (pickInfoList == null) {
			pickInfoList = new ArrayList<PickMgtDto>();
		}
		return new PageInfo<PickMgtDto>(pickInfoList, pageRequestVo, rowCount);
	}
	
	public PageInfo<PickMgtDto> selectBarcodeInfo(PickMgtDto pickMgtDto, PageRequestVo pageRequestVo){
		List<PickMgtDto> barcodeInfoList = null;
		int rowCount = 0;

		pickMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		pickMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = pickMgtMapper.selectBarcodeInfoCount(pickMgtDto);
			if (rowCount > 0) {
				barcodeInfoList = pickMgtMapper.selectBarcodeInfo(pickMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (barcodeInfoList == null) {
			barcodeInfoList = new ArrayList<PickMgtDto>();
		}
		return new PageInfo<PickMgtDto>(barcodeInfoList, pageRequestVo, rowCount);
	}

	public List<PickMgtDto> selectBarcodeInfoAll(PickMgtDto pickMgtDto) {
		List<PickMgtDto> barcodeInfoList = null;
		try {
			barcodeInfoList = pickMgtMapper.selectBarcodeInfoAll(pickMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectBarcodeInfoAll : " + e.getMessage());
		}
		return barcodeInfoList;
	}
	
	
	@Transactional
	public String setPickInfo(PickMgtDto pickMgtDto){
		String returnKey = "";
		try {
			
			//현재시간
			SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date dateTime = new Date();
			String nowDateTime = dateFormat.format(dateTime);
			
			
			if(pickMgtDto.getAction().equals("C")) {
				pickMgtDto.setCreatorId(JteUtils.getUserId());
				
				pickMgtMapper.insertPickInfo(pickMgtDto);
				
				for(PickMgtDto barcode : pickMgtDto.getBarcodeList()) {
					barcode.setItemMgtId(pickMgtDto.getItemMgtId());
					barcode.setPickId(pickMgtDto.getPickId());
					pickMgtMapper.insertBarcode(barcode);
				}
				
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(pickMgtDto.getItemId(), pickMgtDto.getItemMgtId(), -pickMgtDto.getPickQty(),
							"prod_tagt02", pickMgtDto.getPickId(), nowDateTime, pickMgtDto.getCreatorId());
				itemStockMgtDto.setAction("C");
				itemStockService.setItemStockPgSave(itemStockMgtDto);
				
			} else if(pickMgtDto.getAction().equals("U")) {
				pickMgtMapper.updatePickInfo(pickMgtDto);
				
				for(PickMgtDto barcode : pickMgtDto.getBarcodeList()) {
					
					barcode.setItemMgtId(pickMgtDto.getItemMgtId());
					barcode.setPickId(pickMgtDto.getPickId());

					if(barcode.getAction().equals("C")) {
						pickMgtMapper.insertBarcode(barcode);
					} else if(barcode.getAction().equals("D")) {
						pickMgtMapper.deleteBarcode(barcode);
					}
				}
				
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(pickMgtDto.getItemId(), pickMgtDto.getItemMgtId(), -pickMgtDto.getPickQty(),
						"prod_tagt02", pickMgtDto.getPickId(), nowDateTime, pickMgtDto.getCreatorId());
				itemStockMgtDto.setAction("U");
				itemStockService.setItemStockPgSave(itemStockMgtDto);	
				
				// Update 시, 포장 재고량은 기존 포장 수량 - 변경 된 포장 수량
				pickMgtDto.setPickQty(pickMgtDto.getUpdatePickQty());
			}
		
			pickMgtMapper.updatePackageStock(pickMgtDto);
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("setPickInfo : " + e.getMessage());
		}
		return returnKey;
	}
	
	@Transactional
	public int deletePickInfo(List<PickMgtDto> pickMgtDtoList){
		int resultInt = -1;
		try {
			
			for(PickMgtDto pickMgtDto : pickMgtDtoList){
				pickMgtMapper.deletePickInfo(pickMgtDto);
				pickMgtMapper.deleteBarcode(pickMgtDto);
				
				pickMgtDto.setPickQty(-pickMgtDto.getPickQty());
				
				ItemStockMgtDto itemStockMgtDto = new ItemStockMgtDto(pickMgtDto.getItemId(), pickMgtDto.getItemMgtId(), -pickMgtDto.getPickQty(),
						"prod_tagt02", pickMgtDto.getPickId(), "", pickMgtDto.getCreatorId());
				itemStockMgtDto.setAction("D");
				
				itemStockService.setItemStockPgSave(itemStockMgtDto);	
				
				pickMgtMapper.updatePackageStock(pickMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("deletePickInfo : " + e.getMessage());
		}
		return resultInt;
	}
	
}
