package jin.mes.form.qualMgt.qualPec.finalQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.qualMgt.qualPec.finalQualMgt.FinalQualMgtDto;
import jin.mes.mapper.qualMgt.qualPec.finalQualMgt.FinalQualMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class FinalQualMgtService {

	@Resource
	FinalQualMgtMapper finalQualMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 입고검사 조회
	public PageInfo<FinalQualMgtDto> getFinalQualList(FinalQualMgtDto finalQualMgtDto, PageRequestVo pageRequestVo) {
		List<FinalQualMgtDto> finalQualList = null;
		int rowCount = 0;

		// Page Setting
		finalQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		finalQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = finalQualMgtMapper.selectFinalQualCount(finalQualMgtDto);
			if (rowCount > 0) {
				// List
				finalQualList = finalQualMgtMapper.selectFinalQualList(finalQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (finalQualList == null) {
			finalQualList = new ArrayList<FinalQualMgtDto>();
		}
		return new PageInfo<FinalQualMgtDto>(finalQualList, pageRequestVo, rowCount);
	}
}
