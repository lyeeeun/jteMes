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
public class KwangjinFacilCorMgtService {

	@Resource
	KwangjinFacilCorMgtMapper kwangjinFacilCorMgtMapper;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	//설비정비이력 조회
	public PageInfo<KwangjinFacilCorMgtDto> getEqmtMtncList(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinFacilCorMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinFacilCorMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinFacilCorMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinFacilCorMgtMapper.selectEqmtMtncCount(kwangjinFacilCorMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = kwangjinFacilCorMgtMapper.selectEqmtMtncList(kwangjinFacilCorMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<KwangjinFacilCorMgtDto>();
		}
		return new PageInfo<KwangjinFacilCorMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비 정비이력 입력/수정
	@Transactional
	public String setEqmtMtncSave(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto){
		String returnKey = "";
		try {
			kwangjinFacilCorMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinFacilCorMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinFacilCorMgtDto.getAction().equals("C")) {//설비정비이력  등록
				
				//설비정비이력 입력
				kwangjinFacilCorMgtMapper.insertEqmtMtnc(kwangjinFacilCorMgtDto);
				
				returnKey = kwangjinFacilCorMgtDto.getEqmtMtncId();
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				//입고일 시간 세팅
				cal.setTime(df.parse(kwangjinFacilCorMgtDto.getEqmtMtncEnd()));
				//검증일 세팅
				kwangjinFacilCorMgtDto.setEqmtMgtVerif(df.format(cal.getTime()));

				//첨부파일 저장
				if(kwangjinFacilCorMgtDto.getInsertAttach() != null && kwangjinFacilCorMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinFacilCorMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinFacilCorMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinFacilCorMgtDto.getDeleteAttach() != null && kwangjinFacilCorMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinFacilCorMgtDto.getDeleteAttach());
				}
			}else if(kwangjinFacilCorMgtDto.getAction().equals("U")){//설비정비이력  수정
				//설비정비이력 수정
				kwangjinFacilCorMgtMapper.updateEqmtMtnc(kwangjinFacilCorMgtDto);
				
				returnKey = kwangjinFacilCorMgtDto.getEqmtMtncId();
			
				//첨부파일 저장
				if(kwangjinFacilCorMgtDto.getInsertAttach() != null && kwangjinFacilCorMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinFacilCorMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinFacilCorMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinFacilCorMgtDto.getDeleteAttach() != null && kwangjinFacilCorMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinFacilCorMgtDto.getDeleteAttach());
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
	public int setEqmtMtncDelete(List<KwangjinFacilCorMgtDto> eqmtMgtList){
		int resultInt = -1;
		try {
			//설비정비이력 삭제
			for(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto : eqmtMgtList){
				//첨부파일 삭제			
				if(kwangjinFacilCorMgtDto.getDeleteAttach() != null && kwangjinFacilCorMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinFacilCorMgtDto.getDeleteAttach());
				}			
				kwangjinFacilCorMgtMapper.deleteEqmtMtnc(kwangjinFacilCorMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("설비정비이력  삭제 에러 : " + e.getMessage());
		}
		
		return resultInt;
	}
	
	//설비가동시간 조회
	public PageInfo<KwangjinFacilCorMgtDto> getEqmtWorkList(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinFacilCorMgtDto> eqmtMgtList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinFacilCorMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinFacilCorMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinFacilCorMgtMapper.selectEqmtWorkCount(kwangjinFacilCorMgtDto);
			if (rowCount > 0) {
				//List
				eqmtMgtList = kwangjinFacilCorMgtMapper.selectEqmtWorkList(kwangjinFacilCorMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("설비가동시간 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (eqmtMgtList == null) {
			eqmtMgtList = new ArrayList<KwangjinFacilCorMgtDto>();
		}
		return new PageInfo<KwangjinFacilCorMgtDto>(eqmtMgtList, pageRequestVo, rowCount);
	}
	
	//설비종합효율 조회
	public KwangjinFacilCorMgtDto getEqmtOverall(KwangjinFacilCorMgtDto kwangjinFacilCorMgtDto){
		KwangjinFacilCorMgtDto rtnEqmtMgt = null;
		try {
			rtnEqmtMgt = kwangjinFacilCorMgtMapper.selectEqmtOverall(kwangjinFacilCorMgtDto);
		} catch (Exception e) {
			throw new BusinessException("설비종합효율 조회 에러입니다. : " + e.getMessage());
		}
		if (rtnEqmtMgt == null) {
			rtnEqmtMgt = new KwangjinFacilCorMgtDto();
		}
		return rtnEqmtMgt;
	}
}
