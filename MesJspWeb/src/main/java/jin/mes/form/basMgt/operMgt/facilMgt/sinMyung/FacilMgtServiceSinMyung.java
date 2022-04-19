package jin.mes.form.basMgt.operMgt.facilMgt.sinMyung;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.basMgt.operMgt.facilMgt.FacilMgtDto;
import jin.mes.mapper.basMgt.operMgt.facilMgt.FacilMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

//@Profile("SinMyung")
//@Service("facilMgtServiceSinMyung")
//@Service
public class FacilMgtServiceSinMyung {

	@Resource
	FacilMgtMapper facilMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//설비상세 조회
	public PageInfo<FacilMgtDto> getEqmtMgtList(FacilMgtDto eqmtMgtDto, PageRequestVo pageRequestVo){
		List<FacilMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		eqmtMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		eqmtMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = facilMgtMapper.selectEqmtMgtCount(eqmtMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = facilMgtMapper.selectEqmtMgtList(eqmtMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비상세 조회 에러입니다.(List)  : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilMgtDto>();
		}
		return new PageInfo<FacilMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비상세 조회(ALL)
	public List<FacilMgtDto> getEqmtMgtListAll(FacilMgtDto eqmtMgtDto){
		List<FacilMgtDto> eqmtMgtList = null;
		try {
			//List
			eqmtMgtList = facilMgtMapper.selectEqmtMgtListAll(eqmtMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비상세 조회 에러입니다.(ALL) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<FacilMgtDto>();
		}
		return eqmtMgtList;
	}
	
	//설비 상세 입력/수정
	@Transactional
	public String setEqmtMgtSave(FacilMgtDto eqmtMgtDto){
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
				facilMgtMapper.insertEqmtMgt(eqmtMgtDto);
				
				returnKey = eqmtMgtDto.getEqmtMgtId();
				
				//다국어 저장
				if(eqmtMgtDto.getMsgList() != null && eqmtMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(eqmtMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}else if(eqmtMgtDto.getAction().equals("U")){//설비상세  수정
				//설비상세 수정
				facilMgtMapper.updateEqmtMgt(eqmtMgtDto);
				
				returnKey = eqmtMgtDto.getEqmtMgtId();
				
				//다국어 저장
				if(eqmtMgtDto.getMsgList() != null && eqmtMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(eqmtMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}else if(eqmtMgtDto.getAction().equals("USE")){//설비상세  잠금/해제
				if(eqmtMgtDto.isUse()) {
					eqmtMgtDto.setUse(false);
				}else {
					eqmtMgtDto.setUse(true);
				}
				//설비상세 잠금수정	
				facilMgtMapper.updateEqmtMgt(eqmtMgtDto);
				
				returnKey = eqmtMgtDto.getEqmtMgtId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비상세  입력 에러  : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//설비상세 삭제
	@Transactional
	public int setEqmtMgtDelete(List<FacilMgtDto> eqmtMgtList){
		int resultInt = -1;
		try {
			//설비상세 삭제
			for(FacilMgtDto eqmtMgtDto : eqmtMgtList){
				facilMgtMapper.deleteEqmtMgt(eqmtMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비상세  삭제 에러  : " + e.getMessage());
		}
		
		return resultInt;
	}
}
