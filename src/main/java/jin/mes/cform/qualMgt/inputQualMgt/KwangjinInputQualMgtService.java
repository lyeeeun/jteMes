package jin.mes.cform.qualMgt.inputQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.common.attach.AttachMgtService;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import jin.mes.form.mtrl.mtrlMgt.MtrlMgtService;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinInputQualMgtService {
	@Resource
	KwangjinInputQualMgtMapper kwangjinInputQualMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	MtrlMgtService mtrlMgtService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	//자재 불량 관리 조회
	public PageInfo<KwangjinInputQualMgtDto> getMtrlBadList(KwangjinInputQualMgtDto kwangjinInputQualMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinInputQualMgtDto> mtrlBadList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinInputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinInputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinInputQualMgtMapper.selectMtrlBadCount(kwangjinInputQualMgtDto);
			if (rowCount > 0) {
				//List
				mtrlBadList = kwangjinInputQualMgtMapper.selectMtrlBadList(kwangjinInputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재불량 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlBadList == null) {
			mtrlBadList = new ArrayList<KwangjinInputQualMgtDto>();
		}
		return new PageInfo<KwangjinInputQualMgtDto>(mtrlBadList, pageRequestVo, rowCount);
	}
		
	//자재 불량 관리 저장
	@Transactional
	public String setMtrlBadSave(KwangjinInputQualMgtDto kwangjinInputQualMgtDto){
		String returnKey = "";
		try {
			if(kwangjinInputQualMgtDto.getAction().equals("C")) {
				//불량관리 저장
				kwangjinInputQualMgtMapper.insertMtrlBad(kwangjinInputQualMgtDto);
				returnKey = kwangjinInputQualMgtDto.getBadId();
				
				//불량품 수량을 등록하기 위한 생성자
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto(kwangjinInputQualMgtDto.getMtrlId(), "mtrl_tagt03", returnKey,
						kwangjinInputQualMgtDto.getBadQty()*-1, kwangjinInputQualMgtDto.getChkDate(), kwangjinInputQualMgtDto.getChkUser() ,kwangjinInputQualMgtDto.getMtrlMgtId(), kwangjinInputQualMgtDto.getLotId());
				
				//불량히스토리를 등록하고 자재수량을 갱신
				mtrlCntDto.setAction("SUBTRACT");
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				
				//첨부파일 저장
				if(kwangjinInputQualMgtDto.getInsertAttach() != null && kwangjinInputQualMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinInputQualMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinInputQualMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinInputQualMgtDto.getDeleteAttach() != null && kwangjinInputQualMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinInputQualMgtDto.getDeleteAttach());
				}
				
			}else if(kwangjinInputQualMgtDto.getAction().equals("U")){
				//불량관리 저장
				kwangjinInputQualMgtMapper.updateMtrlBad(kwangjinInputQualMgtDto);
				returnKey =kwangjinInputQualMgtDto.getBadId();
				
				//불량품 수량을 수정하기 위한 생성자
				MtrlHistoryDto badCntDto = new MtrlHistoryDto(kwangjinInputQualMgtDto.getMtrlId(), "mtrl_tagt03", returnKey,
						kwangjinInputQualMgtDto.getBadQty()*-1, kwangjinInputQualMgtDto.getChkDate(), kwangjinInputQualMgtDto.getChkUser() ,kwangjinInputQualMgtDto.getMtrlMgtId(), kwangjinInputQualMgtDto.getLotId());
				
				
				//불량히스토리를 수정하고 자재수량을 갱신
				badCntDto.setAction("U");
				mtrlMgtService.setMtrlMgtPgSave(badCntDto);
				
				//첨부파일 저장
				if(kwangjinInputQualMgtDto.getInsertAttach() != null && kwangjinInputQualMgtDto.getInsertAttach().size() > 0) {
					String target = kwangjinInputQualMgtDto.getCurrentMenuId();
					String targetCode = returnKey;
					attachMgtService.attachFilesSave(kwangjinInputQualMgtDto.getInsertAttach(), target, targetCode);
				}
				//첨부파일 삭제
				if(kwangjinInputQualMgtDto.getDeleteAttach() != null && kwangjinInputQualMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinInputQualMgtDto.getDeleteAttach());
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("자재/품목 불량 저장 에러 : " + e.getMessage());
		}
		return returnKey;
	}
	
	//자재 불량 관리 삭제
	@Transactional
	public int setMtrlBadDelete(List<KwangjinInputQualMgtDto> mtrlBadList){
		int resultInt = -1;
		try {
			//불량관리 삭제
			for(KwangjinInputQualMgtDto kwangjinInputQualMgtDto : mtrlBadList){
				//불량품 수량을 삭제하기 위한 생성자
				kwangjinInputQualMgtMapper.deleteMtrlBad(kwangjinInputQualMgtDto);
				MtrlHistoryDto mtrlCntDto = new MtrlHistoryDto();
				mtrlCntDto.setMtrlMgtId(kwangjinInputQualMgtDto.getMtrlMgtId());
				mtrlCntDto.setMtrlQtyTarget("mtrl_tagt03");
				mtrlCntDto.setMtrlQtyTargetCode(kwangjinInputQualMgtDto.getBadId());
				
				//불량품 수량을 삭제하고 자재수량 갱신
				mtrlCntDto.setAction("D");
				mtrlMgtService.setMtrlMgtPgSave(mtrlCntDto);
				
				//첨부파일 삭제
				if(kwangjinInputQualMgtDto.getDeleteAttach() != null && kwangjinInputQualMgtDto.getDeleteAttach().size() > 0) {
					attachMgtService.attachFilesDelete(kwangjinInputQualMgtDto.getDeleteAttach());
				}
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("자재불량 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	
	public PageInfo<KwangjinInputQualMgtDto> getMtrlMgtHisList(KwangjinInputQualMgtDto kwangjinInputQualMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinInputQualMgtDto> mtrlMgtInputList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinInputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinInputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinInputQualMgtMapper.selectMtrlMgtHisCount(kwangjinInputQualMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtInputList = kwangjinInputQualMgtMapper.selectMtrlMgtHisList(kwangjinInputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재 입고 정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtInputList == null) {
			mtrlMgtInputList = new ArrayList<KwangjinInputQualMgtDto>();
		}
		return new PageInfo<KwangjinInputQualMgtDto>(mtrlMgtInputList, pageRequestVo, rowCount);
	}
	
	//자재 입고 관리 조회
	public PageInfo<KwangjinInputQualMgtDto> getMtrlMgtList(KwangjinInputQualMgtDto kwangjinInputQualMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinInputQualMgtDto> mtrlMgtInputList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinInputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinInputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinInputQualMgtMapper.selectMtrlMgtCount(kwangjinInputQualMgtDto);
			if (rowCount > 0) {
				//List
				mtrlMgtInputList = kwangjinInputQualMgtMapper.selectMtrlMgtList(kwangjinInputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("자재 입고 정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlMgtInputList == null) {
			mtrlMgtInputList = new ArrayList<KwangjinInputQualMgtDto>();
		}
		return new PageInfo<KwangjinInputQualMgtDto>(mtrlMgtInputList, pageRequestVo, rowCount);
	}
}
