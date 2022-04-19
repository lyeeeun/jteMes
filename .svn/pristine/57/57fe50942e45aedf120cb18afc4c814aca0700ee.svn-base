package jin.mes.cform.item.itemToolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(transactionManager="transactionManager")
@Slf4j
public class NewItemToolMgtService {

	@Resource
    protected NewItemToolMgtMapper newItemToolMgtMapper;
	
	public PageInfo<NewItemToolMgtDto> selectRtlToolInfo(NewItemToolMgtDto itemToolMgtDto, PageRequestVo pageRequestVo){
		List<NewItemToolMgtDto> rtlToolInfo = null;
		int rowCount = 0;

		itemToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		itemToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newItemToolMgtMapper.selectRtlToolInfoCount(itemToolMgtDto);
			if (rowCount > 0) {
				rtlToolInfo = newItemToolMgtMapper.selectRtlToolInfo(itemToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: selectRtlToolInfo Error " + e.getMessage());
		}

		if (rtlToolInfo == null) {
			rtlToolInfo = new ArrayList<NewItemToolMgtDto>();
		}
		return new PageInfo<NewItemToolMgtDto>(rtlToolInfo, pageRequestVo, rowCount);
	}
	
	public List<NewItemToolMgtDto> selectAllRtlToolInfo(NewItemToolMgtDto itemToolMgtDto) {
		List<NewItemToolMgtDto> rtlToolInfo;
		try {
			rtlToolInfo = newItemToolMgtMapper.selectAllRtlToolInfo(itemToolMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectAllRtlToolInfo Error " + e.getMessage());
		}
		
		return rtlToolInfo;
	}

	@Transactional
	public void saveRtlToolInfo(NewItemToolMgtDto itemToolMgtDto){
		try {
			if(itemToolMgtDto.getAction().equals("C")) {
				newItemToolMgtMapper.insertRtlToolInfo(itemToolMgtDto);
			} else if(itemToolMgtDto.getAction().equals("U")){
				newItemToolMgtMapper.updateRtlToolInfo(itemToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("saveRtlToolInfo : " + e.getMessage());
		}
	}
	
	//업체정보 삭제
	@Transactional
	public void deleteRtlToolInfo(List<NewItemToolMgtDto> itemToolList){
		try {
			for(NewItemToolMgtDto itemToolMgtDto : itemToolList){
				newItemToolMgtMapper.deleteRtlToolInfo(itemToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("deleteRtlToolInfo  : " + e.getMessage());
		}
	}
	
	@Transactional 
	public int selectDupleKeyCheck(NewItemToolMgtDto itemToolMgtDto){
		try { 
			return newItemToolMgtMapper.selectDupleKeyCheck(itemToolMgtDto); 
		} catch (Exception e) { 
			throw new BusinessException("selectDupleKeyCheck : " + e.getMessage()); 
		} 
	}
	
	
}
