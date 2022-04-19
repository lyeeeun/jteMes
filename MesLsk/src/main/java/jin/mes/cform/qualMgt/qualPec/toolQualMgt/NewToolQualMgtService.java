package jin.mes.cform.qualMgt.qualPec.toolQualMgt;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.item.itemToolMgt.NewItemToolMgtDto;
import jin.mes.cform.item.itemToolMgt.NewItemToolMgtMapper;
import jin.mes.cform.qualMgt.qualCheckList.NewQualCheckListDto;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class NewToolQualMgtService {

	@Resource
	protected NewToolQualMgtMapper newToolQualMgtMapper;
	
	public PageInfo<NewToolQualMgtDto> selectToolInspInfo(NewToolQualMgtDto toolQualMgtDto, PageRequestVo pageRequestVo){
		List<NewToolQualMgtDto> toolInspInfo = null;
		int rowCount = 0;

		toolQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			rowCount = newToolQualMgtMapper.selectToolInspInfoCount(toolQualMgtDto);
			if (rowCount > 0) {
				toolInspInfo = newToolQualMgtMapper.selectToolInspInfo(toolQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: selectToolInspInfo Error " + e.getMessage());
		}

		if (toolInspInfo == null) {
			toolInspInfo = new ArrayList<NewToolQualMgtDto>();
		}
		return new PageInfo<NewToolQualMgtDto>(toolInspInfo, pageRequestVo, rowCount);
	}
	
	public List<NewToolQualMgtDto> selectRtlPlaceInfo(NewToolQualMgtDto toolQualMgtDto) {
		List<NewToolQualMgtDto> rtlPlaceInfo;
		try {
			rtlPlaceInfo = newToolQualMgtMapper.selectRtlPlaceInfo(toolQualMgtDto);
		} catch (Exception e) {
			throw new BusinessException("Service: selectRtlPlaceInfo Error " + e.getMessage());
		}
		
		return rtlPlaceInfo;
	}
	
	@Transactional
	public List<NewToolQualMgtDto> selectInspHistory(NewToolQualMgtDto toolQualMgtDto){
		List<NewToolQualMgtDto> inspHistory = null;

		try {
			inspHistory = newToolQualMgtMapper.selectInspHistory(toolQualMgtDto);
		} catch (Exception e) {
			throw new BusinessException("selectCheckList : " + e.getMessage());
		}
		
		return inspHistory;
	}
	
	@Transactional
	public void insertToolInspInfo(NewToolQualMgtDto toolQualMgtDto){
		try {
			String toolInspId = newToolQualMgtMapper.selectToolInspId();
			
			Date date = new Date(); 
			SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss"); 
			String inspectDate = simple.format(date);
			
			String inspectorId = JteUtils.getUserId();
			
			for(NewToolQualMgtDto toolInspList : toolQualMgtDto.getToolInspectList()){
				
				toolInspList.setToolInspId(toolInspId);
				toolInspList.setInspectDate(inspectDate);
				toolInspList.setInspectorId(inspectorId);
				
				newToolQualMgtMapper.insertToolInspInfo(toolInspList);
			}
		} catch (Exception e) {
			throw new BusinessException("insertToolInspInfo : " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateToolInspInfo(NewToolQualMgtDto toolQualMgtDto){
		try {
			for(NewToolQualMgtDto toolInspList : toolQualMgtDto.getToolInspectList()){
				newToolQualMgtMapper.updateToolInspInfo(toolInspList);
			}
		} catch (Exception e) {
			throw new BusinessException("updateToolInspInfo : " + e.getMessage());
		}
	}
//
//	@Transactional
//	public void saveRtlToolInfo(NewItemToolMgtDto itemToolMgtDto){
//		try {
//			if(itemToolMgtDto.getAction().equals("C")) {
//				newItemToolMgtMapper.insertRtlToolInfo(itemToolMgtDto);
//			} else if(itemToolMgtDto.getAction().equals("U")){
//				newItemToolMgtMapper.updateRtlToolInfo(itemToolMgtDto);
//			}
//		} catch (Exception e) {
//			throw new BusinessException("saveRtlToolInfo : " + e.getMessage());
//		}
//	}
//	
//	//업체정보 삭제
//	@Transactional
//	public void deleteRtlToolInfo(List<NewItemToolMgtDto> itemToolList){
//		try {
//			for(NewItemToolMgtDto itemToolMgtDto : itemToolList){
//				newItemToolMgtMapper.deleteRtlToolInfo(itemToolMgtDto);
//			}
//		} catch (Exception e) {
//			throw new BusinessException("deleteRtlToolInfo  : " + e.getMessage());
//		}
//	}
//	
}
