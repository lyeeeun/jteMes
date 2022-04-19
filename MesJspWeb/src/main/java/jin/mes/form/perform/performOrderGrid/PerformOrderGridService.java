package jin.mes.form.perform.performOrderGrid;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.mapper.perform.performOrderGrid.PerformOrderGridMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class PerformOrderGridService {

	@Resource
    protected PerformOrderGridMapper performOrderGridMapper;

	public PageInfo<PerformOrderGridDto> getPerformOrder(PerformOrderGridDto performOrderGridDto, PageRequestVo pageRequestVo){
		List<PerformOrderGridDto> performOrderList = null;
		int rowCount = 0;

		if(!performOrderGridDto.getPagingYN().equals("N")) {
			performOrderGridDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			performOrderGridDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		try {
			rowCount = performOrderGridMapper.selectPerformOrderCount(performOrderGridDto);
			if (rowCount > 0) {
				performOrderList = performOrderGridMapper.selectPerformOrder(performOrderGridDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (performOrderList == null) {
			performOrderList = new ArrayList<PerformOrderGridDto>();
		}
 		return new PageInfo<PerformOrderGridDto>(performOrderList, pageRequestVo, rowCount);
	}
	
	public PageInfo<PerformOrderGridDto> getLotDetail(PerformOrderGridDto performOrderGridDto, PageRequestVo pageRequestVo){
		List<PerformOrderGridDto> lotDetailList = null;
		int rowCount = 0;

		performOrderGridDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		performOrderGridDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = performOrderGridMapper.selectLotDetailCount(performOrderGridDto);
			if (rowCount > 0) {
				lotDetailList = performOrderGridMapper.selectLotDetail(performOrderGridDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (lotDetailList == null) {
			lotDetailList = new ArrayList<PerformOrderGridDto>();
		}
 		return new PageInfo<PerformOrderGridDto>(lotDetailList, pageRequestVo, rowCount);
	}
	
}
