package jin.mes.form.qualMgt.badTotalMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.qualMgt.infergodsMgt.InfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class BadTotalMgtService {
	@Resource
	BadTotalMgtMapper badTotalMgtMapper;
	
	//불량코드 집계 조회(selectBox)
	public List<InfergodsMgtDto> getBadTotalSelectBoxList(InfergodsMgtDto badTotalDto){
		List<InfergodsMgtDto> badTotalList = null;
		try {
			badTotalList = badTotalMgtMapper.selectBadTotalSelectBoxList(badTotalDto);
		} catch (Exception e) {
			throw new BusinessException("불량코드 집계 조회(selectBox) 에러 : " + e.getMessage());
		}
		if (badTotalList == null) {
			badTotalList = new ArrayList<InfergodsMgtDto>();
		}
		return badTotalList;
	}
	
	//불량코드 집계 조회(Main)
	public PageInfo<InfergodsMgtDto> getBadTotalList(InfergodsMgtDto badTotalDto, PageRequestVo pageRequestVo){
		List<InfergodsMgtDto> badTotalList = null;
		int rowCount = 0;

		// Page Setting
		badTotalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		badTotalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = badTotalMgtMapper.selectBadTotalCount(badTotalDto);
			if (rowCount > 0) {
				//List
				badTotalList = badTotalMgtMapper.selectBadTotalList(badTotalDto);
			}
		} catch (Exception e) {
			throw new BusinessException("불량코드 집계 조회(List) 에러 : " + e.getMessage());
		}
		if (badTotalList == null) {
			badTotalList = new ArrayList<InfergodsMgtDto>();
		}
		return new PageInfo<InfergodsMgtDto>(badTotalList, pageRequestVo, rowCount);
	}
	
	//불량코드 집계 조회(Detail)
	public PageInfo<InfergodsMgtDto> getBadTotalDetailList(InfergodsMgtDto badTotalDto, PageRequestVo pageRequestVo){
		List<InfergodsMgtDto> badTotalList = null;
		int rowCount = 0;

		// Page Setting
		badTotalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		badTotalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = badTotalMgtMapper.selectBadTotalDetailCount(badTotalDto);
			if (rowCount > 0) {
				//List
				badTotalList = badTotalMgtMapper.selectBadTotalDetailList(badTotalDto);
			}
		} catch (Exception e) {
			throw new BusinessException("불량코드 집계 조회(Detail) 에러 : " + e.getMessage());
		}
		if (badTotalList == null) {
			badTotalList = new ArrayList<InfergodsMgtDto>();
		}
		return new PageInfo<InfergodsMgtDto>(badTotalList, pageRequestVo, rowCount);
	}
}
