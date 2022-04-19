package jin.mes.cform.mfgMgt.mfgplanMgt.mrcalMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewMrcalMgtService {
	
	@Resource
	NewMrcalMgtMapper newMrcalMgtMapper;
	
	public PageInfo<NewMrcalMgtDto> getMtrlUseCalList(NewMrcalMgtDto mtrlUseCalDto, PageRequestVo pageRequestVo){
		List<NewMrcalMgtDto> mtrlUseCalList = null;
		int rowCount = 0;

		// Page Setting
		mtrlUseCalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlUseCalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newMrcalMgtMapper.selectMtrlUseCalCount(mtrlUseCalDto);
			if (rowCount > 0) {
				//List
				mtrlUseCalList = newMrcalMgtMapper.selectMtrlUseCalList(mtrlUseCalDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재소요량 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlUseCalList == null) {
			mtrlUseCalList = new ArrayList<NewMrcalMgtDto>();
		}
		return new PageInfo<NewMrcalMgtDto>(mtrlUseCalList, pageRequestVo, rowCount);
	}
	
}
