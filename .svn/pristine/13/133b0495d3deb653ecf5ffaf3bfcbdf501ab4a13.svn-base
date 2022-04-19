package jin.mes.cform.facilMgt.facilCorMgt;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewFacilCorMgtService {

	@Resource
	NewFacilCorMgtMapper newFacilCorMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//설비정비이력 조회
	public PageInfo<NewFacilCorMgtDto> getEqmtMtncList(NewFacilCorMgtDto newEqmtMgtDto, PageRequestVo pageRequestVo){
		List<NewFacilCorMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		newEqmtMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newEqmtMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newFacilCorMgtMapper.selectEqmtMtncCount(newEqmtMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = newFacilCorMgtMapper.selectEqmtMtncList(newEqmtMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilCorMgtDto>();
		}
		return new PageInfo<NewFacilCorMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비 정비이력 입력/수정
	@Transactional
	public String setEqmtMtncSave(NewFacilCorMgtDto newEqmtMgtDto){
		String returnKey = "";
		try {
			newEqmtMgtDto.setCreatorId(JteUtils.getUserId());
			newEqmtMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(newEqmtMgtDto.getAction().equals("C")) {//설비정비이력  등록
				
				//설비정비이력 입력
				newFacilCorMgtMapper.insertEqmtMtnc(newEqmtMgtDto);
				
				returnKey = newEqmtMgtDto.getEqmtMtncId();
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				//입고일 시간 세팅
				cal.setTime(df.parse(newEqmtMgtDto.getEqmtMtncEnd()));
				//입고일 + 정비기간(설비마스터 정보)
				cal.add(Calendar.DATE, newEqmtMgtDto.getEqmtMaintenance());
				//검증일 세팅
				newEqmtMgtDto.setEqmtMgtVerif(df.format(cal.getTime()));
				
				newFacilCorMgtMapper.updateEqmtMgt(newEqmtMgtDto);
				
			}else if(newEqmtMgtDto.getAction().equals("U")){//설비정비이력  수정
				//설비정비이력 수정
				newFacilCorMgtMapper.updateEqmtMtnc(newEqmtMgtDto);
				
				returnKey = newEqmtMgtDto.getEqmtMtncId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비정비이력  입력 에러 : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//설비정비이력 삭제
	@Transactional
	public int setEqmtMtncDelete(List<NewFacilCorMgtDto> eqmtMgtList){
		int resultInt = -1;
		try {
			//설비정비이력 삭제
			for(NewFacilCorMgtDto newEqmtMgtDto : eqmtMgtList){
				newFacilCorMgtMapper.deleteEqmtMtnc(newEqmtMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비정비이력  삭제 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}
	
	//설비가동시간 조회
	public PageInfo<NewFacilCorMgtDto> getEqmtWorkList(NewFacilCorMgtDto newEqmtMgtDto, PageRequestVo pageRequestVo){
		List<NewFacilCorMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		newEqmtMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newEqmtMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newFacilCorMgtMapper.selectEqmtWorkCount(newEqmtMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = newFacilCorMgtMapper.selectEqmtWorkList(newEqmtMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비가동시간 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<NewFacilCorMgtDto>();
		}
		return new PageInfo<NewFacilCorMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비종합효율 조회
	public NewFacilCorMgtDto getEqmtOverall(NewFacilCorMgtDto newEqmtMgtDto){
		NewFacilCorMgtDto rtnEqmtMgt = null;
		try {
			rtnEqmtMgt = newFacilCorMgtMapper.selectEqmtOverall(newEqmtMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비종합효율 조회 에러입니다. : " + e.getMessage());
		}
		if (rtnEqmtMgt == null) {
			rtnEqmtMgt = new NewFacilCorMgtDto();
		}
		return rtnEqmtMgt;
	}
}
