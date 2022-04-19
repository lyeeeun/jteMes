package jin.mes.form.mtrl.mtrltoolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.mapper.mtrl.mtrltoolMgt.MtrltoolMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class MtrltoolMgtService {

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

	// 공구 상세 입력/수정
	@Transactional
	public String setToolMgtSave(MtrltoolMgtDto toolMgtDto) {
		String returnKey = "";
		try {
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());

			if (toolMgtDto.getAction().equals("C")) {// 공구상세 등록

//				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//				Calendar cal = Calendar.getInstance();
//				// 검증기간이 null인 경우
//				if (toolMgtDto.getToolMgtVerif() == null || toolMgtDto.getToolMgtVerif().equals("")) {
//					// 입고일 시간 세팅
//					cal.setTime(df.parse(toolMgtDto.getToolMgtPurchase()));
//					// 입고일 + 정비기간(공구마스터 정보)
//					cal.add(Calendar.DATE, toolMgtDto.getToolMaintenance());
//					// 검증일 세팅
//					toolMgtDto.setToolMgtVerif(df.format(cal.getTime()));
//				}

				// 공구상세 입력
				mtrltoolMgtMapper.insertToolMgt(toolMgtDto);

				returnKey = toolMgtDto.getToolMgtId();

				// 다국어 저장
				if (toolMgtDto.getMsgList() != null && toolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(toolMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			} else if (toolMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구상세 수정
				mtrltoolMgtMapper.updateToolMgt(toolMgtDto);

				returnKey = toolMgtDto.getToolMgtId();

				// 다국어 저장
				if (toolMgtDto.getMsgList() != null && toolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(toolMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}else if(toolMgtDto.getAction().equals("D")) {//공구 폐기처분
				
				mtrltoolMgtMapper.updateToolMgtIsDel(toolMgtDto);
				returnKey = toolMgtDto.getToolMgtId();
			}
//			else if (toolMgtDto.getAction().equals("USE")) {// 공구상세 잠금/해제
//				if (toolMgtDto.isUse()) {
//					toolMgtDto.setUse(false);
//				} else {
//					toolMgtDto.setUse(true);
//				}
//				// 공구상세 잠금수정
//				mtrltoolMgtMapper.updateToolMgt(toolMgtDto);
//
//				returnKey = toolMgtDto.getToolId();
//			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구상세 삭제
	@Transactional
	public int setToolMgtDelete(List<MtrltoolMgtDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구상세 삭제
			for (MtrltoolMgtDto toolMgtDto : toolMgtList) {
				mtrltoolMgtMapper.deleteToolMgt(toolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구상세  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
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

	// 공구사용정보 조회
	public PageInfo<MtrltoolMgtDto> getToolUseList(MtrltoolMgtDto toolMgtDto, PageRequestVo pageRequestVo) {
		List<MtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		toolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			// Count
			rowCount = mtrltoolMgtMapper.selectToolUseCount(toolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = mtrltoolMgtMapper.selectToolUseList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<MtrltoolMgtDto>();
		}
		return new PageInfo<MtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	// 공구교체가 있었는지 확인 - return 교체된 공구 sum, 없으면 0 리턴 
	public int getToolUseChangeTotal(MtrltoolMgtDto toolMgtDto) {
		int intResult = 0;
		try {
			intResult = mtrltoolMgtMapper.selectToolUseChangeTotal(toolMgtDto);
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		return intResult;
	}
	
	//공구사용 등록(공구사용이력 등록/수정- 공구사용량 수정)
	public String setToolUsePgSave(MtrltoolMgtDto toolMgtDto) {
		try {
			//등록자/수정자 등록
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());
  			
			//신규등록
			if(toolMgtDto.getAction().equals("C")) {
				//공구 사용이력 - 등록
				mtrltoolMgtMapper.insertToolUse(toolMgtDto);
			} else if(toolMgtDto.getAction().equals("U")){
				//공구 사용이력 - 수정
				mtrltoolMgtMapper.updateToolUse(toolMgtDto);
			}else if(toolMgtDto.getAction().equals("D")){
				//공구 사용이력 - 삭제
				mtrltoolMgtMapper.deleteToolUse(toolMgtDto);
			}
			
			//공구관리 - 수량 업데이트
			toolMgtDto.setToolMgtUse(mtrltoolMgtMapper.selectToolUseTotal(toolMgtDto));
			mtrltoolMgtMapper.updateToolMgt(toolMgtDto);
			
		} catch (Exception e) {
			throw new BusinessException("공구 사용 저장 에러입니다. : " + e.getMessage());
		}
		return toolMgtDto.getToolMgtId();
	}
	
	//공구사용 입력 - 관리자용
	public int setWorkToolPgInsert(List<MtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			for(MtrltoolMgtDto toolMgtDto : toolMgtList) {
				//공구 사용이력 - 등록
				mtrltoolMgtMapper.insertToolUse(toolMgtDto);
				
				//공구관리 - 수량 업데이트
				toolMgtDto.setToolMgtUse(mtrltoolMgtMapper.selectToolUseTotal(toolMgtDto));
				toolMgtDto.setUpdatorId(JteUtils.getUserId());
				mtrltoolMgtMapper.updateToolMgt(toolMgtDto);
			}
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 저장 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구사용 수정 - 관리자용
	public int setWorkToolPgUpdate(MtrltoolMgtDto toolMgtDto) {
		int returnKey = -1;
		try {
			//공구 사용이력 - 수정
			mtrltoolMgtMapper.updateToolUse(toolMgtDto);
			
			//공구관리 - 수량 업데이트
			toolMgtDto.setToolMgtUse(mtrltoolMgtMapper.selectToolUseTotal(toolMgtDto));
			toolMgtDto.setUpdatorId(JteUtils.getUserId());
			mtrltoolMgtMapper.updateToolMgt(toolMgtDto);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 수정 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구사용 완전삭제 - 관리자용
	public int setWorkToolPgDelete(List<MtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			for(MtrltoolMgtDto toolMgtDto : toolMgtList) {
				//공구 사용이력 - 삭제
				returnKey = mtrltoolMgtMapper.deleteToolUse(toolMgtDto);
				
				//공구관리 - 수량 업데이트
				toolMgtDto.setToolMgtUse(mtrltoolMgtMapper.selectToolUseTotal(toolMgtDto));
				toolMgtDto.setUpdatorId(JteUtils.getUserId());
				mtrltoolMgtMapper.updateToolMgt(toolMgtDto);
			}
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 삭제 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
}
