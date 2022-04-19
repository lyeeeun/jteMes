package jin.mes.form.qualMgt.qualPec.qualPectMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class QualPectMgtService {
	
	@Resource
	QualPectMgtMapper mtrlOrderQualMapper;
	
	public PageInfo<MtrlOdplanMgtDto> getMtrlOrderQualList(MtrlOdplanMgtDto mtrlOrderDto, PageRequestVo pageRequestVo){
		List<MtrlOdplanMgtDto> mtrlOrderList = null;
		int rowCount = 0;

		// Page Setting
		mtrlOrderDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		mtrlOrderDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = mtrlOrderQualMapper.selectMtrlOrderQualCount(mtrlOrderDto);
			if (rowCount > 0) {
				//List
				mtrlOrderList = mtrlOrderQualMapper.selectMtrlOrderQualList(mtrlOrderDto);
			}
		} catch (Exception e) {
			throw new BusinessException("품질 - 수입검사 조회 에러입니다 : " + e.getMessage());
		}
		if (mtrlOrderList == null) {
			mtrlOrderList = new ArrayList<MtrlOdplanMgtDto>();
		}
		return new PageInfo<MtrlOdplanMgtDto>(mtrlOrderList, pageRequestVo, rowCount);
	}
}
