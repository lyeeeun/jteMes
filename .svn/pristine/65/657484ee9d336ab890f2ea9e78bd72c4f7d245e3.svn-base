package jin.mes.cform.mtrl.mtrltoolMgt;

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
public class NewMtrltoolMgtService {

	@Resource
	NewMtrltoolMgtMapper newMtrltoolMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 공구상세 조회
	public PageInfo<NewMtrltoolMgtDto> getToolMgtList(NewMtrltoolMgtDto newToolMgtDto, PageRequestVo pageRequestVo) {
		List<NewMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		newToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newMtrltoolMgtMapper.selectToolMgtCount(newToolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = newMtrltoolMgtMapper.selectToolMgtList(newToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<NewMtrltoolMgtDto>();
		}
		return new PageInfo<NewMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구 상세 입력/수정
	@Transactional
	public String setToolMgtSave(NewMtrltoolMgtDto newToolMgtDto) {
		String returnKey = "";
		try {
			newToolMgtDto.setCreatorId(JteUtils.getUserId());
			newToolMgtDto.setUpdatorId(JteUtils.getUserId());

			if (newToolMgtDto.getAction().equals("C")) {// 공구상세 등록

//				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//				Calendar cal = Calendar.getInstance();
//				// 검증기간이 null인 경우
//				if (newToolMgtDto.getToolMgtVerif() == null || newToolMgtDto.getToolMgtVerif().equals("")) {
//					// 입고일 시간 세팅
//					cal.setTime(df.parse(newToolMgtDto.getToolMgtPurchase()));
//					// 입고일 + 정비기간(공구마스터 정보)
//					cal.add(Calendar.DATE, newToolMgtDto.getToolMaintenance());
//					// 검증일 세팅
//					newToolMgtDto.setToolMgtVerif(df.format(cal.getTime()));
//				}

				// 공구상세 입력
				newMtrltoolMgtMapper.insertToolMgt(newToolMgtDto);

				returnKey = newToolMgtDto.getToolMgtId();

				// 다국어 저장
				if (newToolMgtDto.getMsgList() != null && newToolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newToolMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			} else if (newToolMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구상세 수정
				newMtrltoolMgtMapper.updateToolMgt(newToolMgtDto);

				returnKey = newToolMgtDto.getToolMgtId();

				// 다국어 저장
				if (newToolMgtDto.getMsgList() != null && newToolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(newToolMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}else if(newToolMgtDto.getAction().equals("D")) {//공구 폐기처분
				
				newMtrltoolMgtMapper.updateToolMgtIsDel(newToolMgtDto);
				returnKey = newToolMgtDto.getToolMgtId();
			}
//			else if (newToolMgtDto.getAction().equals("USE")) {// 공구상세 잠금/해제
//				if (newToolMgtDto.isUse()) {
//					newToolMgtDto.setUse(false);
//				} else {
//					newToolMgtDto.setUse(true);
//				}
//				// 공구상세 잠금수정
//				newMtrltoolMgtMapper.updateToolMgt(newToolMgtDto);
//
//				returnKey = newToolMgtDto.getToolId();
//			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구상세 삭제
	@Transactional
	public int setToolMgtDelete(List<NewMtrltoolMgtDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구상세 삭제
			for (NewMtrltoolMgtDto newToolMgtDto : toolMgtList) {
				newMtrltoolMgtMapper.deleteToolMgt(newToolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구상세  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

	// 공구정비이력 조회
	public PageInfo<NewMtrltoolMgtDto> getToolMtncList(NewMtrltoolMgtDto newToolMgtDto, PageRequestVo pageRequestVo) {
		List<NewMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		newToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newMtrltoolMgtMapper.selectToolMtncCount(newToolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = newMtrltoolMgtMapper.selectToolMtncList(newToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<NewMtrltoolMgtDto>();
		}
		return new PageInfo<NewMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구 정비이력 입력/수정
	@Transactional
	public String setToolMtncSave(NewMtrltoolMgtDto newToolMgtDto) {
		String returnKey = "";
		try {
			newToolMgtDto.setCreatorId(JteUtils.getUserId());
			newToolMgtDto.setUpdatorId(JteUtils.getUserId());

			if (newToolMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				newMtrltoolMgtMapper.insertToolMtnc(newToolMgtDto);

				returnKey = newToolMgtDto.getToolMtncId();

//				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//				Calendar cal = Calendar.getInstance();
//				// 입고일 시간 세팅
//				cal.setTime(df.parse(newToolMgtDto.getToolMtncEnd()));
//				// 입고일 + 정비기간(공구마스터 정보)
//				cal.add(Calendar.DATE, newToolMgtDto.getToolMaintenance());
//				// 검증일 세팅
//				newToolMgtDto.setToolMgtVerif(df.format(cal.getTime()));

				newMtrltoolMgtMapper.updateToolMgt(newToolMgtDto);

			} else if (newToolMgtDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				newMtrltoolMgtMapper.updateToolMtnc(newToolMgtDto);

				returnKey = newToolMgtDto.getToolMtncId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구정비이력  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구정비이력 삭제
	@Transactional
	public int setToolMtncDelete(List<NewMtrltoolMgtDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구정비이력 삭제
			for (NewMtrltoolMgtDto newToolMgtDto : toolMgtList) {
				newMtrltoolMgtMapper.deleteToolMtnc(newToolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

	// 공구사용정보 조회
	public PageInfo<NewMtrltoolMgtDto> getToolUseList(NewMtrltoolMgtDto newToolMgtDto, PageRequestVo pageRequestVo) {
		List<NewMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		newToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			// Count
			rowCount = newMtrltoolMgtMapper.selectToolUseCount(newToolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = newMtrltoolMgtMapper.selectToolUseList(newToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<NewMtrltoolMgtDto>();
		}
		return new PageInfo<NewMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	// 공구교체가 있었는지 확인 - return 교체된 공구 sum, 없으면 0 리턴 
	public int getToolUseChangeTotal(NewMtrltoolMgtDto newToolMgtDto) {
		int intResult = 0;
		try {
			intResult = newMtrltoolMgtMapper.selectToolUseChangeTotal(newToolMgtDto);
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		return intResult;
	}
	
	//공구사용 등록(공구사용이력 등록/수정- 공구사용량 수정)
	public String setToolUsePgSave(NewMtrltoolMgtDto newToolMgtDto) {
		try {
			//등록자/수정자 등록
			newToolMgtDto.setCreatorId(JteUtils.getUserId());
			newToolMgtDto.setUpdatorId(JteUtils.getUserId());
  			
			//신규등록
			if(newToolMgtDto.getAction().equals("C")) {
				//공구 사용이력 - 등록
				newMtrltoolMgtMapper.insertToolUse(newToolMgtDto);
			} else if(newToolMgtDto.getAction().equals("U")){
				//공구 사용이력 - 수정
				newMtrltoolMgtMapper.updateToolUse(newToolMgtDto);
			}else if(newToolMgtDto.getAction().equals("D")){
				//공구 사용이력 - 삭제
				newMtrltoolMgtMapper.deleteToolUse(newToolMgtDto);
			}
			
			//공구관리 - 수량 업데이트
			newToolMgtDto.setToolMgtUse(newMtrltoolMgtMapper.selectToolUseTotal(newToolMgtDto));
			newMtrltoolMgtMapper.updateToolMgt(newToolMgtDto);
			
		} catch (Exception e) {
			throw new BusinessException("공구 사용 저장 에러입니다. : " + e.getMessage());
		}
		return newToolMgtDto.getToolMgtId();
	}
	
	//공구사용 입력 - 관리자용
	public int setWorkToolPgInsert(List<NewMtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			for(NewMtrltoolMgtDto newToolMgtDto : toolMgtList) {
				//공구 사용이력 - 등록
				newMtrltoolMgtMapper.insertToolUse(newToolMgtDto);
				
				//공구관리 - 수량 업데이트
				newToolMgtDto.setToolMgtUse(newMtrltoolMgtMapper.selectToolUseTotal(newToolMgtDto));
				newToolMgtDto.setUpdatorId(JteUtils.getUserId());
				newMtrltoolMgtMapper.updateToolMgt(newToolMgtDto);
			}
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 저장 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구사용 수정 - 관리자용
	public int setWorkToolPgUpdate(NewMtrltoolMgtDto newToolMgtDto) {
		int returnKey = -1;
		try {
			//공구 사용이력 - 수정
			newMtrltoolMgtMapper.updateToolUse(newToolMgtDto);
			
			//공구관리 - 수량 업데이트
			newToolMgtDto.setToolMgtUse(newMtrltoolMgtMapper.selectToolUseTotal(newToolMgtDto));
			newToolMgtDto.setUpdatorId(JteUtils.getUserId());
			newMtrltoolMgtMapper.updateToolMgt(newToolMgtDto);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 수정 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구사용 완전삭제 - 관리자용
	public int setWorkToolPgDelete(List<NewMtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			for(NewMtrltoolMgtDto newToolMgtDto : toolMgtList) {
				//공구 사용이력 - 삭제
				returnKey = newMtrltoolMgtMapper.deleteToolUse(newToolMgtDto);
				
				//공구관리 - 수량 업데이트
				newToolMgtDto.setToolMgtUse(newMtrltoolMgtMapper.selectToolUseTotal(newToolMgtDto));
				newToolMgtDto.setUpdatorId(JteUtils.getUserId());
				newMtrltoolMgtMapper.updateToolMgt(newToolMgtDto);
			}
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 삭제 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
}
