package jin.mes.cform.qualMgt.qualPec.finalQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
//import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.qualMgt.qualPec.finalQualMgt.NewFinalQualMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class NewFinalQualMgtService {

	@Resource
	NewFinalQualMgtMapper newFinalQualMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 입고검사 조회
	public PageInfo<NewFinalQualMgtDto> getFinalQualList(NewFinalQualMgtDto newFinalQualMgtDto, PageRequestVo pageRequestVo) {
		List<NewFinalQualMgtDto> finalQualList = null;
		int rowCount = 0;

		// Page Setting
		newFinalQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newFinalQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newFinalQualMgtMapper.selectFinalQualCount(newFinalQualMgtDto);
			if (rowCount > 0) {
				// List
				finalQualList = newFinalQualMgtMapper.selectFinalQualList(newFinalQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (finalQualList == null) {
			finalQualList = new ArrayList<NewFinalQualMgtDto>();
		}
		return new PageInfo<NewFinalQualMgtDto>(finalQualList, pageRequestVo, rowCount);
	}
}
