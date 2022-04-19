package jin.mes.form.item.itemToolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.mapper.item.itemToolMgt.ItemToolMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class ItemToolMgtService {

	@Resource
    protected ItemToolMgtMapper itemToolMgtMapper;

    public PageInfo<ItemToolMgtDto> getRtlEqmtList(ItemToolMgtDto itemToolMgtDto, PageRequestVo pageRequestVo){
    	List<ItemToolMgtDto> rtlEqmtList = null;
		int rowCount = 0;

		itemToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = itemToolMgtMapper.rowCount(itemToolMgtDto);
			if (rowCount > 0) {
				rtlEqmtList = itemToolMgtMapper.selectRtlEqmtList(itemToolMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (rtlEqmtList == null) {
			rtlEqmtList = new ArrayList<ItemToolMgtDto>();
		}
 		return new PageInfo<ItemToolMgtDto>(rtlEqmtList, pageRequestVo, rowCount);
	}

	public List<ItemToolMgtDto> getRtlToolList(ItemToolMgtDto itemToolMgtDto) {
		List<ItemToolMgtDto> rtlToolList = null;
		int rowCount = 0;
		
		try {
			rowCount = itemToolMgtMapper.selectRtlToolCount(itemToolMgtDto);
			if (rowCount > 0) {
				rtlToolList = itemToolMgtMapper.selectRtlToolList(itemToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlToolList Error " + e.getMessage());
		}
		if (rtlToolList == null) {
			rtlToolList = new ArrayList<ItemToolMgtDto>();
		}
		
		return rtlToolList;
	}
	
	@Transactional
	public void updateRtlTool(ItemToolMgtDto itemToolMgtDto) {
		try {
			if(itemToolMgtDto.getToolList() != null) {
				itemToolMgtDto.getToolList().forEach(x -> {
					itemToolMgtMapper.insertRtlTool(itemToolMgtDto.getItemId(), itemToolMgtDto.getEqmtMgtId(), x.getToolId());
				});
			}
			
			if(itemToolMgtDto.getDelToolList() != null) {
				itemToolMgtDto.getDelToolList().forEach(x -> {
					itemToolMgtMapper.deleteRtlTool(itemToolMgtDto.getItemId(), itemToolMgtDto.getEqmtMgtId(), x.getToolId());
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: updateRtlTool Error " + e.getMessage());
		}
	}
}