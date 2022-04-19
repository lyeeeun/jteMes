package jin.mes.form.perform.itemAggregation;

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
public class ItemAggregationService {

	@Resource
    protected ItemAggregationMapper itemAggregationMapper;

	public PageInfo<ItemAggregationDto> getItemAggregation(ItemAggregationDto itemAggregationDto, PageRequestVo pageRequestVo){
		List<ItemAggregationDto> itemAggregationList = null;
		int rowCount = 0;
		
		try {
			itemAggregationDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			itemAggregationDto.setLastIndex(pageRequestVo.getBlockLastPage());
			
			
			rowCount = itemAggregationMapper.selectItemAggregationCount(itemAggregationDto);
			System.out.println(itemAggregationMapper.selectItemAggregationCount(itemAggregationDto));
			
			if (rowCount > 0) {
				itemAggregationList = itemAggregationMapper.selectItemAggregation(itemAggregationDto);
				
			}
		} catch (Exception e) {
			throw new BusinessException("생산현황 조회 에러 (service) : " + e.getMessage());
		}

		if (itemAggregationList == null) {
			itemAggregationList = new ArrayList<ItemAggregationDto>();
		}
 		return new PageInfo<ItemAggregationDto>(itemAggregationList, pageRequestVo, rowCount);
	}
}
