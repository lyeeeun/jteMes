package jin.mes.cform.item.itemToolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewItemToolMgtService {

	@Resource
    protected NewItemToolMgtMapper newItemToolMgtMapper;

    public PageInfo<NewItemToolMgtDto> getRtlEqmtList(NewItemToolMgtDto itemToolMgtDto, PageRequestVo pageRequestVo){
    	List<NewItemToolMgtDto> rtlEqmtList = null;
		int rowCount = 0;

		itemToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newItemToolMgtMapper.rowCount(itemToolMgtDto);
			if (rowCount > 0) {
				rtlEqmtList = newItemToolMgtMapper.selectRtlEqmtList(itemToolMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (rtlEqmtList == null) {
			rtlEqmtList = new ArrayList<NewItemToolMgtDto>();
		}
 		return new PageInfo<NewItemToolMgtDto>(rtlEqmtList, pageRequestVo, rowCount);
	}

	public List<NewItemToolMgtDto> getRtlToolList(NewItemToolMgtDto itemToolMgtDto) {
		List<NewItemToolMgtDto> rtlToolList = null;
		int rowCount = 0;
		
		try {
			rowCount = newItemToolMgtMapper.selectRtlToolCount(itemToolMgtDto);
			if (rowCount > 0) {
				rtlToolList = newItemToolMgtMapper.selectRtlToolList(itemToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getRtlToolList Error " + e.getMessage());
		}
		if (rtlToolList == null) {
			rtlToolList = new ArrayList<NewItemToolMgtDto>();
		}
		
		return rtlToolList;
	}
	
	@Transactional
	public void updateRtlTool(NewItemToolMgtDto itemToolMgtDto) {
		try {
			if(itemToolMgtDto.getToolList() != null) {
				itemToolMgtDto.getToolList().forEach(x -> {
					newItemToolMgtMapper.insertRtlTool(itemToolMgtDto.getItemId(), itemToolMgtDto.getEqmtMgtId(), x.getToolId());
				});
			}
			
			if(itemToolMgtDto.getDelToolList() != null) {
				itemToolMgtDto.getDelToolList().forEach(x -> {
					newItemToolMgtMapper.deleteRtlTool(itemToolMgtDto.getItemId(), itemToolMgtDto.getEqmtMgtId(), x.getToolId());
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: updateRtlTool Error " + e.getMessage());
		}
	}
}
