package jin.mes.cform.qualMgt.specProcMgt;

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
public class NewSpecProcMgtService {
	@Resource
	NewSpecProcMgtMapper newSpecProcMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	@Autowired
	AttachMgtService attachMgtService;
	
	public PageInfo<NewSpecProcMgtDto> getSpcList(NewSpecProcMgtDto specProcMgtDto, PageRequestVo pageRequestVo){
		List<NewSpecProcMgtDto> spcList = null;
		int rowCount = 0;
		
		// Page Setting
		specProcMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		specProcMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = newSpecProcMgtMapper.selectSpcCount(specProcMgtDto);
			if (rowCount > 0) {
				//List
				spcList = newSpecProcMgtMapper.selectSpcList(specProcMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("조회 에러입니다. : " + e.getMessage());
		}
		if (spcList == null) {
			spcList = new ArrayList<NewSpecProcMgtDto>();
		}
		return new PageInfo<NewSpecProcMgtDto>(spcList, pageRequestVo, rowCount);
	}
	
	//spc 정보 입력/수정
		@Transactional
		public String setSpcSave(NewSpecProcMgtDto SpecProcMgtDto){
			String returnKey = "";
			try {
				SpecProcMgtDto.setCreatorId(JteUtils.getUserId());
				SpecProcMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(SpecProcMgtDto.getAction().equals("C")) {//
					//spc 입력
					newSpecProcMgtMapper.insertSpcInfo(SpecProcMgtDto);
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
					newSpecProcMgtMapper.updateSpcInfo(SpecProcMgtDto);
					
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
	public int setSpcDelete(List<NewSpecProcMgtDto> spcList) {
		int resultInt = -1;
		try {
			//spc 삭제
			for(NewSpecProcMgtDto spcDto : spcList) {
				newSpecProcMgtMapper.deleteSpcInfo(spcDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("spc 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//spc 팀원 조회
	public PageInfo<NewSpecProcUserDto> getSpcUserList(NewSpecProcUserDto specProcUserDto, PageRequestVo pageRequestVo){
		List<NewSpecProcUserDto> spcUserList = null;
		int rowCount = 0;
		
		// Page Setting
		specProcUserDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		specProcUserDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			//Count
			rowCount = newSpecProcMgtMapper.selectSpcUserCount(specProcUserDto);
			if (rowCount > 0) {
				//List
				spcUserList = newSpecProcMgtMapper.selectSpcUserList(specProcUserDto);
			}
		} catch (Exception e) {
			throw new BusinessException("조회 에러입니다. : " + e.getMessage());
		}
		if (spcUserList == null) {
			spcUserList = new ArrayList<NewSpecProcUserDto>();
		}
		return new PageInfo<NewSpecProcUserDto>(spcUserList, pageRequestVo, rowCount);
	}
	
	//spc 팀원 정보 입력/수정
	@Transactional
	public String setSpcUserSave(NewSpecProcUserDto specProcUserDto){
		String returnKey = ""; 
		try {
			
			if(specProcUserDto.getAction().equals("C")) {//
				//spc 입력
				newSpecProcMgtMapper.insertSpcUser(specProcUserDto);
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
		public int setSpcUserDelete(List<NewSpecProcUserDto> spcUserList) {
			int resultInt = -1;
			try {
				//spc 삭제
				for(NewSpecProcUserDto spcDto : spcUserList) {
					newSpecProcMgtMapper.deleteSpcUser(spcDto);
				}
			} catch (Exception e) {
				resultInt = -1;
				throw new BusinessException("spc 팀원 삭제 에러  : " + e.getMessage());
			}
			return resultInt;
		}
	
	
	
	public List<NewSpecProcMgtDto> getAllSpcList (NewSpecProcMgtDto specProcMgtDto) {
		List<NewSpecProcMgtDto> spcList = null;
		int rowCount = 0;
		
		try {
			//Count
			rowCount = newSpecProcMgtMapper.selectSpcCount(specProcMgtDto);
			if (rowCount > 0) {
				//List
				spcList = newSpecProcMgtMapper.selectAllSpcList();
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllSpcList Error  : " + e.getMessage());
		}
		if (spcList == null) {
			spcList = new ArrayList<NewSpecProcMgtDto>();
		}
		
		return spcList;
	}
}


