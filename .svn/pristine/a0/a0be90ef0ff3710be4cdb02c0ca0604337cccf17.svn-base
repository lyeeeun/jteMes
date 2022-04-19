package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

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
public class ZinixInputQualMgtService {
	@Resource
	ZinixInputQualMgtMapper zinixInputQualMgtMapper;
	
	@Autowired
	MsgMgtServiceImpl msgService;
	
	public PageInfo<ZinixInputQualMgtDto> getMtrlOrderInputList(ZinixInputQualMgtDto zinixInputQualMgtDto, PageRequestVo pageRequestVo){
		List<ZinixInputQualMgtDto> zinixMtrlOrderInputList = null;
		int rowCount = 0;

		// Page Setting
		zinixInputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		zinixInputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixInputQualMgtMapper.selectMtrlOrderInputCount(zinixInputQualMgtDto);
			if (rowCount > 0) {
				//List
				zinixMtrlOrderInputList = zinixInputQualMgtMapper.selectMtrlOrderInputList(zinixInputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (zinixMtrlOrderInputList == null) {
			zinixMtrlOrderInputList = new ArrayList<ZinixInputQualMgtDto>();
		}
		return new PageInfo<ZinixInputQualMgtDto>(zinixMtrlOrderInputList, pageRequestVo, rowCount);
	}
	
	
	public PageInfo<ZinixInputQualMgtDto> getMtrlOrderPlanInputList(ZinixInputQualMgtDto zinixInputQualMgtDto, PageRequestVo pageRequestVo){
		List<ZinixInputQualMgtDto> zinixMtrlOrderPlanInputList = null;
		int rowCount = 0;

		// Page Setting
		zinixInputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		zinixInputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = zinixInputQualMgtMapper.selectMtrlOrderPlanInputCount(zinixInputQualMgtDto);
			if (rowCount > 0) {
				//List
				zinixMtrlOrderPlanInputList = zinixInputQualMgtMapper.selectMtrlOrderPlanInputList(zinixInputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주정보 조회 에러입니다. : " + e.getMessage());
		}
		if (zinixMtrlOrderPlanInputList == null) {
			zinixMtrlOrderPlanInputList = new ArrayList<ZinixInputQualMgtDto>();
		}
		return new PageInfo<ZinixInputQualMgtDto>(zinixMtrlOrderPlanInputList, pageRequestVo, rowCount);
	}
	
	// 입고검사 입력/수정
	@Transactional
	public String setMtrlOrderPlanInputSave(ZinixInputQualMgtDto zinixInputQualMgtDto) {
		String returnKey = "";
		try {
			zinixInputQualMgtDto.setCreatorId(JteUtils.getUserId());
			zinixInputQualMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if (zinixInputQualMgtDto.getAction().equals("U")) {// 공구정비이력 등록

				zinixInputQualMgtMapper.updateInputQualOmgt(zinixInputQualMgtDto);
				
				returnKey = zinixInputQualMgtDto.getMtrlOrderId();
				
			}
			
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}
}
