package jin.mes.cform.devtol.svcLog;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.devtol.svcLog.KwangjinSvcLogDto;
import jin.mes.cform.devtol.svcLog.KwangjinSvcLogMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinSvcLogService {
	
	@Resource
	KwangjinSvcLogMapper kwangjinSvcLogMapper;
	

	
	/* 접속이력 조회 */
	public PageInfo<KwangjinSvcLogDto> getSvcLogList(KwangjinSvcLogDto kwangjinSvcLogDto, PageRequestVo pageRequestVo){
		List<KwangjinSvcLogDto> pageLogList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinSvcLogDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinSvcLogDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinSvcLogMapper.selectSvcLogCount(kwangjinSvcLogDto);
			if (rowCount > 0) {
				//List
				pageLogList = kwangjinSvcLogMapper.selectSvcLogList(kwangjinSvcLogDto);
			}
		} catch (Exception e) {
			throw new BusinessException("서비스 접근이력 조회 에러입니다. : " + e.getMessage());
		}
		if (pageLogList == null) {
			pageLogList = new ArrayList<KwangjinSvcLogDto>();
		}
		return new PageInfo<KwangjinSvcLogDto>(pageLogList, pageRequestVo, rowCount);
	}
	
	/* 접속이력 저장 */
	@Transactional
	public long setSvcLog(KwangjinSvcLogDto kwangjinSvcLogDto){
		long returnKey = 0;
		try {
			if(kwangjinSvcLogDto.getAction().equals("C")) {//사용자 접속이력 등록
				//사용자 접속시작 저장
				 kwangjinSvcLogMapper.insertSvcLog(kwangjinSvcLogDto);
				 returnKey = kwangjinSvcLogDto.getSvcLogId();
			}else if(kwangjinSvcLogDto.getAction().equals("U")){//사용자 접속이력 수정
				//사용자 접속종료 저장
				kwangjinSvcLogDto.setSvcErrUser(JteUtils.getUserId());
				kwangjinSvcLogMapper.updateSvcLog(kwangjinSvcLogDto);
				returnKey = kwangjinSvcLogDto.getSvcLogId();
			}
		} catch (Exception e) {
			throw new BusinessException("서비스 접근 이력 저장 : " + e.getMessage());
		}
		
		return returnKey;
	}
}
