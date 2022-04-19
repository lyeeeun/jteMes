package jin.mes.form.perform.processProgress;

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
public class ProcessProgressService {

	@Resource
    protected ProcessProgressMapper processProgressMapper;

	public PageInfo<ProcessProgressDto> getPerformItem(ProcessProgressDto processProgressDto, PageRequestVo pageRequestVo){
		List<ProcessProgressDto> processProgressList = null;
		int rowCount = 0;

		if(!processProgressDto.getPagingYN().equals("N")) {
			processProgressDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			processProgressDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}

		try {
			rowCount = processProgressMapper.selectPerformItemCount(processProgressDto);
			if (rowCount > 0) {
				processProgressList = processProgressMapper.selectPerformItem(processProgressDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (processProgressList == null) {
			processProgressList = new ArrayList<ProcessProgressDto>();
		}
 		return new PageInfo<ProcessProgressDto>(processProgressList, pageRequestVo, rowCount);
	}
	
	public List<ProcessProgressDto> selectKpiDefect(ProcessProgressDto processProgressDto) {
		try {
			return processProgressMapper.selectKpiDefect(processProgressDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpiDefect " + e.getMessage());
		}
	}
}
