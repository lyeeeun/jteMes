package jin.mes.form.facilMgt.prevMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class PrevMgtService {
	@Resource
	PrevMgtMapper prevMgtMapper;
	
	public List<PrevMgtDto> selectPdmData(PrevMgtDto prevMgtDto) {
		List<PrevMgtDto> pdmDataList = null;
		try {
			pdmDataList = prevMgtMapper.selectPdmData(prevMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectRoutingSheet Error : " + e.getMessage());
		}
		if (pdmDataList == null) {
			pdmDataList = new ArrayList<PrevMgtDto>();
		}
		return pdmDataList;
	}
}
