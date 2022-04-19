package jin.mes.cform.basMgt.operMgt.toolMgt;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.basMgt.operMgt.compMgt.ZinixCompMgtDto;
import jin.mes.cform.orderMgt.orderDetailMgt.ZinixLotInfoDto;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixToolMgtService {

	@Resource
	ZinixToolMgtMapper zinixToolMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<ZinixToolMgtDto> getToolInfoList(ZinixToolMgtDto toolMgtDto, PageRequestVo pageRequestVo){
		List<ZinixToolMgtDto> toolMgtList = null;
		
		int rowCount = 0;

		// Page Setting
		toolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixToolMgtMapper.selectToolInfoCount(toolMgtDto);
			if (rowCount > 0) {
				//List
				toolMgtList = zinixToolMgtMapper.selectToolInfoList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ZinixToolMgtDto>();
		}
		return new PageInfo<ZinixToolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	//공구정보 입력/수정
	@Transactional
	public String setToolInfoSave(ZinixToolMgtDto toolMgtDto){
		String returnKey = "";
		try {
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(toolMgtDto.getAction().equals("C")) {//
				//공구입력
				zinixToolMgtMapper.insertToolInfo(toolMgtDto);
				returnKey = toolMgtDto.getToolId();
				//다국어 저장
				if(toolMgtDto.getMsgList() != null && toolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(toolMgtDto.getMsgList(), "tool", returnKey);
				}
				
				setToolRtlCompSave(toolMgtDto);
				
				
			}else if(toolMgtDto.getAction().equals("U")){//공구 변경
				//공구수정
				zinixToolMgtMapper.updateToolInfo(toolMgtDto);
				
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
				zinixToolMgtMapper.updateToolInfo(toolMgtDto);
				
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
	public int setToolInfoDelete(List<ZinixToolMgtDto> toolMgtList){
		int resultInt = -1;
		try {
			//공구삭제
			for(ZinixToolMgtDto toolMgtDto : toolMgtList){
				zinixToolMgtMapper.deleteToolInfo(toolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//공구구매  업체조회
	public PageInfo<ZinixCompMgtDto> getToolRtlCompList(ZinixCompMgtDto compMgtDto, PageRequestVo pageRequestVo){
		List<ZinixCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		compMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		compMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixToolMgtMapper.selectToolRtlCompCount(compMgtDto);
			if (rowCount > 0) {
				//List
				compList = zinixToolMgtMapper.selectToolRtlCompList(compMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구구매 업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<ZinixCompMgtDto>();
		}
		return new PageInfo<ZinixCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	//수주정보 팝업조회(order-child)
	public ZinixToolMgtDto getOrderPop(ZinixToolMgtDto toolDto){
		ZinixToolMgtDto toolPop = null;
		
		try {
			
			toolPop = zinixToolMgtMapper.selectToolInfo(toolDto);
			
			//해당 수주에 포함된 Lot 정보 조회
			if(!toolPop.getToolId().equals(null)) {
				ZinixToolCompMgtDto toolCompDto = new ZinixToolCompMgtDto();
				toolCompDto.setToolId(toolPop.getToolId());
				toolPop.setChildCompMgtList(zinixToolMgtMapper.selectRtlCompChild(toolCompDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return toolPop;
	}
	
	//공구구매 업체 입력/수정
	@Transactional
	public String setToolRtlCompSave(ZinixToolMgtDto toolMgtDto){
		String returnKey = "";
		
		try {
			for(ZinixToolCompMgtDto toolCompMgtDto : toolMgtDto.getChildCompMgtList()) {
				toolCompMgtDto.setCreatorId(JteUtils.getUserId());
				toolCompMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(toolCompMgtDto.getAction().equals("C")) {//
					//공구입력
					toolCompMgtDto.setToolId(toolMgtDto.getToolId());
					zinixToolMgtMapper.insertToolRtlComp(toolCompMgtDto);
					returnKey = toolCompMgtDto.getCompId();
				}else if(toolCompMgtDto.getAction().equals("D")) {
					zinixToolMgtMapper.deleteToolRtlComp(toolCompMgtDto);
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
	public int setToolRtlCompDelete(List<ZinixCompMgtDto> compList){
		int resultInt = -1;
		try {
			//공구삭제
			for(ZinixCompMgtDto compDto : compList){
				//zinixToolMgtMapper.deleteToolRtlComp(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구구매 업체 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	

	public List<ZinixToolMgtDto> getAllToolInfoList(ZinixToolMgtDto toolMgtDto) {
		List<ZinixToolMgtDto> toolList = null;
		int rowCount = 0;
		
		try {
			rowCount = zinixToolMgtMapper.selectToolInfoCount(toolMgtDto);
			if (rowCount > 0) {
				toolList = zinixToolMgtMapper.selectAllToolInfo(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllToolInfoList Error : " + e.getMessage());
		}
		if (toolList == null) {
			toolList = new ArrayList<ZinixToolMgtDto>();
		}
		
		return toolList;
	}
}
