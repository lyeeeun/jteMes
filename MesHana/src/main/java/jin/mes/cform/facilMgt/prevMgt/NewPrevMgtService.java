package jin.mes.cform.facilMgt.prevMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewPrevMgtService {
	@Resource
	NewPrevMgtMapper newPrevMgtMapper;
	
	public List<NewPrevMgtDto> selectPdmData(NewPrevMgtDto newPrevMgtDto) {
		List<NewPrevMgtDto> pdmDataList = null;
		try {
			pdmDataList = newPrevMgtMapper.selectPdmData(newPrevMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectRoutingSheet Error : " + e.getMessage());
		}
		if (pdmDataList == null) {
			pdmDataList = new ArrayList<NewPrevMgtDto>();
		}
		return pdmDataList;
	}
}
