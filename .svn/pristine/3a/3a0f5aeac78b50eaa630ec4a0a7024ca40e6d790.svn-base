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
//import lombok.Data;

@Service
public class NewInputQualMgtService {

	@Resource
	NewInputQualMgtMapper newInputQualMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 입고검사 조회
	public PageInfo<NewInputQualMgtDto> getInputQualList(NewInputQualMgtDto newInputQualMgtDto, PageRequestVo pageRequestVo) {
		List<NewInputQualMgtDto> inputQualList = null;
		int rowCount = 0;

		// Page Setting
		newInputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newInputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newInputQualMgtMapper.selectInputQualCount(newInputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualList = newInputQualMgtMapper.selectInputQualList(newInputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (inputQualList == null) {
			inputQualList = new ArrayList<NewInputQualMgtDto>();
		}
		return new PageInfo<NewInputQualMgtDto>(inputQualList, pageRequestVo, rowCount);
	}
	
	// 입고검사 입력/수정
	@Transactional
	public String setInputQualSave(NewInputQualMgtDto newInputQualMgtDto) {
		String returnKey = "";
		try {
			newInputQualMgtDto.setCreatorId(JteUtils.getUserId());
			newInputQualMgtDto.setUpdatorId(JteUtils.getUserId());
			
			if (newInputQualMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				newInputQualMgtMapper.updateInputQualHold(newInputQualMgtDto);
				
				returnKey = newInputQualMgtDto.getMtrlOrderId();
				
			}else if (newInputQualMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구상세 수정
				newInputQualMgtMapper.updateInputQualPass(newInputQualMgtDto);

				returnKey = newInputQualMgtDto.getQcNum();

				// 다국어 저장
				if (newInputQualMgtDto.getMsgList() != null && newInputQualMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newInputQualMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}
	
	
	// 입고검사 상세 조회
	public PageInfo<NewInputQualMgtDto> getInputQualDetailList(NewInputQualMgtDto newInputQualMgtDto, PageRequestVo pageRequestVo) {
		List<NewInputQualMgtDto> inputQualDetailList = null;
		int rowCount = 0;

		// Page Setting
		newInputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newInputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newInputQualMgtMapper.selectInputQualDetailCount(newInputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualDetailList = newInputQualMgtMapper.selectInputQualDetailList(newInputQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (inputQualDetailList == null) {
			inputQualDetailList = new ArrayList<NewInputQualMgtDto>();
		}
		return new PageInfo<NewInputQualMgtDto>(inputQualDetailList, pageRequestVo, rowCount);
	}
	
	// 입고검사 상세 입력/수정
	@Transactional
	public String setInputQualDetailSave(NewInputQualMgtDto newInputQualMgtDto) {
		String returnKey = "";
		try {
			newInputQualMgtDto.setCreatorId(JteUtils.getUserId());
			newInputQualMgtDto.setUpdatorId(JteUtils.getUserId());

			if (newInputQualMgtDto.getAction().equals("C")) {// 공구상세 등록


				// 공구상세 입력
				newInputQualMgtMapper.insertInputQualDetail(newInputQualMgtDto);

				returnKey = newInputQualMgtDto.getQcNum();

				// 다국어 저장
				if (newInputQualMgtDto.getMsgList() != null && newInputQualMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newInputQualMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			} else if (newInputQualMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구상세 수정
				newInputQualMgtMapper.updateInputQualDetail(newInputQualMgtDto);
				
				newInputQualMgtMapper.updateInputQualAddup(newInputQualMgtDto);

				returnKey = newInputQualMgtDto.getQcNum();

				// 다국어 저장
				if (newInputQualMgtDto.getMsgList() != null && newInputQualMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newInputQualMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	
	
	// 공구정비이력 조회
	public PageInfo<NewInputQualMgtDto> getInputQualAddList(NewInputQualMgtDto newInputQualMgtDto, PageRequestVo pageRequestVo) {
		List<NewInputQualMgtDto> inputQualList = null;
		int rowCount = 0;

		// Page Setting
		newInputQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newInputQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newInputQualMgtMapper.selectInputQualAddCount(newInputQualMgtDto);
			if (rowCount > 0) {
				// List
				inputQualList = newInputQualMgtMapper.selectInputQualAddList(newInputQualMgtDto);
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
	public String setInputQualAddSave(NewInputQualMgtDto newInputQualMgtDto) {
		String returnKey = "";
		try {
			newInputQualMgtDto.setCreatorId(JteUtils.getUserId());
			newInputQualMgtDto.setUpdatorId(JteUtils.getUserId());

			if (newInputQualMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				newInputQualMgtMapper.insertInputQualAdd(newInputQualMgtDto);

				returnKey = newInputQualMgtDto.getControlNo();

				newInputQualMgtMapper.updateInputQualAdd(newInputQualMgtDto);

			} else if (newInputQualMgtDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				newInputQualMgtMapper.updateInputQualAdd(newInputQualMgtDto);
				

				returnKey = newInputQualMgtDto.getControlNo();
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
			for (NewInputQualMgtDto newInputQualMgtDto : inputQualList) {
				newInputQualMgtMapper.deleteInputQualAdd(newInputQualMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
}
