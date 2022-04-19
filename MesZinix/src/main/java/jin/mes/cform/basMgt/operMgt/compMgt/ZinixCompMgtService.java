package jin.mes.cform.basMgt.operMgt.compMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixCompMgtService {

	@Resource
	ZinixCompMgtMapper zinixCompMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<ZinixCompMgtDto> getCompList(ZinixCompMgtDto compMgtDto, PageRequestVo pageRequestVo){
		List<ZinixCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		compMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixCompMgtMapper.selectCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = zinixCompMgtMapper.selectCompList(compMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("업체정보 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<ZinixCompMgtDto>();
		}
		return new PageInfo<ZinixCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	
	//업체 팝업 조회
	public ZinixCompMgtDto getCompPop(ZinixCompMgtDto compMgtDto){
		ZinixCompMgtDto compDto = null;

		try {
			compDto = zinixCompMgtMapper.selectCompPop(compMgtDto);
			
			//해당 수주에 포함된 Lot 정보 조회
			if(!compDto.getCompId().equals(null)) {
				ZinixCompAddrDto addrDto = new ZinixCompAddrDto();
				addrDto.setCompId(compDto.getCompId());
				compDto.setChildAddrList(zinixCompMgtMapper.selectCompChild(addrDto));
			}
		} catch (Exception e) {
			throw new BusinessException("업체정보 조회 에러입니다. : " + e.getMessage());
		}
		return compDto;
	}
	
	//업체정보 입력/수정
	public String setCompSave(ZinixCompMgtDto compMgtDto){
		String returnKey = "";
		try {
			compMgtDto.setCreatorId(JteUtils.getUserId());
			compMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(compMgtDto.getAction().equals("C")) {
				//업체입력
				zinixCompMgtMapper.insertCompInfo(compMgtDto);
				returnKey = compMgtDto.getCompId();
				//다국어 저장
				if(compMgtDto.getMsgList() != null && compMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(compMgtDto.getMsgList(), "comp", returnKey);
				}
				
				setCompChildSave(compMgtDto);
			}else if(compMgtDto.getAction().equals("U")){//업체 변경
				//업체수정
				zinixCompMgtMapper.updateCompInfo(compMgtDto);
				
				returnKey =compMgtDto.getCompId();
				
				//다국어 저장
				if(compMgtDto.getMsgList() != null && compMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(compMgtDto.getMsgList(), "comp", returnKey);
				}
				
				setCompChildSave(compMgtDto);
			}else if(compMgtDto.getAction().equals("USE")){//업체 잠금/해제
				if(compMgtDto.isUse()) {
					compMgtDto.setUse(false);
				}else {
					compMgtDto.setUse(true);
				}
				//업체사용수정	
				zinixCompMgtMapper.updateCompInfo(compMgtDto);
				
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
	public int setCompDelete(List<ZinixCompMgtDto> compList){
		int resultInt = -1;
		try {
			//업체삭제
			for(ZinixCompMgtDto compDto : compList){
				zinixCompMgtMapper.deleteCompInfo(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("업체 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//업체 상세주소 조회
	public PageInfo<ZinixCompAddrDto> getCompAddrList(ZinixCompAddrDto compAddrDto, PageRequestVo pageRequestVo){
		List<ZinixCompAddrDto> compAddrList = null;
		int rowCount = 0;

		// Page Setting
		compAddrDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compAddrDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixCompMgtMapper.selectCompAddrCount(compAddrDto);
			if (rowCount > 0) {
				//List
				compAddrList = zinixCompMgtMapper.selectCompAddrList(compAddrDto);
			}
		} catch (Exception e) {
			throw new BusinessException("업체 상세주소 에러입니다.  : " + e.getMessage());
		}
		if (compAddrList == null) {
			compAddrList = new ArrayList<ZinixCompAddrDto>();
		}
		return new PageInfo<ZinixCompAddrDto>(compAddrList, pageRequestVo, rowCount);
	}
	
	//업체 상세주소 저장
	@Transactional
	public String setCompChildSave(ZinixCompMgtDto compMgtDto){
		String resultKey = "";
		try {
			for(ZinixCompAddrDto compAddrDto : compMgtDto.getChildAddrList()) {
				compAddrDto.setCreatorId(JteUtils.getUserId());
				compAddrDto.setUpdatorId(JteUtils.getUserId());
				
				compAddrDto.setCompId(compMgtDto.getCompId());
				
				if(compAddrDto.getAction().equals("C")) {//
					//업체입력
					zinixCompMgtMapper.insertCompAddrInfo(compAddrDto);
					resultKey = compAddrDto.getCompAddrId();
					
					//다국어 저장
					if(compAddrDto.getMsgList() != null && compAddrDto.getMsgList().size() > 0) {
						msgService.pgSaveMsg(compAddrDto.getMsgList(), "compadr", resultKey);
					}
				}else if(compAddrDto.getAction().equals("U")){//업체 변경
					//업체수정
					zinixCompMgtMapper.updateCompAddrInfo(compAddrDto);
					resultKey = compAddrDto.getCompAddrId();
					//다국어 저장
					if(compAddrDto.getMsgList() != null && compAddrDto.getMsgList().size() > 0) {
						msgService.pgSaveMsg(compAddrDto.getMsgList(), "compadr", resultKey);
					}
				}else if(compAddrDto.getAction().equals("D")){//업체 잠금/해제
					//업체사용삭제
					zinixCompMgtMapper.deleteCompAddrInfo(compAddrDto);
					resultKey = compAddrDto.getCompAddrId();
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
	public String setCompAddrSave(ZinixCompAddrDto compAddrDto){
		
		String resultKey = "";
		try {
			compAddrDto.setCreatorId(JteUtils.getUserId());
			compAddrDto.setUpdatorId(JteUtils.getUserId());
			
			if(compAddrDto.getAction().equals("C")) {//
				//업체입력
				zinixCompMgtMapper.insertCompAddrInfo(compAddrDto);
				resultKey = compAddrDto.getCompAddrId();
				
				//다국어 저장
				if(compAddrDto.getMsgList() != null && compAddrDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(compAddrDto.getMsgList(), "compadr", resultKey);
				}
			}else if(compAddrDto.getAction().equals("U")){//업체 변경
				//업체수정
				zinixCompMgtMapper.updateCompAddrInfo(compAddrDto);
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
				zinixCompMgtMapper.updateCompAddrInfo(compAddrDto);
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
	public int setCompAddrDelete(List<ZinixCompAddrDto> compAddrList){
		int resultInt = -1;
		try {
			//업체삭제
			for(ZinixCompAddrDto compAddrDto : compAddrList){
				zinixCompMgtMapper.deleteCompAddrInfo(compAddrDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("업체 상세정보 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}

	public List<ZinixCompMgtDto> getAllCompList(ZinixCompMgtDto compMgtDto) {
		List<ZinixCompMgtDto> compList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = zinixCompMgtMapper.selectCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = zinixCompMgtMapper.selectAllCompList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error  : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<ZinixCompMgtDto>();
		}
		
		return compList;
	}
}
