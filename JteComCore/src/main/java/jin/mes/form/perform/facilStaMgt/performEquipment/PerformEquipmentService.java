package jin.mes.form.perform.facilStaMgt.performEquipment;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.operMgt.rlehoMgt.RlehoMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class PerformEquipmentService {

	@Resource
    protected PerformEquipmentMapper performEquipmentMapper;

	public PageInfo<PerformEquipmentDto> getPerfromEquipInfo(PerformEquipmentDto performEquipmentDto, PageRequestVo pageRequestVo){
		
		List<PerformEquipmentDto> performEquipInfoList = null;
		int rowCount = 0;
		if(!performEquipmentDto.getPagingYN().equals("N")) {
			performEquipmentDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			performEquipmentDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
			
		try {
			rowCount = performEquipmentMapper.rowCount(performEquipmentDto);
			if (rowCount > 0) {
				performEquipInfoList = performEquipmentMapper.selectPerformEquipInfo(performEquipmentDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getPerfromEquipInfo : " + e.getMessage());
		}

		if (performEquipInfoList == null) {
			performEquipInfoList = new ArrayList<PerformEquipmentDto>();
		}
 		return new PageInfo<PerformEquipmentDto>(performEquipInfoList, pageRequestVo, rowCount);
	}
	
	public List<RlehoMgtDto> selectPlaceAll(){
		List<RlehoMgtDto> placeList = null;
		
		try {
			placeList = performEquipmentMapper.selectPlaceAll();
			return placeList;
		} catch (Exception e) {
			throw new BusinessException("selectPlaceAll : " + e.getMessage());
		}
	}
}
