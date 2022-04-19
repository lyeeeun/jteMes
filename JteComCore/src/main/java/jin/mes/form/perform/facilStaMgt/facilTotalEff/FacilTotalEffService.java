package jin.mes.form.perform.facilStaMgt.facilTotalEff;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class FacilTotalEffService {
	
	@Resource
	FacilTotalEffMapper facilTotalEffMapper;
	
	//설비정비이력 조회
	public PageInfo<FacilTotalEffDto> getEqmtMgtList(FacilTotalEffDto facilTotalEffDto, PageRequestVo pageRequestVo){
		List<FacilTotalEffDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		facilTotalEffDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		facilTotalEffDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = facilTotalEffMapper.selectEqmtMgtCount(facilTotalEffDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = facilTotalEffMapper.selectEqmtMgtList(facilTotalEffDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilTotalEffDto>();
		}
		return new PageInfo<FacilTotalEffDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
}
