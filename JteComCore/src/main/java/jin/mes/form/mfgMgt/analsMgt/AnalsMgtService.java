package jin.mes.form.mfgMgt.analsMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class AnalsMgtService {
	@Resource
	AnalsMgtMapper analsMgtMapper;
	
	public List<AnalsMgtDto> selectRoutingSheet(AnalsMgtDto analsMgtDto) {
		List<AnalsMgtDto> RoutingSheetList = null;
		try {
			RoutingSheetList = analsMgtMapper.selectRoutingSheet(analsMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectRoutingSheet Error : " + e.getMessage());
		}
		if (RoutingSheetList == null) {
			RoutingSheetList = new ArrayList<AnalsMgtDto>();
		}
		return RoutingSheetList;
	}
}
