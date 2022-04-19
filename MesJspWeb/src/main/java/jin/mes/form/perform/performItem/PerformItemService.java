package jin.mes.form.perform.performItem;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.mapper.perform.performItem.PerformItemMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class PerformItemService {

	@Resource
    protected PerformItemMapper performItemMapper;

	public PageInfo<PerformItemDto> getPerformItem(PerformItemDto performItemDto, PageRequestVo pageRequestVo){
		List<PerformItemDto> performItemList = null;
		int rowCount = 0;

		if(!performItemDto.getPagingYN().equals("N")) {
			performItemDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			performItemDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}

		try {
			rowCount = performItemMapper.selectPerformItemCount(performItemDto);
			if (rowCount > 0) {
				performItemList = performItemMapper.selectPerformItem(performItemDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (performItemList == null) {
			performItemList = new ArrayList<PerformItemDto>();
		}
 		return new PageInfo<PerformItemDto>(performItemList, pageRequestVo, rowCount);
	}
	
	public List<PerformItemDto> selectKpiDefect(PerformItemDto performItemDto) {
		try {
			return performItemMapper.selectKpiDefect(performItemDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpiDefect " + e.getMessage());
		}
	}
}
