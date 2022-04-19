package jin.mes.form.mfgMgt.mfgplanMgt.mrcalMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.mapper.mfgMgt.mfgplanMgt.mrcalMgt.MrcalMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MrcalMgtService {
	
	@Resource
	MrcalMgtMapper mtrlUseCalMapper;
	
	public PageInfo<MrcalMgtDto> getMtrlUseCalList(MrcalMgtDto mtrlUseCalDto, PageRequestVo pageRequestVo){
		List<MrcalMgtDto> mtrlUseCalList = null;
		int rowCount = 0;

		// Page Setting
		mtrlUseCalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlUseCalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlUseCalMapper.selectMtrlUseCalCount(mtrlUseCalDto);
			if (rowCount > 0) {
				//List
				mtrlUseCalList = mtrlUseCalMapper.selectMtrlUseCalList(mtrlUseCalDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재소요량 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlUseCalList == null) {
			mtrlUseCalList = new ArrayList<MrcalMgtDto>();
		}
		return new PageInfo<MrcalMgtDto>(mtrlUseCalList, pageRequestVo, rowCount);
	}
	
}
