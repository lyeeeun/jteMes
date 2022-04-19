package jin.mes.form.devtol.pageLog;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class PageLogService {
	@Resource
	PageLogMapper pageLogMapper;
	
	@Autowired
	HttpServletRequest request;
	
	/* 페이지 접속이력 조회 */
	public PageInfo<PageLogDto> getPageLogList(PageLogDto pageLogDto, PageRequestVo pageRequestVo){
		List<PageLogDto> pageLogList = null;
		int rowCount = 0;

		// Page Setting
		pageLogDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		pageLogDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = pageLogMapper.selectPageLogCount(pageLogDto);
			if (rowCount > 0) {
				//List
				pageLogList = pageLogMapper.selectPageLogList(pageLogDto);
			}
		} catch (Exception e) {
			throw new BusinessException("페이지 접속이력 조회 에러입니다. : " + e.getMessage());
		}
		if (pageLogList == null) {
			pageLogList = new ArrayList<PageLogDto>();
		}
		return new PageInfo<PageLogDto>(pageLogList, pageRequestVo, rowCount);
	}
	
	/* 접속이력 저장 */
	@Transactional
	public String setPageLog(PageLogDto pageLogDto){
		String returnKey = "";
		try {
			pageLogDto.setUserId(JteUtils.getUserId());
			pageLogDto.setPageLogIp(JteUtils.getClientIp());
			pageLogDto.setPageLogDevice(JteUtils.getUserDevice());
			if(pageLogDto.getAction().equals("C")) {//사용자 접속이력 등록
				//사용자 접속시작 저장
				 pageLogMapper.insertPageLog(pageLogDto);
				 returnKey = pageLogDto.getPageLogId();
			}else if(pageLogDto.getAction().equals("U")){//사용자 접속이력 수정
				//사용자 접속종료 저장
				pageLogMapper.updatePageLog(pageLogDto);
				returnKey = pageLogDto.getPageLogId();
			}
		} catch (Exception e) {
			throw new BusinessException("페이지 접속이력 저장 : " + e.getMessage());
		}
		
		return returnKey;
	}
}
