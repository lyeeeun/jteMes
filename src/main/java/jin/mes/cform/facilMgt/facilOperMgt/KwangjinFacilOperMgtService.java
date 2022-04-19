package jin.mes.cform.facilMgt.facilOperMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinFacilOperMgtService {

	@Resource
	KwangjinFacilOperMgtMapper kwangjinFacilOperMgtMapper;
	
	//설비정비이력 조회
	public PageInfo<KwangjinFacilOperMgtDto> getEqmtOperList(KwangjinFacilOperMgtDto kwangjinFacilOperMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinFacilOperMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinFacilOperMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinFacilOperMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinFacilOperMgtMapper.selectEqmtOperCount(kwangjinFacilOperMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = kwangjinFacilOperMgtMapper.selectEqmtOperList(kwangjinFacilOperMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<KwangjinFacilOperMgtDto>();
		}
		return new PageInfo<KwangjinFacilOperMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	@Transactional
	public List<KwangjinFacilOperMgtDto> selectEqmtWorkList(KwangjinFacilOperMgtDto kwangjinFacilOperMgtDto){
		List<KwangjinFacilOperMgtDto> eqmtList = null;

		try {
			eqmtList = kwangjinFacilOperMgtMapper.selectEqmtWorkList(kwangjinFacilOperMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectInspItemList : " + e.getMessage());
		}
		
		return eqmtList;
	}
	
}
