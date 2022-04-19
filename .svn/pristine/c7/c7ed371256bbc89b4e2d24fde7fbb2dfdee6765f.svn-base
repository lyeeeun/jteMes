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

    public PageInfo<NewItemToolMgtDto> getRtlEqmtList(NewItemToolMgtDto newItemToolMgtDto, PageRequestVo pageRequestVo){
    	List<NewItemToolMgtDto> rtlEqmtList = null;
		int rowCount = 0;

		newItemToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newItemToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newItemToolMgtMapper.rowCount(newItemToolMgtDto);
			if (rowCount > 0) {
				rtlEqmtList = newItemToolMgtMapper.selectRtlEqmtList(newItemToolMgtDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (rtlEqmtList == null) {
			rtlEqmtList = new ArrayList<NewItemToolMgtDto>();
		}
 		return new PageInfo<NewItemToolMgtDto>(rtlEqmtList, pageRequestVo, rowCount);
	}

	public List<NewItemToolMgtDto> getRtlToolList(NewItemToolMgtDto newItemToolMgtDto) {
		List<NewItemToolMgtDto> rtlToolList = null;
		int rowCount = 0;
		
		try {
			rowCount = newItemToolMgtMapper.selectRtlToolCount(newItemToolMgtDto);
			if (rowCount > 0) {
				rtlToolList = newItemToolMgtMapper.selectRtlToolList(newItemToolMgtDto);
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
	public void updateRtlTool(NewItemToolMgtDto newItemToolMgtDto) {
		try {
			if(newItemToolMgtDto.getToolList() != null) {
				newItemToolMgtDto.getToolList().forEach(x -> {
					newItemToolMgtMapper.insertRtlTool(newItemToolMgtDto.getItemId(), newItemToolMgtDto.getEqmtMgtId(), x.getToolId());
				});
			}
			
			if(newItemToolMgtDto.getDelToolList() != null) {
				newItemToolMgtDto.getDelToolList().forEach(x -> {
					newItemToolMgtMapper.deleteRtlTool(newItemToolMgtDto.getItemId(), newItemToolMgtDto.getEqmtMgtId(), x.getToolId());
				});
			}
		} catch (Exception e) {
			throw new BusinessException("Service: updateRtlTool Error " + e.getMessage());
		}
	}
}
