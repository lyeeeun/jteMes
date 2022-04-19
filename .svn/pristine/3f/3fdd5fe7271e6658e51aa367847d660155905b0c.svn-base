package jin.mes.cform.mfgMgt.analsMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewAnalsMgtService {
	@Resource
	NewAnalsMgtMapper newAnalsMgtMapper;
	
	public List<NewAnalsMgtDto> selectRoutingSheet(NewAnalsMgtDto newAnalsMgtDto) {
		List<NewAnalsMgtDto> RoutingSheetList = null;
		try {
			RoutingSheetList = newAnalsMgtMapper.selectRoutingSheet(newAnalsMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectRoutingSheet Error : " + e.getMessage());
		}
		if (RoutingSheetList == null) {
			RoutingSheetList = new ArrayList<NewAnalsMgtDto>();
		}
		return RoutingSheetList;
	}
}
