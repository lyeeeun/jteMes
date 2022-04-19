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
public class ZinixFacilMgtService {

	@Resource
	ZinixFacilMgtMapper zinixFacilMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	//설비상세 조회
	public PageInfo<ZinixFacilMgtDto> getEqmtMgtList(ZinixFacilMgtDto eqmtMgtDto, PageRequestVo pageRequestVo){
		List<ZinixFacilMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		eqmtMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		eqmtMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixFacilMgtMapper.selectEqmtMgtCount(eqmtMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = zinixFacilMgtMapper.selectEqmtMgtList(eqmtMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<ZinixFacilMgtDto>();
		}
		return new PageInfo<ZinixFacilMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비상세 조회(ALL)
	public List<ZinixFacilMgtDto> getEqmtMgtListAll(ZinixFacilMgtDto eqmtMgtDto){
		List<ZinixFacilMgtDto> eqmtMgtList = null;
		try {
			//List
			eqmtMgtList = zinixFacilMgtMapper.selectEqmtMgtListAll(eqmtMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비상세 조회 에러입니다.(ALL) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<ZinixFacilMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비 상세 입력/수정
	@Transactional
	public String setEqmtMgtSave(ZinixFacilMgtDto eqmtMgtDto){
		String returnKey = "";
		try {
			eqmtMgtDto.setCreatorId(JteUtils.getUserId());
			eqmtMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(eqmtMgtDto.getAction().equals("C")) {//설비상세  등록
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				//검증기간이 null인 경우
				if(eqmtMgtDto.getEqmtMgtVerif() == null ||eqmtMgtDto.getEqmtMgtVerif().equals("")) {
					//입고일 시간 세팅
					cal.setTime(df.parse(eqmtMgtDto.getEqmtMgtPurchase()));
					//입고일 + 정비기간(설비마스터 정보)
					cal.add(Calendar.DATE, eqmtMgtDto.getEqmtMgtMtnc());
					//검증일 세팅
					eqmtMgtDto.setEqmtMgtVerif(df.format(cal.getTime()));
				}
				
				//설비상세 입력
				zinixFacilMgtMapper.insertEqmtMgt(eqmtMgtDto);
				
				returnKey = eqmtMgtDto.getEqmtMgtId();
				
				//다국어 저장
				if(eqmtMgtDto.getMsgList() != null && eqmtMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(eqmtMgtDto.getMsgList(), "eqmgt", returnKey);
				}
				
				//첨부파일 저장
				if(eqmtMgtDto.getInsertAttach() != null && eqmtMgtDto.getInsertAttach().size() > 0) {
					String target = eqmtMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(eqmtMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(eqmtMgtDto.getDeleteAttach() != null && eqmtMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(eqmtMgtDto.getDeleteAttach());
				}
			}else if(eqmtMgtDto.getAction().equals("U")){//설비상세  수정
				//설비상세 수정
				zinixFacilMgtMapper.updateEqmtMgt(eqmtMgtDto);
				
				returnKey = eqmtMgtDto.getEqmtMgtId();
				
				//다국어 저장
				if(eqmtMgtDto.getMsgList() != null && eqmtMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(eqmtMgtDto.getMsgList(), "eqmgt", returnKey);
				}
				
				//첨부파일 저장
				if(eqmtMgtDto.getInsertAttach() != null && eqmtMgtDto.getInsertAttach().size() > 0) {
					String target = eqmtMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(eqmtMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(eqmtMgtDto.getDeleteAttach() != null && eqmtMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(eqmtMgtDto.getDeleteAttach());
				}
			}else if(eqmtMgtDto.getAction().equals("USE")){//설비상세  잠금/해제
				if(eqmtMgtDto.isUse()) {
					eqmtMgtDto.setUse(false);
				}else {
					eqmtMgtDto.setUse(true);
				}
				
				//설비상세 잠금수정	
				zinixFacilMgtMapper.updateEqmtMgt(eqmtMgtDto);
				
				returnKey = eqmtMgtDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비상세  입력 에러 : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//설비상세 삭제
	@Transactional
	public int setEqmtMgtDelete(List<ZinixFacilMgtDto> eqmtMgtList){
		int resultInt = -1;
		try {
			//설비상세 삭제
			for(ZinixFacilMgtDto eqmtMgtDto : eqmtMgtList){
				zinixFacilMgtMapper.deleteEqmtMgt(eqmtMgtDto);
				
				//첨부파일 삭제
				if(eqmtMgtDto.getDeleteAttach() != null && eqmtMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(eqmtMgtDto.getDeleteAttach());
				}
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비상세  삭제 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
}
