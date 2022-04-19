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
	NewMrcalMgtMapper newMtrlUseCalMapper;
	
	public PageInfo<NewMrcalMgtDto> getMtrlUseCalList(NewMrcalMgtDto newMtrlUseCalDto, PageRequestVo pageRequestVo){
		List<NewMrcalMgtDto> mtrlUseCalList = null;
		int rowCount = 0;

		// Page Setting
		newMtrlUseCalDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newMtrlUseCalDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newMtrlUseCalMapper.selectMtrlUseCalCount(newMtrlUseCalDto);
			if (rowCount > 0) {
				//List
				mtrlUseCalList = newMtrlUseCalMapper.selectMtrlUseCalList(newMtrlUseCalDto);
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
