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
public class KwangjinFacilMgtService {

	@Resource
	KwangjinFacilMgtMapper kwangjinFacilMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	//설비상세 조회
	public PageInfo<KwangjinFacilMgtDto> getEqmtMgtList(KwangjinFacilMgtDto kwangjinFacilMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinFacilMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinFacilMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinFacilMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinFacilMgtMapper.selectEqmtMgtCount(kwangjinFacilMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = kwangjinFacilMgtMapper.selectEqmtMgtList(kwangjinFacilMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<KwangjinFacilMgtDto>();
		}
		return new PageInfo<KwangjinFacilMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비상세 조회(ALL)
	public List<KwangjinFacilMgtDto> getEqmtMgtListAll(KwangjinFacilMgtDto kwangjinFacilMgtDto){
		List<KwangjinFacilMgtDto> eqmtMgtList = null;
		try {
			//List
			eqmtMgtList = kwangjinFacilMgtMapper.selectEqmtMgtListAll(kwangjinFacilMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비상세 조회 에러입니다.(ALL) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<KwangjinFacilMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비 상세 입력/수정
	@Transactional
	public String setEqmtMgtSave(KwangjinFacilMgtDto kwangjinFacilMgtDto){
		String returnKey = "";
		try {
			kwangjinFacilMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinFacilMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinFacilMgtDto.getAction().equals("C")) {//설비상세  등록
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				//검증기간이 null인 경우
				if(kwangjinFacilMgtDto.getEqmtMgtVerif() == null ||kwangjinFacilMgtDto.getEqmtMgtVerif().equals("")) {
					//입고일 시간 세팅
					cal.setTime(df.parse(kwangjinFacilMgtDto.getEqmtMgtPurchase()));
					//입고일 + 정비기간(설비마스터 정보)
					cal.add(Calendar.DATE, kwangjinFacilMgtDto.getEqmtMgtMtnc());
					//검증일 세팅
					kwangjinFacilMgtDto.setEqmtMgtVerif(df.format(cal.getTime()));
				}
				
				//설비상세 입력
				kwangjinFacilMgtMapper.insertEqmtMgt(kwangjinFacilMgtDto);
				
				returnKey = kwangjinFacilMgtDto.getEqmtMgtId();
				
				//다국어 저장
				if(kwangjinFacilMgtDto.getMsgList() != null && kwangjinFacilMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinFacilMgtDto.getMsgList(), "eqmgt", returnKey);
				}
				
				//첨부파일 저장
				if(kwangjinFacilMgtDto.getInsertAttach() != null && kwangjinFacilMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinFacilMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinFacilMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinFacilMgtDto.getDeleteAttach() != null && kwangjinFacilMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinFacilMgtDto.getDeleteAttach());
				}
			}else if(kwangjinFacilMgtDto.getAction().equals("U")){//설비상세  수정
				//설비상세 수정
				kwangjinFacilMgtMapper.updateEqmtMgt(kwangjinFacilMgtDto);
				
				returnKey = kwangjinFacilMgtDto.getEqmtMgtId();
				
				//다국어 저장
				if(kwangjinFacilMgtDto.getMsgList() != null && kwangjinFacilMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinFacilMgtDto.getMsgList(), "eqmgt", returnKey);
				}
				
				//첨부파일 저장
				if(kwangjinFacilMgtDto.getInsertAttach() != null && kwangjinFacilMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinFacilMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinFacilMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinFacilMgtDto.getDeleteAttach() != null && kwangjinFacilMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinFacilMgtDto.getDeleteAttach());
				}
			}else if(kwangjinFacilMgtDto.getAction().equals("USE")){//설비상세  잠금/해제
				if(kwangjinFacilMgtDto.isUse()) {
					kwangjinFacilMgtDto.setUse(false);
				}else {
					kwangjinFacilMgtDto.setUse(true);
				}
				
				//설비상세 잠금수정	
				kwangjinFacilMgtMapper.updateEqmtMgt(kwangjinFacilMgtDto);
				
				returnKey = kwangjinFacilMgtDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비상세  입력 에러 : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//설비상세 삭제
	@Transactional
	public int setEqmtMgtDelete(List<KwangjinFacilMgtDto> eqmtMgtList){
		int resultInt = -1;
		try {
			//설비상세 삭제
			for(KwangjinFacilMgtDto kwangjinFacilMgtDto : eqmtMgtList){
				kwangjinFacilMgtMapper.deleteEqmtMgt(kwangjinFacilMgtDto);
				
				//첨부파일 삭제
				if(kwangjinFacilMgtDto.getDeleteAttach() != null && kwangjinFacilMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinFacilMgtDto.getDeleteAttach());
				}
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비상세  삭제 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
}
