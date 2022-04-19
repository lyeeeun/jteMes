package jin.mes.form.qualMgt.specProcMgt;

import java.util.ArrayList;
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
public class SpecProcMgtService {
	@Resource
	SpecProcMgtMapper specProcMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	public PageInfo<SpecProcMgtDto> getSpcList(SpecProcMgtDto specProcMgtDto, PageRequestVo pageRequestVo){
		List<SpecProcMgtDto> spcList = null;
		int rowCount = 0;
		
		// Page Setting
		specProcMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		specProcMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = specProcMgtMapper.selectSpcCount(specProcMgtDto);
			if (rowCount > 0) {
				//List
				spcList = specProcMgtMapper.selectSpcList(specProcMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("조회 에러입니다. : " + e.getMessage());
		}
		if (spcList == null) {
			spcList = new ArrayList<SpecProcMgtDto>();
		}
		return new PageInfo<SpecProcMgtDto>(spcList, pageRequestVo, rowCount);
	}
	
	//spc 정보 입력/수정
		@Transactional
		public String setSpcSave(SpecProcMgtDto SpecProcMgtDto){
			String returnKey = "";
			try {
				SpecProcMgtDto.setCreatorId(JteUtils.getUserId());
				SpecProcMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(SpecProcMgtDto.getAction().equals("C")) {//
					//spc 입력
					specProcMgtMapper.insertSpcInfo(SpecProcMgtDto);
					returnKey = SpecProcMgtDto.getSpcId();
					//다국어 저장
					if(SpecProcMgtDto.getMsgList() != null && SpecProcMgtDto.getMsgList().size() > 0) {
						msgService.pgSaveMsg(SpecProcMgtDto.getMsgList(), "spc", returnKey);
					}
					//첨부파일 저장
					if(SpecProcMgtDto.getInsertAttach() != null && SpecProcMgtDto.getInsertAttach().size() > 0) {
						String target = SpecProcMgtDto.getCurrentMenuId();
						String targetCode = returnKey;
						attachMgtService.attachFilesSave(SpecProcMgtDto.getInsertAttach(), target, targetCode);
					}
					//첨부파일 삭제
					if(SpecProcMgtDto.getDeleteAttach() != null && SpecProcMgtDto.getDeleteAttach().size() > 0) {
						attachMgtService.attachFilesDelete(SpecProcMgtDto.getDeleteAttach());
					}
				}else if(SpecProcMgtDto.getAction().equals("U")){
					///spc 수정
					specProcMgtMapper.updateSpcInfo(SpecProcMgtDto);
					
					returnKey =SpecProcMgtDto.getSpcId();
					
					//다국어저장
					if(SpecProcMgtDto.getMsgList() != null && SpecProcMgtDto.getMsgList().size() > 0) {
						msgService.pgSaveMsg(SpecProcMgtDto.getMsgList(), "spc", returnKey);
					}
					//첨부파일 저장
					if(SpecProcMgtDto.getInsertAttach() != null && SpecProcMgtDto.getInsertAttach().size() > 0) {
						String target = SpecProcMgtDto.getCurrentMenuId();
						String targetCode = returnKey;
						attachMgtService.attachFilesSave(SpecProcMgtDto.getInsertAttach(), target, targetCode);
					}
					//첨부파일 삭제
					if(SpecProcMgtDto.getDeleteAttach() != null && SpecProcMgtDto.getDeleteAttach().size() > 0) {
						attachMgtService.attachFilesDelete(SpecProcMgtDto.getDeleteAttach());
					}
				}
			} catch (Exception e) {
				returnKey = "";
				throw new BusinessException("spc 정보 저장 에러  : " + e.getMessage());
			}
			return returnKey;
		}
		
	//spc 정보 삭제
	@Transactional
	public int setSpcDelete(List<SpecProcMgtDto> spcList) {
		int resultInt = -1;
		try {
			//spc 삭제
			for(SpecProcMgtDto spcDto : spcList) {
				specProcMgtMapper.deleteSpcInfo(spcDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("spc 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//spc 팀원 조회
	public PageInfo<SpecProcUserDto> getSpcUserList(SpecProcUserDto specProcUserDto, PageRequestVo pageRequestVo){
		List<SpecProcUserDto> spcUserList = null;
		int rowCount = 0;
		
		// Page Setting
		specProcUserDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		specProcUserDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = specProcMgtMapper.selectSpcUserCount(specProcUserDto);
			if (rowCount > 0) {
				//List
				spcUserList = specProcMgtMapper.selectSpcUserList(specProcUserDto);
			}
		} catch (Exception e) {
			throw new BusinessException("조회 에러입니다. : " + e.getMessage());
		}
		if (spcUserList == null) {
			spcUserList = new ArrayList<SpecProcUserDto>();
		}
		return new PageInfo<SpecProcUserDto>(spcUserList, pageRequestVo, rowCount);
	}
	
	//spc 팀원 정보 입력/수정
	@Transactional
	public String setSpcUserSave(SpecProcUserDto specProcUserDto){
		String returnKey = ""; 
		try {
			
			if(specProcUserDto.getAction().equals("C")) {//
				//spc 입력
				specProcMgtMapper.insertSpcUser(specProcUserDto);
				returnKey = specProcUserDto.getUserId();
				//다국어 저장
				if(specProcUserDto.getMsgList() != null && specProcUserDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(specProcUserDto.getMsgList(), "spc", returnKey);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("spc 팀원 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//spc 팀원 삭제
		@Transactional
		public int setSpcUserDelete(List<SpecProcUserDto> spcUserList) {
			int resultInt = -1;
			try {
				//spc 삭제
				for(SpecProcUserDto spcDto : spcUserList) {
					specProcMgtMapper.deleteSpcUser(spcDto);
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("spc 팀원 삭제 에러  : " + e.getMessage());
			}
			return resultInt;
		}
	
	
	
	public List<SpecProcMgtDto> getAllSpcList (SpecProcMgtDto specProcMgtDto) {
		List<SpecProcMgtDto> spcList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = specProcMgtMapper.selectSpcCount(specProcMgtDto);
			if (rowCount > 0) {
				//List
				spcList = specProcMgtMapper.selectAllSpcList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllSpcList Error  : " + e.getMessage());
		}
		if (spcList == null) {
			spcList = new ArrayList<SpecProcMgtDto>();
		}
		
		return spcList;
	}
}


