package jin.mes.form.devtol.svcLog;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class SvcLogService {
	@Resource
	SvcLogMapper svcLogMapper;
	

	
	/* 접속이력 조회 */
	public PageInfo<SvcLogDto> getSvcLogList(SvcLogDto svcLogDto, PageRequestVo pageRequestVo){
		List<SvcLogDto> pageLogList = null;
		int rowCount = 0;

		// Page Setting
		svcLogDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		svcLogDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = svcLogMapper.selectSvcLogCount(svcLogDto);
			if (rowCount > 0) {
				//List
				pageLogList = svcLogMapper.selectSvcLogList(svcLogDto);
			}
		} catch (Exception e) {
			throw new BusinessException("서비스 접근이력 조회 에러입니다. : " + e.getMessage());
		}
		if (pageLogList == null) {
			pageLogList = new ArrayList<SvcLogDto>();
		}
		return new PageInfo<SvcLogDto>(pageLogList, pageRequestVo, rowCount);
	}
	
	/* 접속이력 저장 */
	@Transactional
	public long setSvcLog(SvcLogDto svcLogDto){
		long returnKey = 0;
		try {
			if(svcLogDto.getAction().equals("C")) {//사용자 접속이력 등록
				//사용자 접속시작 저장
				 svcLogMapper.insertSvcLog(svcLogDto);
				 returnKey = svcLogDto.getSvcLogId();
			}else if(svcLogDto.getAction().equals("U")){//사용자 접속이력 수정
				//사용자 접속종료 저장
				svcLogDto.setSvcErrUser(JteUtils.getUserId());
				svcLogMapper.updateSvcLog(svcLogDto);
				returnKey = svcLogDto.getSvcLogId();
			}
		} catch (Exception e) {
			throw new BusinessException("서비스 접근 이력 저장 : " + e.getMessage());
		}
		
		return returnKey;
	}
}
