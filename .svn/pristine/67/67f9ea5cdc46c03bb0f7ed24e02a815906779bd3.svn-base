package jin.mes.cform.perform.performItem;

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
public class NewPerformItemService {

	@Resource
    protected NewPerformItemMapper newPerformItemMapper;

	public PageInfo<NewPerformItemDto> getPerformItem(NewPerformItemDto newPerformItemDto, PageRequestVo pageRequestVo){
		List<NewPerformItemDto> performItemList = null;
		int rowCount = 0;

		if(!newPerformItemDto.getPagingYN().equals("N")) {
			newPerformItemDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			newPerformItemDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}

		try {
			rowCount = newPerformItemMapper.selectPerformItemCount(newPerformItemDto);
			if (rowCount > 0) {
				performItemList = newPerformItemMapper.selectPerformItem(newPerformItemDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (performItemList == null) {
			performItemList = new ArrayList<NewPerformItemDto>();
		}
 		return new PageInfo<NewPerformItemDto>(performItemList, pageRequestVo, rowCount);
	}
	
	public List<NewPerformItemDto> selectKpiDefect(NewPerformItemDto newPerformItemDto) {
		try {
			return newPerformItemMapper.selectKpiDefect(newPerformItemDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpiDefect " + e.getMessage());
		}
	}
}
