package jin.mes.cform.facilMgt.mtrltoolMgt;

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
public class KwangjinMtrltoolMgtService {

	@Resource
	KwangjinMtrltoolMgtMapper kwangjinMtrltoolMgtMapper;

	@Autowired
	MsgMgtServiceImpl msgService;
	
	//공구 정보 조회
	public PageInfo<KwangjinMtrltoolMgtDto> getToolInfoList(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinMtrltoolMgtDto> toolInfoList = null;
		
		int rowCount = 0;

		// Page Setting
		kwangjinMtrltoolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinMtrltoolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinMtrltoolMgtMapper.selectToolInfoCount(kwangjinMtrltoolMgtDto);
			if (rowCount > 0) {
				//List
				toolInfoList = kwangjinMtrltoolMgtMapper.selectToolInfoList(kwangjinMtrltoolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolInfoList == null) {
			toolInfoList = new ArrayList<KwangjinMtrltoolMgtDto>();
		}
		return new PageInfo<KwangjinMtrltoolMgtDto>(toolInfoList, pageRequestVo, rowCount);
	}
	
	//공구 수량 히스토리(내역) 조회
	public PageInfo<KwangjinMtrltoolMgtDto> getToolRecevingHisList(KwangjinMtrltoolMgtDto kwangjinMtrltoolMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinMtrltoolMgtDto> toolQtyList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinMtrltoolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinMtrltoolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinMtrltoolMgtMapper.selectToolQtyCount(kwangjinMtrltoolMgtDto);
			if (rowCount > 0) {
				//List
				toolQtyList = kwangjinMtrltoolMgtMapper.selectToolQtyList(kwangjinMtrltoolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구 수량 히스토리 조회 에러입니다. : " + e.getMessage());
		}
		if (toolQtyList == null) {
			toolQtyList = new ArrayList<KwangjinMtrltoolMgtDto>();
		}
		return new PageInfo<KwangjinMtrltoolMgtDto>(toolQtyList, pageRequestVo, rowCount);
	}

	// 공구상세 조회
	public PageInfo<KwangjinMtrltoolMgtDto> getToolMgtList(KwangjinMtrltoolMgtDto toolMgtDto, PageRequestVo pageRequestVo) {
		List<KwangjinMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		toolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = kwangjinMtrltoolMgtMapper.selectToolMgtCount(toolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = kwangjinMtrltoolMgtMapper.selectToolMgtList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<KwangjinMtrltoolMgtDto>();
		}
		return new PageInfo<KwangjinMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구 상세 입력/수정
	@Transactional
	public String setToolMgtSave(KwangjinMtrltoolMgtDto toolMgtDto) {
		String returnKey = "";
		String toolMgtUse = toolMgtDto.getToolMgtGbn();
		String toolUse = "toolUse";
		int toolUseQty = toolMgtDto.getToolMgtQty();
		
		//공구 사용시 수량 -로 변환
		if(toolMgtUse.equals(toolUse)) {
			toolMgtDto.setToolMgtQty(toolUseQty*(-1));
		}
		
		try {
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());
			if (toolMgtDto.getAction().equals("C")) {
				// 공구 수량 정보 등록
				kwangjinMtrltoolMgtMapper.insertToolMgt(toolMgtDto);
				returnKey = toolMgtDto.getToolMgtId();

			} else if (toolMgtDto.getAction().equals("U")) {// 공구상세 수정
				// 공구 수량 정보 수정
				kwangjinMtrltoolMgtMapper.updateToolMgt(toolMgtDto);
				returnKey = toolMgtDto.getToolMgtId();
				
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구 수량 정보  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구상세 삭제
	@Transactional
	public int setToolMgtDelete(List<KwangjinMtrltoolMgtDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구상세 삭제
			for (KwangjinMtrltoolMgtDto toolMgtDto : toolMgtList) {
				kwangjinMtrltoolMgtMapper.deleteToolMgt(toolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구상세  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

	
	
	/* 
	 * 
	 * 
	 * 
	 * 기존 공구 상세 정보
	 * 
	 * 
	 * 
	 * 
	 * */
	
	// 공구정비이력 조회
	public PageInfo<KwangjinMtrltoolMgtDto> getToolMtncList(KwangjinMtrltoolMgtDto toolMgtDto, PageRequestVo pageRequestVo) {
		List<KwangjinMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		toolMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		toolMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = kwangjinMtrltoolMgtMapper.selectToolMtncCount(toolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = kwangjinMtrltoolMgtMapper.selectToolMtncList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정비이력 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<KwangjinMtrltoolMgtDto>();
		}
		return new PageInfo<KwangjinMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}

	// 공구 정비이력 입력/수정
	@Transactional
	public String setToolMtncSave(KwangjinMtrltoolMgtDto toolMgtDto) {
		String returnKey = "";
		try {
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());

			if (toolMgtDto.getAction().equals("C")) {// 공구정비이력 등록

				// 공구정비이력 입력
				kwangjinMtrltoolMgtMapper.insertToolMtnc(toolMgtDto);

				returnKey = toolMgtDto.getToolMtncId();

//				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//				Calendar cal = Calendar.getInstance();
//				// 입고일 시간 세팅
//				cal.setTime(df.parse(toolMgtDto.getToolMtncEnd()));
//				// 입고일 + 정비기간(공구마스터 정보)
//				cal.add(Calendar.DATE, toolMgtDto.getToolMaintenance());
//				// 검증일 세팅
//				toolMgtDto.setToolMgtVerif(df.format(cal.getTime()));

				kwangjinMtrltoolMgtMapper.updateToolMgt(toolMgtDto);

			} else if (toolMgtDto.getAction().equals("U")) {// 공구정비이력 수정
				// 공구정비이력 수정
				kwangjinMtrltoolMgtMapper.updateToolMtnc(toolMgtDto);

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
	public int setToolMtncDelete(List<KwangjinMtrltoolMgtDto> toolMgtList) {
		int resultInt = -1;
		try {
			// 공구정비이력 삭제
			for (KwangjinMtrltoolMgtDto toolMgtDto : toolMgtList) {
				kwangjinMtrltoolMgtMapper.deleteToolMtnc(toolMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구정비이력  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

	// 공구사용정보 조회
	public PageInfo<KwangjinMtrltoolMgtDto> getToolUseList(KwangjinMtrltoolMgtDto toolMgtDto, PageRequestVo pageRequestVo) {
		List<KwangjinMtrltoolMgtDto> toolMgtList = null;
		int rowCount = 0;
		
		try {
			// Count
			rowCount = kwangjinMtrltoolMgtMapper.selectToolUseCount(toolMgtDto);
			if (rowCount > 0) {
				// List
				toolMgtList = kwangjinMtrltoolMgtMapper.selectToolUseList(toolMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<KwangjinMtrltoolMgtDto>();
		}
		return new PageInfo<KwangjinMtrltoolMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	// 공구교체가 있었는지 확인 - return 교체된 공구 sum, 없으면 0 리턴 
	public int getToolUseChangeTotal(KwangjinMtrltoolMgtDto toolMgtDto) {
		int intResult = 0;
		try {
			intResult = kwangjinMtrltoolMgtMapper.selectToolUseChangeTotal(toolMgtDto);
		} catch (Exception e) {
			throw new BusinessException("공구사용정보 조회 에러입니다.(List) : " + e.getMessage());
		}
		return intResult;
	}
	
	//공구사용 등록(공구사용이력 등록/수정- 공구사용량 수정)
	public String setToolUsePgSave(KwangjinMtrltoolMgtDto toolMgtDto) {
		try {
			//등록자/수정자 등록
			toolMgtDto.setCreatorId(JteUtils.getUserId());
			toolMgtDto.setUpdatorId(JteUtils.getUserId());
  			
			//신규등록
			if(toolMgtDto.getAction().equals("C")) {
				//공구 사용이력 - 등록
				kwangjinMtrltoolMgtMapper.insertToolUse(toolMgtDto);
			} else if(toolMgtDto.getAction().equals("U")){
				//공구 사용이력 - 수정
				kwangjinMtrltoolMgtMapper.updateToolUse(toolMgtDto);
			}else if(toolMgtDto.getAction().equals("D")){
				//공구 사용이력 - 삭제
				kwangjinMtrltoolMgtMapper.deleteToolUse(toolMgtDto);
			}
			
			//공구관리 - 수량 업데이트
			kwangjinMtrltoolMgtMapper.updateToolMgt(toolMgtDto);
			
		} catch (Exception e) {
			throw new BusinessException("공구 사용 저장 에러입니다. : " + e.getMessage());
		}
		return toolMgtDto.getToolMgtId();
	}
	
	//공구사용 입력 - 관리자용
	public int setWorkToolPgInsert(List<KwangjinMtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			for(KwangjinMtrltoolMgtDto toolMgtDto : toolMgtList) {
				//공구 사용이력 - 등록
				kwangjinMtrltoolMgtMapper.insertToolUse(toolMgtDto);
				
				//공구관리 - 수량 업데이트
				toolMgtDto.setUpdatorId(JteUtils.getUserId());
				kwangjinMtrltoolMgtMapper.updateToolMgt(toolMgtDto);
			}
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 저장 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구사용 수정 - 관리자용
	public int setWorkToolPgUpdate(KwangjinMtrltoolMgtDto toolMgtDto) {
		int returnKey = -1;
		try {
			//공구 사용이력 - 수정
			kwangjinMtrltoolMgtMapper.updateToolUse(toolMgtDto);
			
			//공구관리 - 수량 업데이트
			toolMgtDto.setUpdatorId(JteUtils.getUserId());
			kwangjinMtrltoolMgtMapper.updateToolMgt(toolMgtDto);
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 수정 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}
	
	//공구사용 완전삭제 - 관리자용
	public int setWorkToolPgDelete(List<KwangjinMtrltoolMgtDto> toolMgtList) {
		int returnKey = -1;
		try {
			for(KwangjinMtrltoolMgtDto toolMgtDto : toolMgtList) {
				//공구 사용이력 - 삭제
				returnKey = kwangjinMtrltoolMgtMapper.deleteToolUse(toolMgtDto);
				
				//공구관리 - 수량 업데이트
				toolMgtDto.setUpdatorId(JteUtils.getUserId());
				kwangjinMtrltoolMgtMapper.updateToolMgt(toolMgtDto);
			}
		} catch (Exception e) {
			returnKey = -1;
			throw new BusinessException("공구 사용 삭제 에러입니다. : " + e.getMessage());
		}
		return returnKey;
	}

}
