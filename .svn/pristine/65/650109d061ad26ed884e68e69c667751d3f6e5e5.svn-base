package jin.mes.cform.mfgMgt.strdperfMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewStrdperfMgtService {
	@Resource
	NewStrdperfMgtMapper newStrdperfMgtMapper;
	
	//표준/실적공수 조회
	public PageInfo<NewStrdperfMgtDto> getStrdperfList(NewStrdperfMgtDto newStrdperfMgtDto, PageRequestVo pageRequestVo){
		List<NewStrdperfMgtDto> strdperfMgtList = null;
		int rowCount = 0;

		// Page Setting
		newStrdperfMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newStrdperfMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newStrdperfMgtMapper.selectStrderfListCount(newStrdperfMgtDto);
			if (rowCount > 0) {
				//List
				strdperfMgtList = newStrdperfMgtMapper.selectStrderfList(newStrdperfMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("표준/실적공수 조회 에러입니다. : " + e.getMessage());
		}
		if (strdperfMgtList == null) {
			strdperfMgtList = new ArrayList<NewStrdperfMgtDto>();
		}
		return new PageInfo<NewStrdperfMgtDto>(strdperfMgtList, pageRequestVo, rowCount);
	}
	
	//표준/실적공수 상세조회
	public PageInfo<NewStrdperfMgtDto> getStrdperfDetailList(NewStrdperfMgtDto newStrdperfMgtDto, PageRequestVo pageRequestVo){
		List<NewStrdperfMgtDto> strdperfMgtList = null;
		int rowCount = 0;

		// Page Setting
		newStrdperfMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newStrdperfMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newStrdperfMgtMapper.selectStrderfDetailListCount(newStrdperfMgtDto);
			if (rowCount > 0) {
				//List
				strdperfMgtList = newStrdperfMgtMapper.selectStrderfDetailList(newStrdperfMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("표준/실적공수 상세조회  에러입니다. : " + e.getMessage());
		}
		if (strdperfMgtList == null) {
			strdperfMgtList = new ArrayList<NewStrdperfMgtDto>();
		}
		return new PageInfo<NewStrdperfMgtDto>(strdperfMgtList, pageRequestVo, rowCount);
	}
}
