package jin.mes.cform.perform.processProgress;

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
public class KwangjinProcessProgressService {

	@Resource
    protected KwangjinProcessProgressMapper kwangjinProcessProgressMapper;

	public PageInfo<KwangjinProcessProgressDto> getPerformItem(KwangjinProcessProgressDto processProgressDto, PageRequestVo pageRequestVo){
		List<KwangjinProcessProgressDto> processProgressList = null;
		int rowCount = 0;

		if(!processProgressDto.getPagingYN().equals("N")) {
			processProgressDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			processProgressDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}

		try {
			rowCount = kwangjinProcessProgressMapper.selectPerformItemCount(processProgressDto);
			if (rowCount > 0) {
				processProgressList = kwangjinProcessProgressMapper.selectPerformItem(processProgressDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (processProgressList == null) {
			processProgressList = new ArrayList<KwangjinProcessProgressDto>();
		}
 		return new PageInfo<KwangjinProcessProgressDto>(processProgressList, pageRequestVo, rowCount);
	}
	
	public List<KwangjinProcessProgressDto> selectKpiDefect(KwangjinProcessProgressDto processProgressDto) {
		try {
			return kwangjinProcessProgressMapper.selectKpiDefect(processProgressDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpiDefect " + e.getMessage());
		}
	}
}
