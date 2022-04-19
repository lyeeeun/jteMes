package jin.mes.cform.qualMgt.qualCheckList;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.qualMgt.inputQualMgt.KwangjinInputQualMgtDto;
import jin.mes.cform.qualMgt.inputQualMgt.KwangjinInputQualMgtMapper;
import jin.mes.cform.ship.shipPlanMgt.KwangjinShipPlanMgtDto;
import jin.mes.cform.ship.shipPlanMgt.KwangjinShipPlanMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinQualCheckListService {

	@Resource
	KwangjinQualCheckListMapper kwangjinQualCheckListMapper;
	
	@Resource
	KwangjinShipPlanMgtMapper kwangjinShipPlanMgtMapper;
	
	@Resource
	KwangjinInputQualMgtMapper kwangjinInputQualMgtMapper;
	
	@Transactional
	public PageInfo<KwangjinQualCheckListDto> selectCheckListHistory(KwangjinQualCheckListDto kwangjinQualCheckListDto, PageRequestVo pageRequestVo) {
		List<KwangjinQualCheckListDto> checkListHistory = null;
		int rowCount = 0;
	
		// Page Setting
		kwangjinQualCheckListDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinQualCheckListDto.setLastIndex(pageRequestVo.getBlockLastPage());
	
		try {
			// Count
			rowCount = kwangjinQualCheckListMapper.selectCheckListHistoryCount(kwangjinQualCheckListDto);
			if (rowCount > 0) {
				// List
				checkListHistory = kwangjinQualCheckListMapper.selectCheckListHistory(kwangjinQualCheckListDto);
			}
		} catch (Exception e) {
			throw new BusinessException("체크리스트 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (checkListHistory == null) {
			checkListHistory = new ArrayList<KwangjinQualCheckListDto>();
		}
		return new PageInfo<KwangjinQualCheckListDto>(checkListHistory, pageRequestVo, rowCount);
	}
	//체크리스트 조회
	@Transactional
	public List<KwangjinQualCheckListDto> selectCheckList(KwangjinQualCheckListDto kwangjinQualCheckListDto){
		List<KwangjinQualCheckListDto> checkListInfo = null;

		try {
			checkListInfo = kwangjinQualCheckListMapper.selectCheckList(kwangjinQualCheckListDto);
		} catch (Exception e) {
			throw new BusinessException("selectCheckList : " + e.getMessage());
		}
		
		return checkListInfo;
	}
	
	//체크리스트 신규 등록
	@Transactional
	public void insertCheckList(KwangjinQualCheckListDto kwangjinQualCheckListDto){
		try {
			
			String inspectId = kwangjinQualCheckListMapper.selectInspectId();
			
			Date date = new Date(); 
			SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss"); 
			String inspectDate = simple.format(date);
			
			String inspectorId = JteUtils.getUserId();
			
			for(KwangjinQualCheckListDto inspectList : kwangjinQualCheckListDto.getInsertInspectList()){
				
				inspectList.setInspectId(inspectId);
				inspectList.setInspectDate(inspectDate);
				inspectList.setInspectorId(inspectorId);
				kwangjinQualCheckListMapper.insertCheckList(inspectList);
			}
	
			if(!kwangjinQualCheckListDto.getCurrentMenuId().equals(null) && kwangjinQualCheckListDto.getCurrentMenuId().equals("shipPectMgt")) {
				//출하검사 - 출하정보의 검사 상태를 검사 완료로 변경
				KwangjinShipPlanMgtDto shipPlanMgtDto = new KwangjinShipPlanMgtDto();
				shipPlanMgtDto.setShipPlanId(kwangjinQualCheckListDto.getTargetId());
				shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
				shipPlanMgtDto.setShipInspect(kwangjinQualCheckListDto.getShipInspect());
				
				kwangjinShipPlanMgtMapper.updateShipInspect(shipPlanMgtDto);
			}else if(!kwangjinQualCheckListDto.getCurrentMenuId().equals(null) && kwangjinQualCheckListDto.getCurrentMenuId().equals("inputQualMgt")) {
				//입고검사 - 검사 상태를 검사 완료로 변경
				KwangjinInputQualMgtDto inputQualMgtMgtDto = new KwangjinInputQualMgtDto();
				inputQualMgtMgtDto.setMtrlQtyTargetCode(kwangjinQualCheckListDto.getTargetId());
				inputQualMgtMgtDto.setUpdatorId(JteUtils.getUserId());
				inputQualMgtMgtDto.setMtrlInspect(kwangjinQualCheckListDto.getMtrlInspect());
				
				kwangjinInputQualMgtMapper.updateMtrlInput(inputQualMgtMgtDto);
			}
				
		} catch (Exception e) {
			throw new BusinessException("insertCheckList : " + e.getMessage());
		}
	}
	
	//체크리스트 수정
	@Transactional
	public void updateCheckList(KwangjinQualCheckListDto kwangjinQualCheckListDto){
		try {
			for(KwangjinQualCheckListDto inspectList : kwangjinQualCheckListDto.getUpdateInspectList()){
				kwangjinQualCheckListMapper.updateCheckList(inspectList);
			}
		if(!kwangjinQualCheckListDto.getCurrentMenuId().equals(null) && kwangjinQualCheckListDto.getCurrentMenuId().equals("shipPectMgt")) {
			//출하검사 - 출하정보의 검사 상태를 검사 완료로 변경
			KwangjinShipPlanMgtDto shipPlanMgtDto = new KwangjinShipPlanMgtDto();
			shipPlanMgtDto.setShipPlanId(kwangjinQualCheckListDto.getTargetId());
			shipPlanMgtDto.setUpdatorId(JteUtils.getUserId());
			shipPlanMgtDto.setShipInspect(kwangjinQualCheckListDto.getShipInspect());
			
			kwangjinShipPlanMgtMapper.updateShipInspect(shipPlanMgtDto);
			}		
		
		} catch (Exception e) {
			throw new BusinessException("insertInspectList : " + e.getMessage());
		}
	}
}
