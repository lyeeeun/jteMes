package jin.mes.cform.basMgt.operMgt.toolMgt;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.basMgt.operMgt.compMgt.KwangjinCompMgtDto;
import jin.mes.form.orderMgt.orderSheet.orderDetailMgt.LotInfoDto;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class KwangjinToolMgtService {

	@Resource
	KwangjinToolMgtMapper kwangjinToolMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<KwangjinToolMgtDto> getToolInfoList(KwangjinToolMgtDto kwangjinToolMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinToolMgtDto> toolMgtList = null;
		
		int rowCount = 0;

		// Page Setting
		kwangjinToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinToolMgtMapper.selectToolInfoCount(kwangjinToolMgtDto);
			if (rowCount > 0) {
				//List
				toolMgtList = kwangjinToolMgtMapper.selectToolInfoList(kwangjinToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<KwangjinToolMgtDto>();
		}
		return new PageInfo<KwangjinToolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	//공구정보 입력/수정
	@Transactional
	public String setToolInfoSave(KwangjinToolMgtDto kwangjinToolMgtDto){
		String returnKey = "";
		try {
			kwangjinToolMgtDto.setCreatorId(JteUtils.getUserId());
			kwangjinToolMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if(kwangjinToolMgtDto.getAction().equals("C")) {//
				//공구입력
				kwangjinToolMgtMapper.insertToolInfo(kwangjinToolMgtDto);
				returnKey = kwangjinToolMgtDto.getToolId();
				//다국어 저장
				if(kwangjinToolMgtDto.getMsgList() != null && kwangjinToolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinToolMgtDto.getMsgList(), "tool", returnKey);
				}
				
				setToolRtlCompSave(kwangjinToolMgtDto);
				
				
			}else if(kwangjinToolMgtDto.getAction().equals("U")){//공구 변경
				//공구수정
				kwangjinToolMgtMapper.updateToolInfo(kwangjinToolMgtDto);
				
				returnKey =kwangjinToolMgtDto.getToolId();
				setToolRtlCompSave(kwangjinToolMgtDto);
				
				//다국어 저장
				if(kwangjinToolMgtDto.getMsgList() != null && kwangjinToolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(kwangjinToolMgtDto.getMsgList(), "tool", returnKey);
				}
			}
			else if(kwangjinToolMgtDto.getAction().equals("USE")){//공구 잠금/해제
				if(kwangjinToolMgtDto.isUse()) {
					kwangjinToolMgtDto.setUse(false);
				}else {
					kwangjinToolMgtDto.setUse(true);
				}
				//공구사용수정	
				kwangjinToolMgtMapper.updateToolInfo(kwangjinToolMgtDto);
				
				returnKey =kwangjinToolMgtDto.getToolId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구 정보 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구정보 삭제
	@Transactional
	public int setToolInfoDelete(List<KwangjinToolMgtDto> toolMgtList){
		int resultInt = -1;
		try {
			//공구삭제
			for(KwangjinToolMgtDto kwangjinToolMgtDto : toolMgtList){
				kwangjinToolMgtMapper.deleteToolInfo(kwangjinToolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
	
	//공구구매  업체조회
	public PageInfo<KwangjinCompMgtDto> getToolRtlCompList(KwangjinCompMgtDto kwangjinCompMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinCompMgtDto> compList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinCompMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinCompMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinToolMgtMapper.selectToolRtlCompCount(kwangjinCompMgtDto);
			if (rowCount > 0) {
				//List
				compList = kwangjinToolMgtMapper.selectToolRtlCompList(kwangjinCompMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구구매 업체 조회 에러입니다. : " + e.getMessage());
		}
		if (compList == null) {
			compList = new ArrayList<KwangjinCompMgtDto>();
		}
		return new PageInfo<KwangjinCompMgtDto>(compList, pageRequestVo, rowCount);
	}
	//수주정보 팝업조회(order-child)
	public KwangjinToolMgtDto getOrderPop(KwangjinToolMgtDto toolDto){
		KwangjinToolMgtDto toolPop = null;
		
		try {
			
			toolPop = kwangjinToolMgtMapper.selectToolInfo(toolDto);
			
			//해당 수주에 포함된 Lot 정보 조회
			if(!toolPop.getToolId().equals(null)) {
				KwangjinToolCompMgtDto toolCompDto = new KwangjinToolCompMgtDto();
				toolCompDto.setToolId(toolPop.getToolId());
				toolPop.setChildCompMgtList(kwangjinToolMgtMapper.selectRtlCompChild(toolCompDto));
			}
		} catch (Exception e) {
			throw new BusinessException("수주팝업 조회 에러입니다. : " + e.getMessage());
		}
		return toolPop;
	}
	
	//공구구매 업체 입력/수정
	@Transactional
	public String setToolRtlCompSave(KwangjinToolMgtDto kwangjinToolMgtDto){
		String returnKey = "";
		
		try {
			for(KwangjinToolCompMgtDto kwangjinToolCompMgtDto : kwangjinToolMgtDto.getChildCompMgtList()) {
				kwangjinToolCompMgtDto.setCreatorId(JteUtils.getUserId());
				kwangjinToolCompMgtDto.setUpdatorId(JteUtils.getUserId());
				
				if(kwangjinToolCompMgtDto.getAction().equals("C")) {//
					//공구입력
					kwangjinToolCompMgtDto.setToolId(kwangjinToolMgtDto.getToolId());
					kwangjinToolMgtMapper.insertToolRtlComp(kwangjinToolCompMgtDto);
					returnKey = kwangjinToolCompMgtDto.getCompId();
				}else if(kwangjinToolCompMgtDto.getAction().equals("D")) {
					kwangjinToolMgtMapper.deleteToolRtlComp(kwangjinToolCompMgtDto);
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
	public int setToolRtlCompDelete(List<KwangjinCompMgtDto> compList){
		int resultInt = -1;
		try {
			//공구삭제
			for(KwangjinCompMgtDto kwangjinCompMgtDto : compList){
				//kwangjinToolMgtMapper.deleteToolRtlComp(compDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구구매 업체 삭제 에러 : " + e.getMessage());
		}
		return resultInt;
	}
	

	public List<KwangjinToolMgtDto> getAllToolInfoList(KwangjinToolMgtDto kwangjinToolMgtDto) {
		List<KwangjinToolMgtDto> toolList = null;
		int rowCount = 0;
		
		try {
			rowCount = kwangjinToolMgtMapper.selectToolInfoCount(kwangjinToolMgtDto);
			if (rowCount > 0) {
				toolList = kwangjinToolMgtMapper.selectAllToolInfo(kwangjinToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllToolInfoList Error : " + e.getMessage());
		}
		if (toolList == null) {
			toolList = new ArrayList<KwangjinToolMgtDto>();
		}
		
		return toolList;
	}
}
