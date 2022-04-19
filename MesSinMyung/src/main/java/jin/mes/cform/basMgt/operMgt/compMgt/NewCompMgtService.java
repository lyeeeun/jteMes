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
public class NewCompMgtService {

	@Resource
	NewCompMgtMapper newCompMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<NewCompMgtDto> getCompList(NewCompMgtDto newCompMgtDto, PageRequestVo pageRequestVo){
		List<NewCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		newCompMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newCompMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newCompMgtMapper.selectCompCount(newCompMgtDto);
			if (rowCount > 0) {
				//List
				compList = newCompMgtMapper.selectCompList(newCompMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("업체정보 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<NewCompMgtDto>();
		}
		return new PageInfo<NewCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	
	//업체정보 입력/수정
	@Transactional
	public String setCompSave(NewCompMgtDto newCompMgtDto){
		String returnKey = "";
		try {
			newCompMgtDto.setCreatorId(JteUtils.getUserId());
			newCompMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(newCompMgtDto.getAction().equals("C")) {//
				//업체입력
				newCompMgtMapper.insertCompInfo(newCompMgtDto);
				returnKey = newCompMgtDto.getCompId();
				//다국어 저장
				if(newCompMgtDto.getMsgList() != null && newCompMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newCompMgtDto.getMsgList(), "comp", returnKey);
				}
			}else if(newCompMgtDto.getAction().equals("U")){//업체 변경
				//업체수정
				newCompMgtMapper.updateCompInfo(newCompMgtDto);
				
				returnKey =newCompMgtDto.getCompId();
				
				//다국어 저장
				if(newCompMgtDto.getMsgList() != null && newCompMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newCompMgtDto.getMsgList(), "comp", returnKey);
				}
			}else if(newCompMgtDto.getAction().equals("USE")){//업체 잠금/해제
				if(newCompMgtDto.isUse()) {
					newCompMgtDto.setUse(false);
				}else {
					newCompMgtDto.setUse(true);
				}
				//업체사용수정	
				newCompMgtMapper.updateCompInfo(newCompMgtDto);
				
				returnKey =newCompMgtDto.getCompId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("업체 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//업체정보 삭제
	@Transactional
	public int setCompDelete(List<NewCompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(NewCompMgtDto compDto : compList){
				newCompMgtMapper.deleteCompInfo(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("업체 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//업체 상세주소 조회
	public PageInfo<NewCompAddrDto> getCompAddrList(NewCompAddrDto compAddrDto, PageRequestVo pageRequestVo){
		List<NewCompAddrDto> compAddrList = null;
		int rowCount = 0;

		// Page Setting
		compAddrDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compAddrDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newCompMgtMapper.selectCompAddrCount(compAddrDto);
			if (rowCount > 0) {
				//List
				compAddrList = newCompMgtMapper.selectCompAddrList(compAddrDto);
			}
		} catch (Exception e) {
			throw new BusinessException("업체 상세주소 에러입니다.  : " + e.getMessage());
		}
		if (compAddrList == null) {
			compAddrList = new ArrayList<NewCompAddrDto>();
		}
		return new PageInfo<NewCompAddrDto>(compAddrList, pageRequestVo, rowCount);
	}

	//업체 상세주소 저장
	@Transactional
	public String setCompAddrSave(NewCompAddrDto compAddrDto){
		
		String resultKey = "";
		try {
			compAddrDto.setCreatorId(JteUtils.getUserId());
			compAddrDto.setUpdatorId(JteUtils.getUserId());
			
			if(compAddrDto.getAction().equals("C")) {//
				//업체입력
				newCompMgtMapper.insertCompAddrInfo(compAddrDto);
				resultKey = compAddrDto.getCompAddrId();
				
				//다국어 저장
				if(compAddrDto.getMsgList() != null && compAddrDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(compAddrDto.getMsgList(), "compadr", resultKey);
				}
			}else if(compAddrDto.getAction().equals("U")){//업체 변경
				//업체수정
				newCompMgtMapper.updateCompAddrInfo(compAddrDto);
				resultKey = compAddrDto.getCompAddrId();
				//다국어 저장
				if(compAddrDto.getMsgList() != null && compAddrDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(compAddrDto.getMsgList(), "compadr", resultKey);
				}
			}else if(compAddrDto.getAction().equals("USE")){//업체 잠금/해제
				if(compAddrDto.isUse()) {
					compAddrDto.setUse(false);
				}else {
					compAddrDto.setUse(true);
				}
				//업체사용수정	
				newCompMgtMapper.updateCompAddrInfo(compAddrDto);
				resultKey = compAddrDto.getCompAddrId();
			}
		} catch (Exception e) {
			resultKey ="";
			throw new BusinessException("업체 상세정보 저장 에러  : " + e.getMessage());
		}
		return resultKey;
	}
	
	//업체 상세 주소 삭제
	@Transactional
	public int setCompAddrDelete(List<NewCompAddrDto> compAddrList){
		int resultInt = -1;
		try {
			//업체삭제
			for(NewCompAddrDto compAddrDto : compAddrList){
				newCompMgtMapper.deleteCompAddrInfo(compAddrDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("업체 상세정보 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}

	public List<NewCompMgtDto> getAllCompList(NewCompMgtDto newCompMgtDto) {
		List<NewCompMgtDto> compList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = newCompMgtMapper.selectCompCount(newCompMgtDto);
			if (rowCount > 0) {
				//List
				compList = newCompMgtMapper.selectAllCompList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error  : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<NewCompMgtDto>();
		}
		
		return compList;
	}
}
