package jin.mes.cform.facilMgt.performEquipment;

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
public class KwangjinPerformEquipmentService {

	@Resource
    protected KwangjinPerformEquipmentMapper kwangjinPerformEquipmentMapper;

	public PageInfo<KwangjinPerformEquipmentDto> getPerfromEquipInfo(KwangjinPerformEquipmentDto performEquipmentDto, PageRequestVo pageRequestVo){
		
		List<KwangjinPerformEquipmentDto> performEquipInfoList = null;
		int rowCount = 0;
		if(!performEquipmentDto.getPagingYN().equals("N")) {
			performEquipmentDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
			performEquipmentDto.setLastIndex(pageRequestVo.getBlockLastPage());
		}
			
		try {
			rowCount = kwangjinPerformEquipmentMapper.rowCount(performEquipmentDto);
			if (rowCount > 0) {
				performEquipInfoList = kwangjinPerformEquipmentMapper.selectPerformEquipInfo(performEquipmentDto);
			}
		} catch (Exception e) {
			throw new BusinessException("getPerfromEquipInfo : " + e.getMessage());
		}

		if (performEquipInfoList == null) {
			performEquipInfoList = new ArrayList<KwangjinPerformEquipmentDto>();
		}
 		return new PageInfo<KwangjinPerformEquipmentDto>(performEquipInfoList, pageRequestVo, rowCount);
	}
	
	public List<RlehoMgtDto> selectPlaceAll(){
		List<RlehoMgtDto> placeList = null;
		
		try {
			placeList = kwangjinPerformEquipmentMapper.selectPlaceAll();
			return placeList;
		} catch (Exception e) {
			throw new BusinessException("selectPlaceAll : " + e.getMessage());
		}
	}
}
