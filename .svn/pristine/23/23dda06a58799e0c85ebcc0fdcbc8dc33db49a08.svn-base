package jin.mes.cform.qualMgt.qualCheckList;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.routing.routingMgt.NewRoutingMgtDto;
import jin.mes.cform.qualMgt.qualPec.inputQualMgt.NewInputQualMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewQualCheckListService {

	@Resource
	NewQualCheckListMapper newQualCheckListMapper;
	
	@Transactional
	public PageInfo<NewQualCheckListDto> selectCheckListHistory(NewQualCheckListDto newQualCheckListDto, PageRequestVo pageRequestVo) {
		List<NewQualCheckListDto> checkListHistory = null;
		int rowCount = 0;
	
		// Page Setting
		newQualCheckListDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newQualCheckListDto.setLastIndex(pageRequestVo.getBlockLastPage());
	
		try {
			// Count
			rowCount = newQualCheckListMapper.selectCheckListHistoryCount(newQualCheckListDto);
			if (rowCount > 0) {
				// List
				checkListHistory = newQualCheckListMapper.selectCheckListHistory(newQualCheckListDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (checkListHistory == null) {
			checkListHistory = new ArrayList<NewQualCheckListDto>();
		}
		return new PageInfo<NewQualCheckListDto>(checkListHistory, pageRequestVo, rowCount);
	}

	@Transactional
	public List<NewQualCheckListDto> selectCheckList(NewQualCheckListDto newQualCheckListDto){
		List<NewQualCheckListDto> checkListInfo = null;

		try {
			checkListInfo = newQualCheckListMapper.selectCheckList(newQualCheckListDto);
		} catch (Exception e) {
			throw new BusinessException("selectCheckList : " + e.getMessage());
		}
		
		return checkListInfo;
	}
	
	@Transactional
	public void insertCheckList(NewQualCheckListDto newQualCheckListDto){
		try {
			
			String inspectId = newQualCheckListMapper.selectInspectId();
			
			Date date = new Date(); 
			SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss"); 
			String inspectDate = simple.format(date);
			
			String inspectorId = JteUtils.getUserId();
			
			for(NewQualCheckListDto inspectList : newQualCheckListDto.getInsertInspectList()){
				
				inspectList.setInspectId(inspectId);
				inspectList.setInspectDate(inspectDate);
				inspectList.setInspectorId(inspectorId);
				
				newQualCheckListMapper.insertCheckList(inspectList);
				
			}
				
		} catch (Exception e) {
			throw new BusinessException("insertCheckList : " + e.getMessage());
		}
	}
	
	@Transactional
	public void updateCheckList(NewQualCheckListDto newQualCheckListDto){
		try {
			for(NewQualCheckListDto inspectList : newQualCheckListDto.getUpdateInspectList()){
				newQualCheckListMapper.updateCheckList(inspectList);
			}
		} catch (Exception e) {
			throw new BusinessException("insertInspectList : " + e.getMessage());
		}
	}
}
