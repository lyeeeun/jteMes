package jin.mes.cform.mtrl.mtrltoolMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.basMgt.codMgt.msgMgt.MsgMgtServiceImpl;
import jin.mes.cform.mtrl.mtrltoolMgt.ZinixMtrltoolMgtDto;
import jin.mes.cform.mtrl.mtrltoolMgt.ZinixMtrltoolMgtMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class ZinixMtrltoolMgtService {

	@Resource
	ZinixMtrltoolMgtMapper zinixMtrltoolMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;

	// 공구상세 조회
	public PageInfo<ZinixMtrltoolMgtDto> getToolMgtList(ZinixMtrltoolMgtDto zinixToolMgtDto, PageRequestVo pageRequestVo) {
		List<ZinixMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		zinixToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		zinixToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = zinixMtrltoolMgtMapper.selectToolMgtCount(zinixToolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = zinixMtrltoolMgtMapper.selectToolMgtList(zinixToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ZinixMtrltoolMgtDto>();
		}
		return new PageInfo<ZinixMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구 상세 입력/수정
	@Transactional
	public String setToolMgtSave(ZinixMtrltoolMgtDto zinixToolMgtDto) {
		String returnKey = "";
		try {
			zinixToolMgtDto.setCreatorId(JteUtils.getUserId());
			zinixToolMgtDto.setUpdatorId(JteUtils.getUserId());

			if (zinixToolMgtDto.getAction().equals("C")) {// 공구상세 등록

//				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//				Calendar cal = Calendar.getInstance();
//				// 검증기간이 null인 경우
//				if (zinixToolMgtDto.getToolMgtVerif() == null || zinixToolMgtDto.getToolMgtVerif().equals("")) {
//					// 입고일 시간 세팅
//					cal.setTime(df.parse(zinixToolMgtDto.getToolMgtPurchase()));
//					// 입고일 + 정비기간(공구마스터 정보)
//					cal.add(Calendar.DATE, zinixToolMgtDto.getToolMaintenance());
//					// 검증일 세팅
//					zinixToolMgtDto.setToolMgtVerif(df.format(cal.getTime()));
//				}

				// 공구상세 입력
				zinixMtrltoolMgtMapper.insertToolMgt(zinixToolMgtDto);

				returnKey = zinixToolMgtDto.getToolMgtId();

				// 다국어 저장
				if (zinixToolMgtDto.getMsgList() != null && zinixToolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(zinixToolMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			} else if (zinixToolMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구상세 수정
				zinixMtrltoolMgtMapper.updateToolMgt(zinixToolMgtDto);

				returnKey = zinixToolMgtDto.getToolMgtId();

				// 다국어 저장
				if (zinixToolMgtDto.getMsgList() != null && zinixToolMgtDto.getMsgList().size() > 0) {
					msgService.pgSaveMsg(zinixToolMgtDto.getMsgList(), "eqmgt", returnKey);
				}
			}else if(zinixToolMgtDto.getAction().equals("D")) {//공구 폐기처분
				
				zinixMtrltoolMgtMapper.updateToolMgtIsDel(zinixToolMgtDto);
				returnKey = zinixToolMgtDto.getToolMgtId();
			}
//			else if (zinixToolMgtDto.getAction().equals("USE")) {// 공구상세 잠금/해제
//				if (zinixToolMgtDto.isUse()) {
//					zinixToolMgtDto.setUse(false);
//				} else {
//					zinixToolMgtDto.setUse(true);
//				}
//				// 공구상세 잠금수정
//				zinixMtrltoolMgtMapper.updateToolMgt(zinixToolMgtDto);
//
//				returnKey = zinixToolMgtDto.getToolId();
//			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구상세  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구상세 삭제
	@Transactional
	public int setToolMgtDelete(List<ZinixMtrltoolMgtDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구상세 삭제
			for (ZinixMtrltoolMgtDto zinixToolMgtDto : toolMgtList) {
				zinixMtrltoolMgtMapper.deleteToolMgt(zinixToolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구상세  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

	// 공구정비이력 조회
	public PageInfo<ZinixMtrltoolMgtDto> getToolMtncList(ZinixMtrltoolMgtDto zinixToolMgtDto, PageRequestVo pageRequestVo) {
		List<ZinixMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		zinixToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		zinixToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = zinixMtrltoolMgtMapper.selectToolMtncCount(zinixToolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = zinixMtrltoolMgtMapper.selectToolMtncList(zinixToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ZinixMtrltoolMgtDto>();
		}
		return new PageInfo<ZinixMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구 정비이력 입력/수정
	@Transactional
	public String setToolMtncSave(ZinixMtrltoolMgtDto zinixToolMgtDto) {
		String returnKey = "";
		try {
			zinixToolMgtDto.setCreatorId(JteUtils.getUserId());
			zinixToolMgtDto.setUpdatorId(JteUtils.getUserId());

			if (zinixToolMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				zinixMtrltoolMgtMapper.insertToolMtnc(zinixToolMgtDto);

				returnKey = zinixToolMgtDto.getToolMtncId();

//				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//				Calendar cal = Calendar.getInstance();
//				// 입고일 시간 세팅
//				cal.setTime(df.parse(zinixToolMgtDto.getToolMtncEnd()));
//				// 입고일 + 정비기간(공구마스터 정보)
//				cal.add(Calendar.DATE, zinixToolMgtDto.getToolMaintenance());
//				// 검증일 세팅
//				zinixToolMgtDto.setToolMgtVerif(df.format(cal.getTime()));

				zinixMtrltoolMgtMapper.updateToolMgt(zinixToolMgtDto);

			} else if (zinixToolMgtDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				zinixMtrltoolMgtMapper.updateToolMtnc(zinixToolMgtDto);

				returnKey = zinixToolMgtDto.getToolMtncId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구정비이력  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구정비이력 삭제
	@Transactional
	public int setToolMtncDelete(List<ZinixMtrltoolMgtDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구정비이력 삭제
			for (ZinixMtrltoolMgtDto zinixToolMgtDto : toolMgtList) {
				zinixMtrltoolMgtMapper.deleteToolMtnc(zinixToolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
	
	// 공구사용정보 조회
	public PageInfo<ZinixMtrltoolMgtDto> getToolUseList(ZinixMtrltoolMgtDto zinixToolMgtDto, PageRequestVo pageRequestVo) {
		List<ZinixMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		zinixToolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		zinixToolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());
		
		try {
			// Count
			rowCount = zinixMtrltoolMgtMapper.selectToolUseCount(zinixToolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = zinixMtrltoolMgtMapper.selectToolUseList(zinixToolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<ZinixMtrltoolMgtDto>();
		}
		return new PageInfo<ZinixMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	// 공구교체가 있었는지 확인 - return 교체된 공구 sum, 없으면 0 리턴 
	public int getToolUseChangeTotal(ZinixMtrltoolMgtDto zinixToolMgtDto) {
		int intResult = 0;
		try {
			intResult = zinixMtrltoolMgtMapper.selectToolUseChangeTotal(zinixToolMgtDto);
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		return intResult;
	}
	
	//공구사용 등록(공구사용이력 등록/수정- 공구사용량 수정)
	public String setToolUsePgSave(ZinixMtrltoolMgtDto zinixToolMgtDto) {
		try {
			//등록자/수정자 등록
			zinixToolMgtDto.setCreatorId(JteUtils.getUserId());
			zinixToolMgtDto.setUpdatorId(JteUtils.getUserId());
  			
			//신규등록
			if(zinixToolMgtDto.getAction().equals("C")) {
				//공구 사용이력 - 등록
				zinixMtrltoolMgtMapper.insertToolUse(zinixToolMgtDto);
			} else if(zinixToolMgtDto.getAction().equals("U")){
				//공구 사용이력 - 수정
				zinixMtrltoolMgtMapper.updateToolUse(zinixToolMgtDto);
			}else if(zinixToolMgtDto.getAction().equals("D")){
				//공구 사용이력 - 삭제
				zinixMtrltoolMgtMapper.deleteToolUse(zinixToolMgtDto);
			}
			
			//공구관리 - 수량 업데이트
			zinixToolMgtDto.setToolMgtUse(zinixMtrltoolMgtMapper.selectToolUseTotal(zinixToolMgtDto));
			zinixMtrltoolMgtMapper.updateToolMgt(zinixToolMgtDto);
			
		} catch (Exception e) {
			throw new BusinessException("공구 사용 저장 에러입니다. : " + e.getMessage());
		}
		return zinixToolMgtDto.getToolMgtId();
	}
	
	//공구사용 입력 - 관리자용
	public int setWorkToolPgInsert(List<ZinixMtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			for(ZinixMtrltoolMgtDto zinixToolMgtDto : toolMgtList) {
				//공구 사용이력 - 등록
				zinixMtrltoolMgtMapper.insertToolUse(zinixToolMgtDto);
				
				//공구관리 - 수량 업데이트
				zinixToolMgtDto.setToolMgtUse(zinixMtrltoolMgtMapper.selectToolUseTotal(zinixToolMgtDto));
				zinixToolMgtDto.setUpdatorId(JteUtils.getUserId());
				zinixMtrltoolMgtMapper.updateToolMgt(zinixToolMgtDto);
			}
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 저장 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구사용 수정 - 관리자용
	public int setWorkToolPgUpdate(ZinixMtrltoolMgtDto zinixToolMgtDto) {
		int returnKey = -1;
		try {
			//공구 사용이력 - 수정
			zinixMtrltoolMgtMapper.updateToolUse(zinixToolMgtDto);
			
			//공구관리 - 수량 업데이트
			zinixToolMgtDto.setToolMgtUse(zinixMtrltoolMgtMapper.selectToolUseTotal(zinixToolMgtDto));
			zinixToolMgtDto.setUpdatorId(JteUtils.getUserId());
			zinixMtrltoolMgtMapper.updateToolMgt(zinixToolMgtDto);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 수정 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구사용 완전삭제 - 관리자용
	public int setWorkToolPgDelete(List<ZinixMtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			for(ZinixMtrltoolMgtDto zinixToolMgtDto : toolMgtList) {
				//공구 사용이력 - 삭제
				returnKey = zinixMtrltoolMgtMapper.deleteToolUse(zinixToolMgtDto);
				
				//공구관리 - 수량 업데이트
				zinixToolMgtDto.setToolMgtUse(zinixMtrltoolMgtMapper.selectToolUseTotal(zinixToolMgtDto));
				zinixToolMgtDto.setUpdatorId(JteUtils.getUserId());
				zinixMtrltoolMgtMapper.updateToolMgt(zinixToolMgtDto);
			}
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 삭제 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
}
