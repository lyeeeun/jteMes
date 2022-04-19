package jin.mes.form.qualMgt.qualPec.inputQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.form.mtrl.mtrlMgt.MtrlHistoryDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class InputQualMgtService {
	@Resource
	InputQualMgtMapper inputQualMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<InputQualMgtDto> getMtrlOrderInputList(InputQualMgtDto inputQualMgtDto, PageRequestVo pageRequestVo){
		List<InputQualMgtDto> mtrlOrderInputList = null;
		int rowCount = 0;

		// Page Setting
		inputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		inputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = inputQualMgtMapper.selectMtrlOrderInputCount(inputQualMgtDto);
			if (rowCount > 0) {
				//List
				mtrlOrderInputList = inputQualMgtMapper.selectMtrlOrderInputList(inputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlOrderInputList == null) {
			mtrlOrderInputList = new ArrayList<InputQualMgtDto>();
		}
		return new PageInfo<InputQualMgtDto>(mtrlOrderInputList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<InputQualMgtDto> getMtrlOrderPlanInputList(InputQualMgtDto inputQualMgtDto, PageRequestVo pageRequestVo){
		List<InputQualMgtDto> mtrlOrderPlanInputList = null;
		int rowCount = 0;

		// Page Setting
		inputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		inputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = inputQualMgtMapper.selectMtrlOrderPlanInputCount(inputQualMgtDto);
			if (rowCount > 0) {
				//List
				mtrlOrderPlanInputList = inputQualMgtMapper.selectMtrlOrderPlanInputList(inputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주정보 조회 에러입니다. : " + e.getMessage());
		}
		if (mtrlOrderPlanInputList == null) {
			mtrlOrderPlanInputList = new ArrayList<InputQualMgtDto>();
		}
		return new PageInfo<InputQualMgtDto>(mtrlOrderPlanInputList, pageRequestVo, rowCount);
	}
	
	// 입고검사 입력/수정
	@Transactional
	public String setMtrlOrderPlanInputSave(InputQualMgtDto inputQualMgtDto) {
		String returnKey = "";
		try {
			inputQualMgtDto.setCreatorId(JteUtils.getUserId());
			inputQualMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if (inputQualMgtDto.getAction().equals("U")) {// 공구정비이력 등록

				inputQualMgtMapper.updateInputQualOmgt(inputQualMgtDto);
				
				returnKey = inputQualMgtDto.getMtrlOrderId();
				
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}
}
