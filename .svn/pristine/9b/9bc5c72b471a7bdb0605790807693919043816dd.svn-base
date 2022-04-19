package jin.mes.form.qualMgt.qualPec.inputQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.mapper.qualMgt.qualPec.inputQualMgt.InputQualMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class InputQualMgtService {

	@Resource
	InputQualMgtMapper inputQualMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 입고검사 조회
	public PageInfo<InputQualMgtDto> getInputQualList(InputQualMgtDto inputQualMgtDto, PageRequestVo pageRequestVo) {
		List<InputQualMgtDto> inputQualList = null;
		int rowCount = 0;

		// Page Setting
		inputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		inputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = inputQualMgtMapper.selectInputQualCount(inputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualList = inputQualMgtMapper.selectInputQualList(inputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (inputQualList == null) {
			inputQualList = new ArrayList<InputQualMgtDto>();
		}
		return new PageInfo<InputQualMgtDto>(inputQualList, pageRequestVo, rowCount);
	}
	
	// 입고검사 입력/수정
	@Transactional
	public String setInputQualSave(InputQualMgtDto inputQualMgtDto) {
		String returnKey = "";
		try {
			inputQualMgtDto.setCreatorId(JteUtils.getUserId());
			inputQualMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if (inputQualMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				inputQualMgtMapper.updateInputQualHold(inputQualMgtDto);
				
				returnKey = inputQualMgtDto.getMtrlOrderId();
				
			}else if (inputQualMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구상세 수정
				inputQualMgtMapper.updateInputQualPass(inputQualMgtDto);

				returnKey = inputQualMgtDto.getQcNum();

				// 다국어 저장
				if (inputQualMgtDto.getMsgList() != null && inputQualMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(inputQualMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}
	
	
	// 입고검사 상세 조회
	public PageInfo<InputQualMgtDto> getInputQualDetailList(InputQualMgtDto inputQualMgtDto, PageRequestVo pageRequestVo) {
		List<InputQualMgtDto> inputQualDetailList = null;
		int rowCount = 0;

		// Page Setting
		inputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		inputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = inputQualMgtMapper.selectInputQualDetailCount(inputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualDetailList = inputQualMgtMapper.selectInputQualDetailList(inputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (inputQualDetailList == null) {
			inputQualDetailList = new ArrayList<InputQualMgtDto>();
		}
		return new PageInfo<InputQualMgtDto>(inputQualDetailList, pageRequestVo, rowCount);
	}
	
	// 입고검사 상세 입력/수정
	@Transactional
	public String setInputQualDetailSave(InputQualMgtDto inputQualMgtDto) {
		String returnKey = "";
		try {
			inputQualMgtDto.setCreatorId(JteUtils.getUserId());
			inputQualMgtDto.setUpdatorId(JteUtils.getUserId());

			if (inputQualMgtDto.getAction().equals("C")) {// 공구상세 등록


				// 공구상세 입력
				inputQualMgtMapper.insertInputQualDetail(inputQualMgtDto);

				returnKey = inputQualMgtDto.getQcNum();

				// 다국어 저장
				if (inputQualMgtDto.getMsgList() != null && inputQualMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(inputQualMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			} else if (inputQualMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구상세 수정
				inputQualMgtMapper.updateInputQualDetail(inputQualMgtDto);
				
				inputQualMgtMapper.updateInputQualAddup(inputQualMgtDto);

				returnKey = inputQualMgtDto.getQcNum();

				// 다국어 저장
				if (inputQualMgtDto.getMsgList() != null && inputQualMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(inputQualMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	
	
	// 공구정비이력 조회
	public PageInfo<InputQualMgtDto> getInputQualAddList(InputQualMgtDto inputQualMgtDto, PageRequestVo pageRequestVo) {
		List<InputQualMgtDto> inputQualList = null;
		int rowCount = 0;

		// Page Setting
		inputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		inputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = inputQualMgtMapper.selectInputQualAddCount(inputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualList = inputQualMgtMapper.selectInputQualAddList(inputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (inputQualList == null) {
			inputQualList = new ArrayList<InputQualMgtDto>();
		}
		return new PageInfo<InputQualMgtDto>(inputQualList, pageRequestVo, rowCount);
	}

	// 공구 정비이력 입력/수정
	@Transactional
	public String setInputQualAddSave(InputQualMgtDto inputQualMgtDto) {
		String returnKey = "";
		try {
			inputQualMgtDto.setCreatorId(JteUtils.getUserId());
			inputQualMgtDto.setUpdatorId(JteUtils.getUserId());

			if (inputQualMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				inputQualMgtMapper.insertInputQualAdd(inputQualMgtDto);

				returnKey = inputQualMgtDto.getControlNo();

				inputQualMgtMapper.updateInputQualAdd(inputQualMgtDto);

			} else if (inputQualMgtDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				inputQualMgtMapper.updateInputQualAdd(inputQualMgtDto);
				

				returnKey = inputQualMgtDto.getControlNo();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("입고검사  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구정비이력 삭제
	@Transactional
	public int setInputQualAddDelete(List<InputQualMgtDto> inputQualList) {
		int resultInt = -1;
		try {
			// 공구정비이력 삭제
			for (InputQualMgtDto inputQualMgtDto : inputQualList) {
				inputQualMgtMapper.deleteInputQualAdd(inputQualMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
}
