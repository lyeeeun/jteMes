package jin.mes.form.mtrl.toolVerifMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.tool.mtrltoolMgt.MtrltoolMgtDto;
import jin.mes.form.tool.mtrltoolMgt.MtrltoolMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ToolVerifService {

	@Resource
	MtrltoolMgtMapper mtrltoolMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 공구상세 조회
	public PageInfo<MtrltoolMgtDto> getToolMgtList(MtrltoolMgtDto toolMgtDto, PageRequestVo pageRequestVo) {
		List<MtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		toolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = mtrltoolMgtMapper.selectToolMgtCount(toolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = mtrltoolMgtMapper.selectToolMgtList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<MtrltoolMgtDto>();
		}
		return new PageInfo<MtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구정비이력 조회
	public PageInfo<MtrltoolMgtDto> getToolMtncList(MtrltoolMgtDto toolMgtDto, PageRequestVo pageRequestVo) {
		List<MtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		toolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = mtrltoolMgtMapper.selectToolMtncCount(toolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = mtrltoolMgtMapper.selectToolMtncList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<MtrltoolMgtDto>();
		}
		return new PageInfo<MtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구 정비이력 입력/수정
	@Transactional
	public String setToolMtncSave(MtrltoolMgtDto toolMgtDto) {
		String returnKey = "";
		try {
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());

			if (toolMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				mtrltoolMgtMapper.insertToolMtnc(toolMgtDto);

				returnKey = toolMgtDto.getToolMtncId();

//				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//				Calendar cal = Calendar.getInstance();
//				// 입고일 시간 세팅
//				cal.setTime(df.parse(toolMgtDto.getToolMtncEnd()));
//				// 입고일 + 정비기간(공구마스터 정보)
//				cal.add(Calendar.DATE, toolMgtDto.getToolMaintenance());
//				// 검증일 세팅
//				toolMgtDto.setToolMgtVerif(df.format(cal.getTime()));

				mtrltoolMgtMapper.updateToolMgt(toolMgtDto);

			} else if (toolMgtDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				mtrltoolMgtMapper.updateToolMtnc(toolMgtDto);

				returnKey = toolMgtDto.getToolMtncId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구정비이력  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구정비이력 삭제
	@Transactional
	public int setToolMtncDelete(List<MtrltoolMgtDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구정비이력 삭제
			for (MtrltoolMgtDto toolMgtDto : toolMgtList) {
				mtrltoolMgtMapper.deleteToolMtnc(toolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
}
