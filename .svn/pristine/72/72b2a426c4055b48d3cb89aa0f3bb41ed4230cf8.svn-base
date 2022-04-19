package jin.mes.cform.qualMgt.badTotalMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.cform.qualMgt.infergodsMgt.NewInfergodsMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewBadTotalMgtService {
	@Resource
	NewBadTotalMgtMapper newBadTotalMgtMapper;
	
	//불량코드 집계 조회(selectBox)
	public List<NewInfergodsMgtDto> getBadTotalSelectBoxList(NewInfergodsMgtDto badTotalDto){
		List<NewInfergodsMgtDto> badTotalList = null;
		try {
			badTotalList = newBadTotalMgtMapper.selectBadTotalSelectBoxList(badTotalDto);
		} catch (Exception e) {
			throw new BusinessException("불량코드 집계 조회(selectBox) 에러 : " + e.getMessage());
		}
		if (badTotalList == null) {
			badTotalList = new ArrayList<NewInfergodsMgtDto>();
		}
		return badTotalList;
	}
	
	//불량코드 집계 조회(Main)
	public PageInfo<NewInfergodsMgtDto> getBadTotalList(NewInfergodsMgtDto badTotalDto, PageRequestVo pageRequestVo){
		List<NewInfergodsMgtDto> badTotalList = null;
		int rowCount = 0;

		// Page Setting
		badTotalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		badTotalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newBadTotalMgtMapper.selectBadTotalCount(badTotalDto);
			if (rowCount > 0) {
				//List
				badTotalList = newBadTotalMgtMapper.selectBadTotalList(badTotalDto);
			}
		} catch (Exception e) {
			throw new BusinessException("불량코드 집계 조회(List) 에러 : " + e.getMessage());
		}
		if (badTotalList == null) {
			badTotalList = new ArrayList<NewInfergodsMgtDto>();
		}
		return new PageInfo<NewInfergodsMgtDto>(badTotalList, pageRequestVo, rowCount);
	}
	
	//불량코드 집계 조회(Detail)
	public PageInfo<NewInfergodsMgtDto> getBadTotalDetailList(NewInfergodsMgtDto badTotalDto, PageRequestVo pageRequestVo){
		List<NewInfergodsMgtDto> badTotalList = null;
		int rowCount = 0;

		// Page Setting
		badTotalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		badTotalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newBadTotalMgtMapper.selectBadTotalDetailCount(badTotalDto);
			if (rowCount > 0) {
				//List
				badTotalList = newBadTotalMgtMapper.selectBadTotalDetailList(badTotalDto);
			}
		} catch (Exception e) {
			throw new BusinessException("불량코드 집계 조회(Detail) 에러 : " + e.getMessage());
		}
		if (badTotalList == null) {
			badTotalList = new ArrayList<NewInfergodsMgtDto>();
		}
		return new PageInfo<NewInfergodsMgtDto>(badTotalList, pageRequestVo, rowCount);
	}
}
