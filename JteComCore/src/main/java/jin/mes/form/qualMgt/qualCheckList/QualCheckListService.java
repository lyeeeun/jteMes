package jin.mes.form.qualMgt.qualCheckList;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdcursitMgt.MtrlOdcursitMgtDto;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtDto;
import jin.mes.form.mtrl.mtrlOdMgt.mtrlOdplanMgt.MtrlOdplanMgtMapper;
import jin.mes.form.ship.shipMgt.ShipMgtDto;
import jin.mes.form.ship.shipMgt.ShipMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class QualCheckListService {

	@Resource
	QualCheckListMapper qualCheckListMapper;
	
	@Resource
	MtrlOdplanMgtMapper mtrlOdplanMgtMapper;
	
	@Resource
	ShipMgtMapper shipMgtMapper;
	
	@Transactional
	public PageInfo<QualCheckListDto> selectCheckListHistory(QualCheckListDto qualCheckListDto, PageRequestVo pageRequestVo) {
		List<QualCheckListDto> checkListHistory = null;
		int rowCount = 0;
	
		// Page Setting
		qualCheckListDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		qualCheckListDto.setLastIndex(pageRequestVo.getBlockLastPage());
	
		try {
			// Count
			rowCount = qualCheckListMapper.selectCheckListHistoryCount(qualCheckListDto);
			if (rowCount > 0) {
				// List
				checkListHistory = qualCheckListMapper.selectCheckListHistory(qualCheckListDto);
			}
		} catch (Exception e) {
			throw new BusinessException("체크리스트 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (checkListHistory == null) {
			checkListHistory = new ArrayList<QualCheckListDto>();
		}
		return new PageInfo<QualCheckListDto>(checkListHistory, pageRequestVo, rowCount);
	}

	@Transactional
	public List<QualCheckListDto> selectCheckList(QualCheckListDto qualCheckListDto){
		List<QualCheckListDto> checkListInfo = null;

		try {
			checkListInfo = qualCheckListMapper.selectCheckList(qualCheckListDto);
		} catch (Exception e) {
			throw new BusinessException("selectCheckList : " + e.getMessage());
		}
		
		return checkListInfo;
	}
	
	//체크리스트 신규 등록
	@Transactional
	public void insertCheckList(QualCheckListDto qualCheckListDto){
		try {
			
			String inspectId = qualCheckListMapper.selectInspectId();
			
			Date date = new Date(); 
			SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss"); 
			String inspectDate = simple.format(date);
			
			String inspectorId = JteUtils.getUserId();
			
			for(QualCheckListDto inspectList : qualCheckListDto.getInsertInspectList()){
				
				inspectList.setInspectId(inspectId);
				inspectList.setInspectDate(inspectDate);
				inspectList.setInspectorId(inspectorId);
				qualCheckListMapper.insertCheckList(inspectList);
			
				
			}
			
			//입고검사 - 발주계획의 검사 상태를 검사완료로 변경
			if(!qualCheckListDto.getCurrentMenuId().equals(null) && qualCheckListDto.getCurrentMenuId().equals("inputQualMgt")) {
				MtrlOdplanMgtDto mtrlOdplanMgtDto = new MtrlOdplanMgtDto();
				mtrlOdplanMgtDto.setUpdatorId(JteUtils.getUserId());
				mtrlOdplanMgtDto.setMtrlQualSta("inspecComplete");
				mtrlOdplanMgtDto.setMtrlOrderId(qualCheckListDto.getTargetId());

				mtrlOdplanMgtMapper.updateMtrlQualSta(mtrlOdplanMgtDto);
				
			}
			//출하검사 - 출하정보의 검사 상태를 검사 완료로 변경
			else if(!qualCheckListDto.getCurrentMenuId().equals(null) && qualCheckListDto.getCurrentMenuId().equals("shipPectMgt")) {
				ShipMgtDto shipMgtDto = new ShipMgtDto();
				shipMgtDto.setShipId(qualCheckListDto.getTargetId());
				shipMgtDto.setUpdatorId(JteUtils.getUserId());
				shipMgtDto.setShipInspect("shipInspectEnd");
				
				shipMgtMapper.updateShipInspect(shipMgtDto);
			}
				
		} catch (Exception e) {
			throw new BusinessException("insertCheckList : " + e.getMessage());
		}
	}
	
	//체크리스트 수정
	@Transactional
	public void updateCheckList(QualCheckListDto qualCheckListDto){
		try {
			for(QualCheckListDto inspectList : qualCheckListDto.getUpdateInspectList()){
				qualCheckListMapper.updateCheckList(inspectList);
			}
		} catch (Exception e) {
			throw new BusinessException("insertInspectList : " + e.getMessage());
		}
	}
}
