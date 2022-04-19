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
public class KwangjinPerformOrderGridService {

	@Resource
    protected KwangjinPerformOrderGridMapper kwangjinPerformOrderGridMapper;

	public PageInfo<KwangjinPerformOrderGridDto> getPerformOrder(KwangjinPerformOrderGridDto performOrderGridDto, PageRequestVo pageRequestVo){
		List<KwangjinPerformOrderGridDto> performOrderList = null;
		int rowCount = 0;

		if(!performOrderGridDto.getPagingYN().equals("N")) {
			performOrderGridDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			performOrderGridDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		try {
			rowCount = kwangjinPerformOrderGridMapper.selectPerformOrderCount(performOrderGridDto);
			if (rowCount > 0) {
				performOrderList = kwangjinPerformOrderGridMapper.selectPerformOrder(performOrderGridDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (performOrderList == null) {
			performOrderList = new ArrayList<KwangjinPerformOrderGridDto>();
		}
 		return new PageInfo<KwangjinPerformOrderGridDto>(performOrderList, pageRequestVo, rowCount);
	}
	
	public PageInfo<KwangjinPerformOrderGridDto> getLotDetail(KwangjinPerformOrderGridDto performOrderGridDto, PageRequestVo pageRequestVo){
		List<KwangjinPerformOrderGridDto> lotDetailList = null;
		int rowCount = 0;

		performOrderGridDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		performOrderGridDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = kwangjinPerformOrderGridMapper.selectLotDetailCount(performOrderGridDto);
			if (rowCount > 0) {
				lotDetailList = kwangjinPerformOrderGridMapper.selectLotDetail(performOrderGridDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (lotDetailList == null) {
			lotDetailList = new ArrayList<KwangjinPerformOrderGridDto>();
		}
 		return new PageInfo<KwangjinPerformOrderGridDto>(lotDetailList, pageRequestVo, rowCount);
	}
	
}
