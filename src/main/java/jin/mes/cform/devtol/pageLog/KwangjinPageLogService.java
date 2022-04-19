package jin.mes.cform.devtol.pageLog;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.devtol.pageLog.KwangjinPageLogDto;
import jin.mes.cform.devtol.pageLog.KwangjinPageLogMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinPageLogService {
	@Resource
	KwangjinPageLogMapper kwangjinpageLogMapper;
	
	@Autowired
	HttpServletRequest request;
	
	/* 페이지 접속이력 조회 */
	public PageInfo<KwangjinPageLogDto> getPageLogList(KwangjinPageLogDto kwangjinPageLogDto, PageRequestVo pageRequestVo){
		List<KwangjinPageLogDto> pageLogList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinPageLogDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinPageLogDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinpageLogMapper.selectPageLogCount(kwangjinPageLogDto);
			if (rowCount > 0) {
				//List
				pageLogList = kwangjinpageLogMapper.selectPageLogList(kwangjinPageLogDto);
			}
		} catch (Exception e) {
			throw new BusinessException("페이지 접속이력 조회 에러입니다. : " + e.getMessage());
		}
		if (pageLogList == null) {
			pageLogList = new ArrayList<KwangjinPageLogDto>();
		}
		return new PageInfo<KwangjinPageLogDto>(pageLogList, pageRequestVo, rowCount);
	}
	
	/* 접속이력 저장 */
	@Transactional
	public String setPageLog(KwangjinPageLogDto kwangjinPageLogDto){
		String returnKey = "";
		try {
			kwangjinPageLogDto.setUserId(JteUtils.getUserId());
			kwangjinPageLogDto.setPageLogIp(JteUtils.getClientIp());
			kwangjinPageLogDto.setPageLogDevice(JteUtils.getUserDevice());
			if(kwangjinPageLogDto.getAction().equals("C")) {//사용자 접속이력 등록
				//사용자 접속시작 저장
				 kwangjinpageLogMapper.insertPageLog(kwangjinPageLogDto);
				 returnKey = kwangjinPageLogDto.getPageLogId();
			}else if(kwangjinPageLogDto.getAction().equals("U")){//사용자 접속이력 수정
				//사용자 접속종료 저장
				kwangjinpageLogMapper.updatePageLog(kwangjinPageLogDto);
				returnKey = kwangjinPageLogDto.getPageLogId();
			}
		} catch (Exception e) {
			throw new BusinessException("페이지 접속이력 저장 : " + e.getMessage());
		}
		
		return returnKey;
	}
}
