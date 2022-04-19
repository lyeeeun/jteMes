package jin.mes.form.facilMgt.facilOperMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class FacilOperMgtService {

	@Resource
	FacilOperMgtMapper facilOperMgtMapper;
	
	//설비정비이력 조회
	public PageInfo<FacilOperMgtDto> getEqmtOperList(FacilOperMgtDto facilOperMgtDto, PageRequestVo pageRequestVo){
		List<FacilOperMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		facilOperMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		facilOperMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = facilOperMgtMapper.selectEqmtOperCount(facilOperMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = facilOperMgtMapper.selectEqmtOperList(facilOperMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilOperMgtDto>();
		}
		return new PageInfo<FacilOperMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
}
