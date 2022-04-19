package jin.mes.form.mfgMgt.strdperfMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.mapper.mfgMgt.strdperfMgt.StrdperfMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class StrdperfMgtService {
	@Resource
	StrdperfMgtMapper strdperfMgtMapper;
	
	//표준/실적공수 조회
	public PageInfo<StrdperfMgtDto> getStrdperfList(StrdperfMgtDto strdperfMgtDto, PageRequestVo pageRequestVo){
		List<StrdperfMgtDto> strdperfMgtList = null;
		int rowCount = 0;

		// Page Setting
		strdperfMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		strdperfMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = strdperfMgtMapper.selectStrderfListCount(strdperfMgtDto);
			if (rowCount > 0) {
				//List
				strdperfMgtList = strdperfMgtMapper.selectStrderfList(strdperfMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("표준/실적공수 조회 에러입니다. : " + e.getMessage());
		}
		if (strdperfMgtList == null) {
			strdperfMgtList = new ArrayList<StrdperfMgtDto>();
		}
		return new PageInfo<StrdperfMgtDto>(strdperfMgtList, pageRequestVo, rowCount);
	}
	
	//표준/실적공수 상세조회
	public PageInfo<StrdperfMgtDto> getStrdperfDetailList(StrdperfMgtDto strdperfMgtDto, PageRequestVo pageRequestVo){
		List<StrdperfMgtDto> strdperfMgtList = null;
		int rowCount = 0;

		// Page Setting
		strdperfMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		strdperfMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = strdperfMgtMapper.selectStrderfDetailListCount(strdperfMgtDto);
			if (rowCount > 0) {
				//List
				strdperfMgtList = strdperfMgtMapper.selectStrderfDetailList(strdperfMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("표준/실적공수 상세조회  에러입니다. : " + e.getMessage());
		}
		if (strdperfMgtList == null) {
			strdperfMgtList = new ArrayList<StrdperfMgtDto>();
		}
		return new PageInfo<StrdperfMgtDto>(strdperfMgtList, pageRequestVo, rowCount);
	}
}
