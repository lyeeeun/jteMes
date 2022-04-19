package jin.mes.form.tool.toolMainRecord;

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
public class ToolMainRecordService {

	@Resource
	ToolMainRecordMapper toolMainRecordMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 공구상세 조회
	public PageInfo<ToolMainRecordDto> getToolRecordList(ToolMainRecordDto toolMainRecordDto, PageRequestVo pageRequestVo) {
		List<ToolMainRecordDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		toolMainRecordDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMainRecordDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = toolMainRecordMapper.selectToolRecordCount(toolMainRecordDto);
			if (rowCount > 0) {
				// List
				toolMgtList = toolMainRecordMapper.selectToolRecordList(toolMainRecordDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ToolMainRecordDto>();
		}
		return new PageInfo<ToolMainRecordDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구정비이력 조회
	public PageInfo<ToolMainRecordDto> getToolMainRecordList(ToolMainRecordDto toolMainRecordDto, PageRequestVo pageRequestVo) {
		List<ToolMainRecordDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		toolMainRecordDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMainRecordDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = toolMainRecordMapper.selectToolMainRecordCount(toolMainRecordDto);
			if (rowCount > 0) {
				// List
				toolMgtList = toolMainRecordMapper.selectToolMainRecordList(toolMainRecordDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ToolMainRecordDto>();
		}
		return new PageInfo<ToolMainRecordDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구 정비이력 입력/수정
	@Transactional
	public String setToolMainRecordSave(ToolMainRecordDto toolMainRecordDto) {
		String returnKey = "";
		try {
			toolMainRecordDto.setCreatorId(JteUtils.getUserId());
			toolMainRecordDto.setUpdatorId(JteUtils.getUserId());

			if (toolMainRecordDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				toolMainRecordMapper.insertToolMainRecord(toolMainRecordDto);

				returnKey = toolMainRecordDto.getToolMtncId();

			} else if (toolMainRecordDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				toolMainRecordMapper.updateToolMainRecord(toolMainRecordDto);

				returnKey = toolMainRecordDto.getToolMtncId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구정비이력  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구정비이력 삭제
	@Transactional
	public int setToolMainRecordDelete(List<ToolMainRecordDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구정비이력 삭제
			for (ToolMainRecordDto toolMainRecordDto : toolMgtList) {
				toolMainRecordMapper.deleteToolMainRecord(toolMainRecordDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
}
