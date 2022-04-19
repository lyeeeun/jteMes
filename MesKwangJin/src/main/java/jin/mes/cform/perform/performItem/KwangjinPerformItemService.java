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
public class KwangjinPerformItemService {

	@Resource
    protected KwangjinPerformItemMapper kwangjinPerformItemMapper;

	public PageInfo<KwangjinPerformItemDto> getPerformItem(KwangjinPerformItemDto performItemDto, PageRequestVo pageRequestVo){
		List<KwangjinPerformItemDto> performItemList = null;
		int rowCount = 0;

		if(!performItemDto.getPagingYN().equals("N")) {
			performItemDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			performItemDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}

		try {
			rowCount = kwangjinPerformItemMapper.selectPerformItemCount(performItemDto);
			if (rowCount > 0) {
				performItemList = kwangjinPerformItemMapper.selectPerformItem(performItemDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (performItemList == null) {
			performItemList = new ArrayList<KwangjinPerformItemDto>();
		}
 		return new PageInfo<KwangjinPerformItemDto>(performItemList, pageRequestVo, rowCount);
	}
	
	public List<KwangjinPerformItemDto> selectKpiDefect(KwangjinPerformItemDto performItemDto) {
		try {
			return kwangjinPerformItemMapper.selectKpiDefect(performItemDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpiDefect " + e.getMessage());
		}
	}
}
