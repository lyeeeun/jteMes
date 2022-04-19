package jin.mes.cform.perform.performOrderGrid;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewPerformOrderGridService {

	@Resource
    protected NewPerformOrderGridMapper newPerformOrderGridMapper;

	public PageInfo<NewPerformOrderGridDto> getPerformOrder(NewPerformOrderGridDto performOrderGridDto, PageRequestVo pageRequestVo){
		List<NewPerformOrderGridDto> performOrderList = null;
		int rowCount = 0;

		if(!performOrderGridDto.getPagingYN().equals("N")) {
			performOrderGridDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			performOrderGridDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		try {
			rowCount = newPerformOrderGridMapper.selectPerformOrderCount(performOrderGridDto);
			if (rowCount > 0) {
				performOrderList = newPerformOrderGridMapper.selectPerformOrder(performOrderGridDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (performOrderList == null) {
			performOrderList = new ArrayList<NewPerformOrderGridDto>();
		}
 		return new PageInfo<NewPerformOrderGridDto>(performOrderList, pageRequestVo, rowCount);
	}
	
	public PageInfo<NewPerformOrderGridDto> getLotDetail(NewPerformOrderGridDto performOrderGridDto, PageRequestVo pageRequestVo){
		List<NewPerformOrderGridDto> lotDetailList = null;
		int rowCount = 0;

		performOrderGridDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		performOrderGridDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newPerformOrderGridMapper.selectLotDetailCount(performOrderGridDto);
			if (rowCount > 0) {
				lotDetailList = newPerformOrderGridMapper.selectLotDetail(performOrderGridDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (lotDetailList == null) {
			lotDetailList = new ArrayList<NewPerformOrderGridDto>();
		}
 		return new PageInfo<NewPerformOrderGridDto>(lotDetailList, pageRequestVo, rowCount);
	}
	
}
