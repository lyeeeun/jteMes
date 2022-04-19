package jin.mes.cform.qualMgt.qualPec.qualPectMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.cform.mtrl.mtrlOdMgt.mtrlOdplanMgt.NewMtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewQualPectMgtService {
	
	@Resource
	NewQualPectMgtMapper newMtrlOrderQualMapper;
	
	public PageInfo<NewMtrlOdplanMgtDto> getMtrlOrderQualList(NewMtrlOdplanMgtDto mtrlOrderDto, PageRequestVo pageRequestVo){
		List<NewMtrlOdplanMgtDto> mtrlOrderList = null;
		int rowCount = 0;

		// Page Setting
		mtrlOrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlOrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newMtrlOrderQualMapper.selectMtrlOrderQualCount(mtrlOrderDto);
			if (rowCount > 0) {
				//List
				mtrlOrderList = newMtrlOrderQualMapper.selectMtrlOrderQualList(mtrlOrderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("품질 - 수입검사 조회 에러입니다 : " + e.getMessage());
		}
		if (mtrlOrderList == null) {
			mtrlOrderList = new ArrayList<NewMtrlOdplanMgtDto>();
		}
		return new PageInfo<NewMtrlOdplanMgtDto>(mtrlOrderList, pageRequestVo, rowCount);
	}
}
