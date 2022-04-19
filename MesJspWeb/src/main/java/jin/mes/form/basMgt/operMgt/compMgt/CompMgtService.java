package jin.mes.form.basMgt.operMgt.compMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.mapper.basMgt.operMgt.compMgt.CompMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class CompMgtService {

	@Resource
	CompMgtMapper compMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<CompMgtDto> getCompList(CompMgtDto compMgtDto, PageRequestVo pageRequestVo){
		List<CompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		compMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = compMgtMapper.selectCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = compMgtMapper.selectCompList(compMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("업체정보 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<CompMgtDto>();
		}
		return new PageInfo<CompMgtDto>(compList, pageRequestVo, rowCount);
	}
	
	//업체정보 입력/수정
	@Transactional
	public String setCompSave(CompMgtDto compMgtDto){
		String returnKey = "";
		try {
			compMgtDto.setCreatorId(JteUtils.getUserId());
			compMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(compMgtDto.getAction().equals("C")) {//
				//업체입력
				compMgtMapper.insertCompInfo(compMgtDto);
				returnKey = compMgtDto.getCompId();
				//다국어 저장
				if(compMgtDto.getMsgList() != null && compMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(compMgtDto.getMsgList(), "comp", returnKey);
				}
			}else if(compMgtDto.getAction().equals("U")){//업체 변경
				//업체수정
				compMgtMapper.updateCompInfo(compMgtDto);
				
				returnKey =compMgtDto.getCompId();
				
				//다국어 저장
				if(compMgtDto.getMsgList() != null && compMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(compMgtDto.getMsgList(), "comp", returnKey);
				}
			}else if(compMgtDto.getAction().equals("USE")){//업체 잠금/해제
				if(compMgtDto.isUse()) {
					compMgtDto.setUse(false);
				}else {
					compMgtDto.setUse(true);
				}
				//업체사용수정	
				compMgtMapper.updateCompInfo(compMgtDto);
				
				returnKey =compMgtDto.getCompId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("업체 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//업체정보 삭제
	@Transactional
	public int setCompDelete(List<CompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(CompMgtDto compDto : compList){
				compMgtMapper.deleteCompInfo(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("업체 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//업체 상세주소 조회
	public PageInfo<CompAddrDto> getCompAddrList(CompAddrDto compAddrDto, PageRequestVo pageRequestVo){
		List<CompAddrDto> compAddrList = null;
		int rowCount = 0;

		// Page Setting
		compAddrDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compAddrDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = compMgtMapper.selectCompAddrCount(compAddrDto);
			if (rowCount > 0) {
				//List
				compAddrList = compMgtMapper.selectCompAddrList(compAddrDto);
			}
		} catch (Exception e) {
			throw new BusinessException("업체 상세주소 에러입니다.  : " + e.getMessage());
		}
		if (compAddrList == null) {
			compAddrList = new ArrayList<CompAddrDto>();
		}
		return new PageInfo<CompAddrDto>(compAddrList, pageRequestVo, rowCount);
	}

	//업체 상세주소 저장
	@Transactional
	public String setCompAddrSave(CompAddrDto compAddrDto){
		
		String resultKey = "";
		try {
			compAddrDto.setCreatorId(JteUtils.getUserId());
			compAddrDto.setUpdatorId(JteUtils.getUserId());
			
			if(compAddrDto.getAction().equals("C")) {//
				//업체입력
				compMgtMapper.insertCompAddrInfo(compAddrDto);
				resultKey = compAddrDto.getCompAddrId();
				
				//다국어 저장
				if(compAddrDto.getMsgList() != null && compAddrDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(compAddrDto.getMsgList(), "compadr", resultKey);
				}
			}else if(compAddrDto.getAction().equals("U")){//업체 변경
				//업체수정
				compMgtMapper.updateCompAddrInfo(compAddrDto);
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
				compMgtMapper.updateCompAddrInfo(compAddrDto);
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
	public int setCompAddrDelete(List<CompAddrDto> compAddrList){
		int resultInt = -1;
		try {
			//업체삭제
			for(CompAddrDto compAddrDto : compAddrList){
				compMgtMapper.deleteCompAddrInfo(compAddrDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("업체 상세정보 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}

	public List<CompMgtDto> getAllCompList(CompMgtDto compMgtDto) {
		List<CompMgtDto> compList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = compMgtMapper.selectCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = compMgtMapper.selectAllCompList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error  : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<CompMgtDto>();
		}
		
		return compList;
	}
}
