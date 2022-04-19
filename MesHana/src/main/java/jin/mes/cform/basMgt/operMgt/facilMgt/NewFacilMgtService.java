package jin.mes.cform.basMgt.operMgt.facilMgt;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//@Profile("default")
//@Service("facilMgtService")
@Service
public class NewFacilMgtService {

	@Resource
	NewFacilMgtMapper newFacilMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	//설비상세 조회
	public PageInfo<NewFacilMgtDto> getEqmtMgtList(NewFacilMgtDto newEqmtMgtDto, PageRequestVo pageRequestVo){
		List<NewFacilMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		newEqmtMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newEqmtMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newFacilMgtMapper.selectEqmtMgtCount(newEqmtMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = newFacilMgtMapper.selectEqmtMgtList(newEqmtMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilMgtDto>();
		}
		return new PageInfo<NewFacilMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비상세 조회(ALL)
	public List<NewFacilMgtDto> getEqmtMgtListAll(NewFacilMgtDto newEqmtMgtDto){
		List<NewFacilMgtDto> eqmtMgtList = null;
		try {
			//List
			eqmtMgtList = newFacilMgtMapper.selectEqmtMgtListAll(newEqmtMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비상세 조회 에러입니다.(ALL) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비 상세 입력/수정
	@Transactional
	public String setEqmtMgtSave(NewFacilMgtDto newEqmtMgtDto){
		String returnKey = "";
		try {
			newEqmtMgtDto.setCreatorId(JteUtils.getUserId());
			newEqmtMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(newEqmtMgtDto.getAction().equals("C")) {//설비상세  등록
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				//검증기간이 null인 경우
				if(newEqmtMgtDto.getEqmtMgtVerif() == null ||newEqmtMgtDto.getEqmtMgtVerif().equals("")) {
					//입고일 시간 세팅
					cal.setTime(df.parse(newEqmtMgtDto.getEqmtMgtPurchase()));
					//입고일 + 정비기간(설비마스터 정보)
					cal.add(Calendar.DATE, newEqmtMgtDto.getEqmtMgtMtnc());
					//검증일 세팅
					newEqmtMgtDto.setEqmtMgtVerif(df.format(cal.getTime()));
				}
				
				//설비상세 입력
				newFacilMgtMapper.insertEqmtMgt(newEqmtMgtDto);
				
				returnKey = newEqmtMgtDto.getEqmtMgtId();
				
				//다국어 저장
				if(newEqmtMgtDto.getMsgList() != null && newEqmtMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newEqmtMgtDto.getMsgList(), "eqmgt", returnKey);
				}
				
				//첨부파일 저장
				if(newEqmtMgtDto.getInsertAttach() != null && newEqmtMgtDto.getInsertAttach().size() > 0) {
					String target = newEqmtMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(newEqmtMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(newEqmtMgtDto.getDeleteAttach() != null && newEqmtMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(newEqmtMgtDto.getDeleteAttach());
				}
			}else if(newEqmtMgtDto.getAction().equals("U")){//설비상세  수정
				//설비상세 수정
				newFacilMgtMapper.updateEqmtMgt(newEqmtMgtDto);
				
				returnKey = newEqmtMgtDto.getEqmtMgtId();
				
				//다국어 저장
				if(newEqmtMgtDto.getMsgList() != null && newEqmtMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newEqmtMgtDto.getMsgList(), "eqmgt", returnKey);
				}
				
				//첨부파일 저장
				if(newEqmtMgtDto.getInsertAttach() != null && newEqmtMgtDto.getInsertAttach().size() > 0) {
					String target = newEqmtMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(newEqmtMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(newEqmtMgtDto.getDeleteAttach() != null && newEqmtMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(newEqmtMgtDto.getDeleteAttach());
				}
			}else if(newEqmtMgtDto.getAction().equals("USE")){//설비상세  잠금/해제
				if(newEqmtMgtDto.isUse()) {
					newEqmtMgtDto.setUse(false);
				}else {
					newEqmtMgtDto.setUse(true);
				}
				
				//설비상세 잠금수정	
				newFacilMgtMapper.updateEqmtMgt(newEqmtMgtDto);
				
				returnKey = newEqmtMgtDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비상세  입력 에러 : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//설비상세 삭제
	@Transactional
	public int setEqmtMgtDelete(List<NewFacilMgtDto> eqmtMgtList){
		int resultInt = -1;
		try {
			//설비상세 삭제
			for(NewFacilMgtDto newEqmtMgtDto : eqmtMgtList){
				newFacilMgtMapper.deleteEqmtMgt(newEqmtMgtDto);
				
				//첨부파일 삭제
				if(newEqmtMgtDto.getDeleteAttach() != null && newEqmtMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(newEqmtMgtDto.getDeleteAttach());
				}
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비상세  삭제 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
}
