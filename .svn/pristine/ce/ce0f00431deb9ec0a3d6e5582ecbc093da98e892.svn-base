package jin.mes.cform.qualMgt.qualPec.inputQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import jin.mes.common.msg.MsgViewModel;
import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;
//import lombok.Data;

@Service
public class NewInputQualMgtService {

	@Resource
	NewInputQualMgtMapper newInputQualMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 공구상세 조회
	public PageInfo<NewInputQualMgtDto> getInputQualList(NewInputQualMgtDto inputQualMgtDto, PageRequestVo pageRequestVo) {
		List<NewInputQualMgtDto> inputQualList = null;
		int rowCount = 0;

		// Page Setting
		inputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		inputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newInputQualMgtMapper.selectInputQualCount(inputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualList = newInputQualMgtMapper.selectInputQualList(inputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (inputQualList == null) {
			inputQualList = new ArrayList<NewInputQualMgtDto>();
		}
		return new PageInfo<NewInputQualMgtDto>(inputQualList, pageRequestVo, rowCount);
	}
	
	// 공구상세 조회
	public PageInfo<NewInputQualMgtDto> getInputQualDetailList(NewInputQualMgtDto inputQualMgtDto, PageRequestVo pageRequestVo) {
		List<NewInputQualMgtDto> inputQualDetailList = null;
		int rowCount = 0;

		// Page Setting
		inputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		inputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newInputQualMgtMapper.selectInputQualDetailCount(inputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualDetailList = newInputQualMgtMapper.selectInputQualDetailList(inputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (inputQualDetailList == null) {
			inputQualDetailList = new ArrayList<NewInputQualMgtDto>();
		}
		return new PageInfo<NewInputQualMgtDto>(inputQualDetailList, pageRequestVo, rowCount);
	}

	// 공구 상세 입력/수정
	@Transactional
	public String setInputQualSave(NewInputQualMgtDto inputQualMgtDto) {
		String returnKey = "";
		try {
			inputQualMgtDto.setCreatorId(JteUtils.getUserId());
			inputQualMgtDto.setUpdatorId(JteUtils.getUserId());

			if (inputQualMgtDto.getAction().equals("C")) {// 공구상세 등록


				// 공구상세 입력
				newInputQualMgtMapper.insertInputQual(inputQualMgtDto);

				returnKey = inputQualMgtDto.getQcNum();

				// 다국어 저장
				if (inputQualMgtDto.getMsgList() != null && inputQualMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(inputQualMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			} else if (inputQualMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구상세 수정
				newInputQualMgtMapper.updateInputQual(inputQualMgtDto);

				returnKey = inputQualMgtDto.getQcNum();

				// 다국어 저장
				if (inputQualMgtDto.getMsgList() != null && inputQualMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(inputQualMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}else if(inputQualMgtDto.getAction().equals("D")) {//공구 폐기처분
				
				newInputQualMgtMapper.updateInputQualIsDel(inputQualMgtDto);
				returnKey = inputQualMgtDto.getQcNum();
			}

		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구상세 삭제
	@Transactional
	public int setInputQualDelete(List<NewInputQualMgtDto> inputQualList) {
		int resultInt = -1;
		try {
			// 공구상세 삭제
			for (NewInputQualMgtDto inputQualMgtDto : inputQualList) {
				newInputQualMgtMapper.deleteInputQual(inputQualMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구상세  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

	// 공구정비이력 조회
	public PageInfo<NewInputQualMgtDto> getInputQualAddList(NewInputQualMgtDto inputQualMgtDto, PageRequestVo pageRequestVo) {
		List<NewInputQualMgtDto> inputQualList = null;
		int rowCount = 0;

		// Page Setting
		inputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		inputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newInputQualMgtMapper.selectInputQualAddCount(inputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualList = newInputQualMgtMapper.selectInputQualAddList(inputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (inputQualList == null) {
			inputQualList = new ArrayList<NewInputQualMgtDto>();
		}
		return new PageInfo<NewInputQualMgtDto>(inputQualList, pageRequestVo, rowCount);
	}

	// 공구 정비이력 입력/수정
	@Transactional
	public String setInputQualAddSave(NewInputQualMgtDto inputQualMgtDto) {
		String returnKey = "";
		try {
			inputQualMgtDto.setCreatorId(JteUtils.getUserId());
			inputQualMgtDto.setUpdatorId(JteUtils.getUserId());

			if (inputQualMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				newInputQualMgtMapper.insertInputQualAdd(inputQualMgtDto);

				returnKey = inputQualMgtDto.getControlNo();

				newInputQualMgtMapper.updateInputQual(inputQualMgtDto);

			} else if (inputQualMgtDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				newInputQualMgtMapper.updateInputQualAdd(inputQualMgtDto);

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
	public int setInputQualAddDelete(List<NewInputQualMgtDto> inputQualList) {
		int resultInt = -1;
		try {
			// 공구정비이력 삭제
			for (NewInputQualMgtDto inputQualMgtDto : inputQualList) {
				newInputQualMgtMapper.deleteInputQualAdd(inputQualMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
}
