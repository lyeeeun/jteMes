package jin.mes.cform.perform.itemAggregation;

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
public class ZinixItemAggregationService {

	@Resource
    protected ZinixItemAggregationMapper zinixItemAggregationMapper;

	public PageInfo<ZinixItemAggregationDto> getItemAggregation(ZinixItemAggregationDto zinixItemAggregationDto, PageRequestVo pageRequestVo){
		List<ZinixItemAggregationDto> itemAggregationList = null;
		int rowCount = 0;
		
		try {
			zinixItemAggregationDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			zinixItemAggregationDto.setLastIndex(pageRequestVo.getBlockLastPage());
			
			
			rowCount = zinixItemAggregationMapper.selectItemAggregationCount(zinixItemAggregationDto);
			System.out.println(zinixItemAggregationMapper.selectItemAggregationCount(zinixItemAggregationDto));
			
			if (rowCount > 0) {
				itemAggregationList = zinixItemAggregationMapper.selectItemAggregation(zinixItemAggregationDto);
				
			}
		} catch (Exception e) {
			throw new BusinessException("생산현황 조회 에러 (service) : " + e.getMessage());
		}

		if (itemAggregationList == null) {
			itemAggregationList = new ArrayList<ZinixItemAggregationDto>();
		}
 		return new PageInfo<ZinixItemAggregationDto>(itemAggregationList, pageRequestVo, rowCount);
	}
}
