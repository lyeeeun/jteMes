package jin.mes.form.basMgt.operMgt.toolMgt;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.basMgt.operMgt.compMgt.CompMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ToolMgtService {

	@Resource
	ToolMgtMapper toolMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<ToolMgtDto> getToolInfoList(ToolMgtDto toolMgtDto, PageRequestVo pageRequestVo){
		List<ToolMgtDto> toolMgtList = null;
		
		int rowCount = 0;

		// Page Setting
		toolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = toolMgtMapper.selectToolInfoCount(toolMgtDto);
			if (rowCount > 0) {
				//List
				toolMgtList = toolMgtMapper.selectToolInfoList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ToolMgtDto>();
		}
		return new PageInfo<ToolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	//공구정보 입력/수정
	@Transactional
	public String setToolInfoSave(ToolMgtDto toolMgtDto){
		String returnKey = "";
		try {
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(toolMgtDto.getAction().equals("C")) {//
				//공구입력
				toolMgtMapper.insertToolInfo(toolMgtDto);
				returnKey = toolMgtDto.getToolId();
				//다국어 저장
				if(toolMgtDto.getMsgList() != null && toolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(toolMgtDto.getMsgList(), "tool", returnKey);
				}
				
				setToolRtlCompSave(toolMgtDto);
				
				
			}else if(toolMgtDto.getAction().equals("U")){//공구 변경
				//공구수정
				toolMgtMapper.updateToolInfo(toolMgtDto);
				
				returnKey =toolMgtDto.getToolId();
				setToolRtlCompSave(toolMgtDto);
				
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
				toolMgtMapper.updateToolInfo(toolMgtDto);
				
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
	public int setToolInfoDelete(List<ToolMgtDto> toolMgtList){
		int resultInt = -1;
		try {
			//공구삭제
			for(ToolMgtDto toolMgtDto : toolMgtList){
				toolMgtMapper.deleteToolInfo(toolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//공구구매  업체조회
	public PageInfo<CompMgtDto> getToolRtlCompList(CompMgtDto compMgtDto, PageRequestVo pageRequestVo){
		List<CompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		compMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = toolMgtMapper.selectToolRtlCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = toolMgtMapper.selectToolRtlCompList(compMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구구매 업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<CompMgtDto>();
		}
		return new PageInfo<CompMgtDto>(compList, pageRequestVo, rowCount);
	}
	//수주정보 팝업조회(order-child)
	public ToolMgtDto getOrderPop(ToolMgtDto toolDto){
		ToolMgtDto toolPop = null;
		
		try {
			
			toolPop = toolMgtMapper.selectToolInfo(toolDto);
			
			//해당 수주에 포함된 Lot 정보 조회
			if(!toolPop.getToolId().equals(null)) {
				ToolCompMgtDto toolCompDto = new ToolCompMgtDto();
				toolCompDto.setToolId(toolPop.getToolId());
				toolPop.setChildCompMgtList(toolMgtMapper.selectRtlCompChild(toolCompDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return toolPop;
	}
	
	//공구구매 업체 입력/수정
	@Transactional
	public String setToolRtlCompSave(ToolMgtDto toolMgtDto){
		String returnKey = "";
		
		try {
			for(ToolCompMgtDto toolCompMgtDto : toolMgtDto.getChildCompMgtList()) {
				toolCompMgtDto.setCreatorId(JteUtils.getUserId());
				toolCompMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(toolCompMgtDto.getAction().equals("C")) {//
					//공구입력
					toolCompMgtDto.setToolId(toolMgtDto.getToolId());
					toolMgtMapper.insertToolRtlComp(toolCompMgtDto);
					returnKey = toolCompMgtDto.getCompId();
				}else if(toolCompMgtDto.getAction().equals("D")) {
					toolMgtMapper.deleteToolRtlComp(toolCompMgtDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구구매 업체 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구구매 업체삭제
	@Transactional
	public int setToolRtlCompDelete(List<CompMgtDto> compList){
		int resultInt = -1;
		try {
			//공구삭제
			for(CompMgtDto compDto : compList){
				//toolMgtMapper.deleteToolRtlComp(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구구매 업체 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	

	public List<ToolMgtDto> getAllToolInfoList(ToolMgtDto toolMgtDto) {
		List<ToolMgtDto> toolList = null;
		int rowCount = 0;
		
		try {
			rowCount = toolMgtMapper.selectToolInfoCount(toolMgtDto);
			if (rowCount > 0) {
				toolList = toolMgtMapper.selectAllToolInfo(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllToolInfoList Error : " + e.getMessage());
		}
		if (toolList == null) {
			toolList = new ArrayList<ToolMgtDto>();
		}
		
		return toolList;
	}
}
