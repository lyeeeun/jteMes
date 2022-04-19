package jin.mes.cform.perform.performEquipment;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.rlehoMgt.NewRlehoMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewPerformEquipmentService {

	@Resource
    protected NewPerformEquipmentMapper newPerformEquipmentMapper;

	public PageInfo<NewPerformEquipmentDto> getPerfromEquipInfo(NewPerformEquipmentDto performEquipmentDto, PageRequestVo pageRequestVo){
		
		List<NewPerformEquipmentDto> performEquipInfoList = null;
		int rowCount = 0;
		if(!performEquipmentDto.getPagingYN().equals("N")) {
			performEquipmentDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			performEquipmentDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
		
		try {
			rowCount = newPerformEquipmentMapper.rowCount(performEquipmentDto);
			if (rowCount > 0) {
				performEquipInfoList = newPerformEquipmentMapper.selectPerformEquipInfo(performEquipmentDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getPerfromEquipInfo : " + e.getMessage());
		}

		if (performEquipInfoList == null) {
			performEquipInfoList = new ArrayList<NewPerformEquipmentDto>();
		}
 		return new PageInfo<NewPerformEquipmentDto>(performEquipInfoList, pageRequestVo, rowCount);
	}
	
	public List<NewRlehoMgtDto> selectPlaceAll(){
		List<NewRlehoMgtDto> placeList = null;
		
		try {
			placeList = newPerformEquipmentMapper.selectPlaceAll();
			return placeList;
		} catch (Exception e) {
			throw new BusinessException("selectPlaceAll : " + e.getMessage());
		}
	}
}
