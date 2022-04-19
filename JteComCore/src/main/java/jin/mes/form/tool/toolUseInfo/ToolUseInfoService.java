package jin.mes.form.tool.toolUseInfo;

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
public class ToolUseInfoService {
	@Resource
	ToolUseInfoMapper toolUseInfoMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 공구상세 조회
	public PageInfo<ToolUseInfoDto> getToolUseList(ToolUseInfoDto toolUseInfoDto, PageRequestVo pageRequestVo) {
		List<ToolUseInfoDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		toolUseInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolUseInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = toolUseInfoMapper.selectToolUseCount(toolUseInfoDto);
			if (rowCount > 0) {
				// List
				toolMgtList = toolUseInfoMapper.selectToolUseList(toolUseInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ToolUseInfoDto>();
		}
		return new PageInfo<ToolUseInfoDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구사용정보 조회
	public PageInfo<ToolUseInfoDto> getToolUseInfoList(ToolUseInfoDto toolUseInfoDto, PageRequestVo pageRequestVo) {
		List<ToolUseInfoDto> toolMgtList = null;
		int rowCount = 0;

		toolUseInfoDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolUseInfoDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			// Count
			rowCount = toolUseInfoMapper.selectToolUseInfoCount(toolUseInfoDto);
			if (rowCount > 0) {
				// List
				toolMgtList = toolUseInfoMapper.selectToolUseInfoList(toolUseInfoDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ToolUseInfoDto>();
		}
		return new PageInfo<ToolUseInfoDto>(toolMgtList, pageRequestVo, rowCount);
	}
}
