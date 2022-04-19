package jin.mes.form.item.itemToolMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.item.itemToolMgt.ItemToolRtlDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ItemToolMgtService {

	@Resource
    protected ItemToolMgtMapper itemToolMgtMapper;
	
	//품목별 공구정보 조회
	public PageInfo<ItemToolMgtDto> getItemToolRtlList(ItemToolMgtDto itemToolMgtDto, PageRequestVo pageRequestVo){
		List<ItemToolMgtDto> itemToolList = null;
		int rowCount = 0;

		// Page Setting
		itemToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = itemToolMgtMapper.selectItemToolListCount(itemToolMgtDto);
			if (rowCount > 0) {
				//List
				itemToolList = itemToolMgtMapper.selectItemToolList(itemToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (itemToolList == null) {
			itemToolList = new ArrayList<ItemToolMgtDto>();
		}
		return new PageInfo<ItemToolMgtDto>(itemToolList, pageRequestVo, rowCount);
	}
	
    public ItemToolMgtDto getItemToolPop(ItemToolMgtDto itemToolMgtDto) {
    	ItemToolMgtDto itemToolPop = null;
    	try {
    		itemToolPop = itemToolMgtMapper.selectItemToolinfo(itemToolMgtDto);
    		
    		if(!itemToolPop.getItemId().equals(null)) {
    			ItemToolRtlDto itemToolRtlDto = new ItemToolRtlDto();
    			itemToolRtlDto.setItemId(itemToolPop.getItemId());
    			itemToolPop.setChildToolMgtList(itemToolMgtMapper.selectItemToolChild(itemToolRtlDto));//에러발생
    		}
    		
    	}catch(Exception e){
    		throw new BusinessException("부품 업체관리팝업 조회 에러입니다. : " + e.getMessage());
    	}
    	return itemToolPop;
    }

	@Transactional
	public String setItemTool(ItemToolMgtDto itemToolMgtDto) {
		String returnKey = "";
		try {
			itemToolMgtDto.setCreatorId(JteUtils.getUserId());
			itemToolMgtDto.setUpdatorId(JteUtils.getUserId());
			
			
			if(itemToolMgtDto.getAction().equals("U")){//품목 변경
			
				itemToolMgtMapper.updateItemTool(itemToolMgtDto);
				
				returnKey =itemToolMgtDto.getItemId();
				
				setItemToolRtlSave(itemToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
		return returnKey;
	}
	
	public List<ItemToolMgtDto> getRtlToolList(ItemToolMgtDto itemToolMgtDto) {
		List<ItemToolMgtDto> rtlCompList = null;
		int rowCount = 0;
		
		try {
			rowCount = itemToolMgtMapper.selectRtlToolCount(itemToolMgtDto);
			if (rowCount > 0) {
				rtlCompList = itemToolMgtMapper.selectRtlToolList(itemToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error " + e.getMessage());
		}
		if (rtlCompList == null) {
			rtlCompList = new ArrayList<ItemToolMgtDto>();
		}
		
		return rtlCompList;
	}

	@Transactional
	public String setItemToolRtlSave(ItemToolMgtDto itemToolMgtDto){
		String returnKey = "";
		
		try {
			for(ItemToolRtlDto itemToolRtlDto : itemToolMgtDto.getChildToolMgtList()) {
				itemToolRtlDto.setCreatorId(JteUtils.getUserId());
				itemToolRtlDto.setUpdatorId(JteUtils.getUserId());
				
				if(itemToolRtlDto.getAction().equals("C")) {//
					//공구입력
					itemToolRtlDto.setItemId(itemToolMgtDto.getItemId());
					itemToolMgtMapper.insertRtlTool(itemToolRtlDto);
					returnKey = itemToolRtlDto.getToolId();
				}else if(itemToolRtlDto.getAction().equals("D")) {
					itemToolMgtMapper.deleteRtlTool(itemToolRtlDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구구매 업체 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
}
