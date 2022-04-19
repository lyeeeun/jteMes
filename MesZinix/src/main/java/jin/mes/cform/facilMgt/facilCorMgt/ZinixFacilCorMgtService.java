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

import jin.mes.common.attach.AttachMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixFacilCorMgtService {

	@Resource
	ZinixFacilCorMgtMapper zinixFacilCorMgtMapper;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//설비정비이력 조회
	public PageInfo<ZinixFacilCorMgtDto> getEqmtMtncList(ZinixFacilCorMgtDto eqmtMgtDto, PageRequestVo pageRequestVo){
		List<ZinixFacilCorMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		eqmtMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		eqmtMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixFacilCorMgtMapper.selectEqmtMtncCount(eqmtMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = zinixFacilCorMgtMapper.selectEqmtMtncList(eqmtMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<ZinixFacilCorMgtDto>();
		}
		return new PageInfo<ZinixFacilCorMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비 정비이력 입력/수정
	@Transactional
	public String setEqmtMtncSave(ZinixFacilCorMgtDto eqmtMgtDto){
		String returnKey = "";
		try {
			eqmtMgtDto.setCreatorId(JteUtils.getUserId());
			eqmtMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(eqmtMgtDto.getAction().equals("C")) {//설비정비이력  등록
				
				//설비정비이력 입력
				zinixFacilCorMgtMapper.insertEqmtMtnc(eqmtMgtDto);
				
				returnKey = eqmtMgtDto.getEqmtMtncId();
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				//입고일 시간 세팅
				cal.setTime(df.parse(eqmtMgtDto.getEqmtMtncEnd()));
				//입고일 + 정비기간(설비마스터 정보)
				cal.add(Calendar.DATE, eqmtMgtDto.getEqmtMaintenance());
				//검증일 세팅
				eqmtMgtDto.setEqmtMgtVerif(df.format(cal.getTime()));
				
				zinixFacilCorMgtMapper.updateEqmtMgt(eqmtMgtDto);
				
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
			}else if(eqmtMgtDto.getAction().equals("U")){//설비정비이력  수정
				//설비정비이력 수정
				zinixFacilCorMgtMapper.updateEqmtMtnc(eqmtMgtDto);
				
				returnKey = eqmtMgtDto.getEqmtMtncId();
			
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
				
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("설비정비이력  입력 에러 : " + e.getMessage());
		}
		
		return returnKey;
	}
	
	//설비정비이력 삭제
	@Transactional
	public int setEqmtMtncDelete(List<ZinixFacilCorMgtDto> eqmtMgtList){
		int resultInt = -1;
		try {
			//설비정비이력 삭제
			for(ZinixFacilCorMgtDto eqmtMgtDto : eqmtMgtList){
				
				//
				//첨부파일 삭제
				attachMgtService.attachFilesDelete(eqmtMgtDto.getDeleteAttach());
				
				zinixFacilCorMgtMapper.deleteEqmtMtnc(eqmtMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비정비이력  삭제 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}
	
	//설비가동시간 조회
	public PageInfo<ZinixFacilCorMgtDto> getEqmtWorkList(ZinixFacilCorMgtDto eqmtMgtDto, PageRequestVo pageRequestVo){
		List<ZinixFacilCorMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		eqmtMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		eqmtMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixFacilCorMgtMapper.selectEqmtWorkCount(eqmtMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = zinixFacilCorMgtMapper.selectEqmtWorkList(eqmtMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비가동시간 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<ZinixFacilCorMgtDto>();
		}
		return new PageInfo<ZinixFacilCorMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비종합효율 조회
	public ZinixFacilCorMgtDto getEqmtOverall(ZinixFacilCorMgtDto eqmtMgtDto){
		ZinixFacilCorMgtDto rtnEqmtMgt = null;
		try {
			rtnEqmtMgt = zinixFacilCorMgtMapper.selectEqmtOverall(eqmtMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비종합효율 조회 에러입니다. : " + e.getMessage());
		}
		if (rtnEqmtMgt == null) {
			rtnEqmtMgt = new ZinixFacilCorMgtDto();
		}
		return rtnEqmtMgt;
	}
}
