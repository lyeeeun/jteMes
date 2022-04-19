package jin.mes.cform.basMgt.operMgt.toolMgt;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.basMgt.operMgt.compMgt.NewCompMgtDto;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewToolMgtService {

	@Resource
	NewToolMgtMapper newToolMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<NewToolMgtDto> getToolInfoList(NewToolMgtDto toolMgtDto, PageRequestVo pageRequestVo){
		List<NewToolMgtDto> toolMgtList = null;
		
		int rowCount = 0;

		// Page Setting
		toolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newToolMgtMapper.selectToolInfoCount(toolMgtDto);
			if (rowCount > 0) {
				//List
				toolMgtList = newToolMgtMapper.selectToolInfoList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<NewToolMgtDto>();
		}
		return new PageInfo<NewToolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	//공구정보 입력/수정
	@Transactional
	public String setToolInfoSave(NewToolMgtDto toolMgtDto){
		String returnKey = "";
		try {
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(toolMgtDto.getAction().equals("C")) {//
				//공구입력
				newToolMgtMapper.insertToolInfo(toolMgtDto);
				returnKey = toolMgtDto.getToolId();
				//다국어 저장
				if(toolMgtDto.getMsgList() != null && toolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(toolMgtDto.getMsgList(), "tool", returnKey);
				}
			}else if(toolMgtDto.getAction().equals("U")){//공구 변경
				//공구수정
				newToolMgtMapper.updateToolInfo(toolMgtDto);
				
				returnKey =toolMgtDto.getToolId();
				
				//다국어 저장
				if(toolMgtDto.getMsgList() != null && toolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(toolMgtDto.getMsgList(), "tool", returnKey);
				}
			}
			else if(toolMgtDto.getAction().equals("USE")){//공구 잠금/해제
				if(toolMgtDto.isUse()) {
					toolMgtDto.setUse(false);
				}else {
					toolMgtDto.setUse(true);
				}
				//공구사용수정	
				newToolMgtMapper.updateToolInfo(toolMgtDto);
				
				returnKey =toolMgtDto.getToolId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구정보 삭제
	@Transactional
	public int setToolInfoDelete(List<NewToolMgtDto> toolMgtList){
		int resultInt = -1;
		try {
			//공구삭제
			for(NewToolMgtDto toolMgtDto : toolMgtList){
				newToolMgtMapper.deleteToolInfo(toolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//공구구매  업체조회
	public PageInfo<NewCompMgtDto> getToolRtlCompList(NewCompMgtDto newCompMgtDto, PageRequestVo pageRequestVo){
		List<NewCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		newCompMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newCompMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = newToolMgtMapper.selectToolRtlCompCount(newCompMgtDto);
			if (rowCount > 0) {
				//List
				compList = newToolMgtMapper.selectToolRtlCompList(newCompMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구구매 업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<NewCompMgtDto>();
		}
		return new PageInfo<NewCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	
	//공구구매 업체 입력/수정
	@Transactional
	public String setToolRtlCompSave(NewCompMgtDto newCompMgtDto){
		String returnKey = "";
		try {
			newCompMgtDto.setCreatorId(JteUtils.getUserId());
			newCompMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(newCompMgtDto.getAction().equals("C")) {//
				//공구입력
				newToolMgtMapper.insertToolRtlComp(newCompMgtDto);
				returnKey = newCompMgtDto.getCompId();
			}
//			else if(newCompMgtDto.getAction().equals("U")){//공구 변경
//				//공구수정
//				newToolMgtMapper.updateCompInfo(newCompMgtDto);
//				
//				returnKey =newCompMgtDto.getCompId();
//				
//				//다국어 저장
//				if(newCompMgtDto.getMsgList() != null && newCompMgtDto.getMsgList().size() > 0) {
//					msgService.pgSaveMsg(newCompMgtDto.getMsgList(), "comp", returnKey);
//				}
//			}else if(newCompMgtDto.getAction().equals("USE")){//공구 잠금/해제
//				if(newCompMgtDto.isUse()) {
//					newCompMgtDto.setUse(false);
//				}else {
//					newCompMgtDto.setUse(true);
//				}
//				//공구사용수정	
//				newToolMgtMapper.updateCompInfo(newCompMgtDto);
//				
//				returnKey =newCompMgtDto.getCompId();
//			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구구매 업체 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구구매 업체삭제
	@Transactional
	public int setToolRtlCompDelete(List<NewCompMgtDto> compList){
		int resultInt = -1;
		try {
			//공구삭제
			for(NewCompMgtDto compDto : compList){
				newToolMgtMapper.deleteToolRtlComp(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구구매 업체 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	

	public List<NewToolMgtDto> getAllToolInfoList(NewToolMgtDto toolMgtDto) {
		List<NewToolMgtDto> toolList = null;
		int rowCount = 0;
		
		try {
			rowCount = newToolMgtMapper.selectToolInfoCount(toolMgtDto);
			if (rowCount > 0) {
				toolList = newToolMgtMapper.selectAllToolInfo(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllToolInfoList Error : " + e.getMessage());
		}
		if (toolList == null) {
			toolList = new ArrayList<NewToolMgtDto>();
		}
		
		return toolList;
	}
}
