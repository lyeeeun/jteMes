package jin.mes.cform.basMgt.operMgt.compMgt;

import java.util.ArrayList;
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
public class KwangjinCompMgtService {

	@Resource
	KwangjinCompMgtMapper kwangjinCompMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<KwangjinCompMgtDto> getCompList(KwangjinCompMgtDto kwangjinCompMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinCompMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinCompMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinCompMgtMapper.selectCompCount(kwangjinCompMgtDto);
			if (rowCount > 0) {
				//List
				compList = kwangjinCompMgtMapper.selectCompList(kwangjinCompMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("업체정보 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<KwangjinCompMgtDto>();
		}
		return new PageInfo<KwangjinCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	
	//업체 팝업 조회
	public KwangjinCompMgtDto getCompPop(KwangjinCompMgtDto kwangjinCompMgtDto){
		KwangjinCompMgtDto kwangjinCompDto = null;

		try {
			kwangjinCompDto = kwangjinCompMgtMapper.selectCompPop(kwangjinCompMgtDto);
			
			//해당 수주에 포함된 Lot 정보 조회
			if(!kwangjinCompDto.getCompId().equals(null)) {
				KwangjinCompAddrDto kwangjinCompAddrDto = new KwangjinCompAddrDto();
				kwangjinCompAddrDto.setCompId(kwangjinCompDto.getCompId());
				kwangjinCompDto.setChildAddrList(kwangjinCompMgtMapper.selectCompChild(kwangjinCompAddrDto));
			}
		} catch (Exception e) {
			throw new BusinessException("업체정보 조회 에러입니다. : " + e.getMessage());
		}
		return kwangjinCompDto;
	}
	
	//업체정보 입력/수정
	public String setCompSave(KwangjinCompMgtDto kwangjinCompMgtDto){
		String returnKey = "";
		try {
			kwangjinCompMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinCompMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinCompMgtDto.getAction().equals("C")) {
				//업체입력
				kwangjinCompMgtMapper.insertCompInfo(kwangjinCompMgtDto);
				returnKey = kwangjinCompMgtDto.getCompId();
				//다국어 저장
				if(kwangjinCompMgtDto.getMsgList() != null && kwangjinCompMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinCompMgtDto.getMsgList(), "comp", returnKey);
				}
				
				setCompChildSave(kwangjinCompMgtDto);
			}else if(kwangjinCompMgtDto.getAction().equals("U")){//업체 변경
				//업체수정
				kwangjinCompMgtMapper.updateCompInfo(kwangjinCompMgtDto);
				
				returnKey =kwangjinCompMgtDto.getCompId();
				
				//다국어 저장
				if(kwangjinCompMgtDto.getMsgList() != null && kwangjinCompMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinCompMgtDto.getMsgList(), "comp", returnKey);
				}
				
				setCompChildSave(kwangjinCompMgtDto);
			}else if(kwangjinCompMgtDto.getAction().equals("USE")){//업체 잠금/해제
				if(kwangjinCompMgtDto.isUse()) {
					kwangjinCompMgtDto.setUse(false);
				}else {
					kwangjinCompMgtDto.setUse(true);
				}
				//업체사용수정	
				kwangjinCompMgtMapper.updateCompInfo(kwangjinCompMgtDto);
				
				returnKey =kwangjinCompMgtDto.getCompId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("업체 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	
	//업체정보 삭제
	@Transactional
	public int setCompDelete(List<KwangjinCompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(KwangjinCompMgtDto compDto : compList){
				kwangjinCompMgtMapper.deleteCompInfo(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("업체 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//업체 상세주소 조회
	public PageInfo<KwangjinCompAddrDto> getCompAddrList(KwangjinCompAddrDto kwangjinCompAddrDto, PageRequestVo pageRequestVo){
		List<KwangjinCompAddrDto> compAddrList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinCompAddrDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinCompAddrDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinCompMgtMapper.selectCompAddrCount(kwangjinCompAddrDto);
			if (rowCount > 0) {
				//List
				compAddrList = kwangjinCompMgtMapper.selectCompAddrList(kwangjinCompAddrDto);
			}
		} catch (Exception e) {
			throw new BusinessException("업체 상세주소 에러입니다.  : " + e.getMessage());
		}
		if (compAddrList == null) {
			compAddrList = new ArrayList<KwangjinCompAddrDto>();
		}
		return new PageInfo<KwangjinCompAddrDto>(compAddrList, pageRequestVo, rowCount);
	}
	
	//업체 상세주소 저장
	@Transactional
	public String setCompChildSave(KwangjinCompMgtDto kwangjinCompMgtDto){
		String resultKey = "";
		try {
			for(KwangjinCompAddrDto kwangjinCompAddrDto : kwangjinCompMgtDto.getChildAddrList()) {
				kwangjinCompAddrDto.setCreatorId(JteUtils.getUserId());
				kwangjinCompAddrDto.setUpdatorId(JteUtils.getUserId());
				
				kwangjinCompAddrDto.setCompId(kwangjinCompMgtDto.getCompId());
				
				if(kwangjinCompAddrDto.getAction().equals("C")) {//
					//업체입력
					kwangjinCompMgtMapper.insertCompAddrInfo(kwangjinCompAddrDto);
					resultKey = kwangjinCompAddrDto.getCompAddrId();
					
					//다국어 저장
					if(kwangjinCompAddrDto.getMsgList() != null && kwangjinCompAddrDto.getMsgList().size() > 0) {
						msgService.pgSaveMsg(kwangjinCompAddrDto.getMsgList(), "compadr", resultKey);
					}
				}else if(kwangjinCompAddrDto.getAction().equals("U")){//업체 변경
					//업체수정
					kwangjinCompMgtMapper.updateCompAddrInfo(kwangjinCompAddrDto);
					resultKey = kwangjinCompAddrDto.getCompAddrId();
					//다국어 저장
					if(kwangjinCompAddrDto.getMsgList() != null && kwangjinCompAddrDto.getMsgList().size() > 0) {
						msgService.pgSaveMsg(kwangjinCompAddrDto.getMsgList(), "compadr", resultKey);
					}
				}else if(kwangjinCompAddrDto.getAction().equals("D")){//업체 잠금/해제
					//업체사용삭제
					kwangjinCompMgtMapper.deleteCompAddrInfo(kwangjinCompAddrDto);
					resultKey = kwangjinCompAddrDto.getCompAddrId();
				}
			}
		} catch (Exception e) {
			resultKey ="";
			throw new BusinessException("업체 상세정보 저장 에러  : " + e.getMessage());
		}
		return resultKey;
	}
	
	//업체 상세주소 저장
	@Transactional
	public String setCompAddrSave(KwangjinCompAddrDto kwangjinCompAddrDto){
		
		String resultKey = "";
		try {
			kwangjinCompAddrDto.setCreatorId(JteUtils.getUserId());
			kwangjinCompAddrDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinCompAddrDto.getAction().equals("C")) {//
				//업체입력
				kwangjinCompMgtMapper.insertCompAddrInfo(kwangjinCompAddrDto);
				resultKey = kwangjinCompAddrDto.getCompAddrId();
				
				//다국어 저장
				if(kwangjinCompAddrDto.getMsgList() != null && kwangjinCompAddrDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinCompAddrDto.getMsgList(), "compadr", resultKey);
				}
			}else if(kwangjinCompAddrDto.getAction().equals("U")){//업체 변경
				//업체수정
				kwangjinCompMgtMapper.updateCompAddrInfo(kwangjinCompAddrDto);
				resultKey = kwangjinCompAddrDto.getCompAddrId();
				//다국어 저장
				if(kwangjinCompAddrDto.getMsgList() != null && kwangjinCompAddrDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinCompAddrDto.getMsgList(), "compadr", resultKey);
				}
			}else if(kwangjinCompAddrDto.getAction().equals("USE")){//업체 잠금/해제
				if(kwangjinCompAddrDto.isUse()) {
					kwangjinCompAddrDto.setUse(false);
				}else {
					kwangjinCompAddrDto.setUse(true);
				}
				//업체사용수정	
				kwangjinCompMgtMapper.updateCompAddrInfo(kwangjinCompAddrDto);
				resultKey = kwangjinCompAddrDto.getCompAddrId();
			}
		} catch (Exception e) {
			resultKey ="";
			throw new BusinessException("업체 상세정보 저장 에러  : " + e.getMessage());
		}
		return resultKey;
	}
	
	//업체 상세 주소 삭제
	@Transactional
	public int setCompAddrDelete(List<KwangjinCompAddrDto> compAddrList){
		int resultInt = -1;
		try {
			//업체삭제
			for(KwangjinCompAddrDto kwangjinCompAddrDto : compAddrList){
				kwangjinCompMgtMapper.deleteCompAddrInfo(kwangjinCompAddrDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("업체 상세정보 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}

	public List<KwangjinCompMgtDto> getAllCompList(KwangjinCompMgtDto kwangjinCompMgtDto) {
		List<KwangjinCompMgtDto> compList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = kwangjinCompMgtMapper.selectCompCount(kwangjinCompMgtDto);
			if (rowCount > 0) {
				//List
				compList = kwangjinCompMgtMapper.selectAllCompList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error  : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<KwangjinCompMgtDto>();
		}
		
		return compList;
	}
}
