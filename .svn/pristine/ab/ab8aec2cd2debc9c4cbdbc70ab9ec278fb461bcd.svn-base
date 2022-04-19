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
public class ZinixProcessProgressService {

	@Resource
    protected ZinixProcessProgressMapper zinixProcessProgressMapper;

	public PageInfo<ZinixProcessProgressDto> getPerformItem(ZinixProcessProgressDto zinixProcessProgressDto, PageRequestVo pageRequestVo){
		List<ZinixProcessProgressDto> zinixProcessProgressList = null;
		int rowCount = 0;

		if(!zinixProcessProgressDto.getPagingYN().equals("N")) {
			zinixProcessProgressDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			zinixProcessProgressDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}

		try {
			rowCount = zinixProcessProgressMapper.selectPerformItemCount(zinixProcessProgressDto);
			if (rowCount > 0) {
				zinixProcessProgressList = zinixProcessProgressMapper.selectPerformItem(zinixProcessProgressDto);
			}
		} catch (Exception e) {
			log.error(e.toString());
		}

		if (zinixProcessProgressList == null) {
			zinixProcessProgressList = new ArrayList<ZinixProcessProgressDto>();
		}
 		return new PageInfo<ZinixProcessProgressDto>(zinixProcessProgressList, pageRequestVo, rowCount);
	}
	
	public List<ZinixProcessProgressDto> selectKpiDefect(ZinixProcessProgressDto zinixProcessProgressDto) {
		try {
			return zinixProcessProgressMapper.selectKpiDefect(zinixProcessProgressDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectKpiDefect " + e.getMessage());
		}
	}
}
