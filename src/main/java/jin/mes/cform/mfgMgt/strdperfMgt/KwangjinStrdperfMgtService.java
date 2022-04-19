package jin.mes.cform.mfgMgt.strdperfMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinStrdperfMgtService {
	@Resource
	KwangjinStrdperfMgtMapper kwangjinStrdperfMgtMapper;

	public PageInfo<KwangjinStrdperfMgtDto> getAssignList(KwangjinStrdperfMgtDto strdperfMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinStrdperfMgtDto> strdperfMgtList = null;
		int rowCount = 0;

		// Page Setting
		strdperfMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		strdperfMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinStrdperfMgtMapper.selectProdAssignCount(strdperfMgtDto);
			if (rowCount > 0) {
				//List
				strdperfMgtList = kwangjinStrdperfMgtMapper.selectProdAssignList(strdperfMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("표준/실적공수 조회 에러입니다. : " + e.getMessage());
		}
		if (strdperfMgtList == null) {
			strdperfMgtList = new ArrayList<KwangjinStrdperfMgtDto>();
		}
		return new PageInfo<KwangjinStrdperfMgtDto>(strdperfMgtList, pageRequestVo, rowCount);
	}
	//표준/실적공수 조회
	public PageInfo<KwangjinStrdperfMgtDto> getStrdperfList(KwangjinStrdperfMgtDto strdperfMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinStrdperfMgtDto> strdperfMgtList = null;
		int rowCount = 0;

		// Page Setting
		strdperfMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		strdperfMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinStrdperfMgtMapper.selectStrderfListCount(strdperfMgtDto);
			if (rowCount > 0) {
				//List
				strdperfMgtList = kwangjinStrdperfMgtMapper.selectStrderfList(strdperfMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("표준/실적공수 조회 에러입니다. : " + e.getMessage());
		}
		if (strdperfMgtList == null) {
			strdperfMgtList = new ArrayList<KwangjinStrdperfMgtDto>();
		}
		return new PageInfo<KwangjinStrdperfMgtDto>(strdperfMgtList, pageRequestVo, rowCount);
	}
	
	//표준/실적공수 상세조회
	public PageInfo<KwangjinStrdperfMgtDto> getStrdperfDetailList(KwangjinStrdperfMgtDto strdperfMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinStrdperfMgtDto> strdperfMgtList = null;
		int rowCount = 0;

		// Page Setting
		strdperfMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		strdperfMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinStrdperfMgtMapper.selectStrderfDetailListCount(strdperfMgtDto);
			if (rowCount > 0) {
				//List
				strdperfMgtList = kwangjinStrdperfMgtMapper.selectStrderfDetailList(strdperfMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("표준/실적공수 상세조회  에러입니다. : " + e.getMessage());
		}
		if (strdperfMgtList == null) {
			strdperfMgtList = new ArrayList<KwangjinStrdperfMgtDto>();
		}
		return new PageInfo<KwangjinStrdperfMgtDto>(strdperfMgtList, pageRequestVo, rowCount);
	}
}
