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
	public List<NewInfergodsMgtDto> getBadTotalSelectBoxList(NewInfergodsMgtDto newBadTotalDto){
		List<NewInfergodsMgtDto> badTotalList = null;
		try {
			badTotalList = newBadTotalMgtMapper.selectBadTotalSelectBoxList(newBadTotalDto);
		} catch (Exception e) {
			throw new BusinessException("불량코드 집계 조회(selectBox) 에러 : " + e.getMessage());
		}
		if (badTotalList == null) {
			badTotalList = new ArrayList<NewInfergodsMgtDto>();
		}
		return badTotalList;
	}
	
	//불량코드 집계 조회(Main)
	public PageInfo<NewInfergodsMgtDto> getBadTotalList(NewInfergodsMgtDto newBadTotalDto, PageRequestVo pageRequestVo){
		List<NewInfergodsMgtDto> badTotalList = null;
		int rowCount = 0;

		// Page Setting
		newBadTotalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newBadTotalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newBadTotalMgtMapper.selectBadTotalCount(newBadTotalDto);
			if (rowCount > 0) {
				//List
				badTotalList = newBadTotalMgtMapper.selectBadTotalList(newBadTotalDto);
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
	public PageInfo<NewInfergodsMgtDto> getBadTotalDetailList(NewInfergodsMgtDto newBadTotalDto, PageRequestVo pageRequestVo){
		List<NewInfergodsMgtDto> badTotalList = null;
		int rowCount = 0;

		// Page Setting
		newBadTotalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newBadTotalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newBadTotalMgtMapper.selectBadTotalDetailCount(newBadTotalDto);
			if (rowCount > 0) {
				//List
				badTotalList = newBadTotalMgtMapper.selectBadTotalDetailList(newBadTotalDto);
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
