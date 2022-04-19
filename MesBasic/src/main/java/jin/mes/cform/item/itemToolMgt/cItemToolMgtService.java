package jin.mes.cform.item.itemToolMgt;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import kr.co.itcall.jte.spring.user.model.ItemToolMgtDto;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class cItemToolMgtService {

	@Autowired
    protected cItemToolMgtMapper citemToolMgtMapper;

    public PageInfo<ItemToolMgtDto> getRtlEqmtList(ItemToolMgtDto itemToolMgtDto, PageRequestVo pageRequestVo){
    	List<ItemToolMgtDto> rtlEqmtList = null;
		int rowCount = 0;

		itemToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = citemToolMgtMapper.rowCount(itemToolMgtDto);
			if (rowCount > 0) {
				rtlEqmtList = citemToolMgtMapper.selectRtlEqmtList(itemToolMgtDto);
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
			rowCount = citemToolMgtMapper.selectRtlToolCount(itemToolMgtDto);
			if (rowCount > 0) {
				rtlToolList = citemToolMgtMapper.selectRtlToolList(itemToolMgtDto);
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
					citemToolMgtMapper.insertRtlTool(itemToolMgtDto.getItemId(), itemToolMgtDto.getEqmtMgtId(), x.getToolId());
				});
			}
			
			if(itemToolMgtDto.getDelToolList() != null) {
				itemToolMgtDto.getDelToolList().forEach(x -> {
					citemToolMgtMapper.deleteRtlTool(itemToolMgtDto.getItemId(), itemToolMgtDto.getEqmtMgtId(), x.getToolId());
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: updateRtlTool Error " + e.getMessage());
		}
	}
}
