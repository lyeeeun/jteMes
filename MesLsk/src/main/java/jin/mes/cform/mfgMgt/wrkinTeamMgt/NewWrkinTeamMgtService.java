package jin.mes.cform.mfgMgt.wrkinTeamMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
public class NewWrkinTeamMgtService {
	@Resource
	NewWrkinTeamMgtMapper newAsgnMapper;
	
	// 작업지시 조회
	public PageInfo<NewWrkinTeamMgtDto> getAsgnList(NewWrkinTeamMgtDto newAsgnDto, PageRequestVo pageRequestVo) {
		List<NewWrkinTeamMgtDto> asgnList = null;
		int rowCount = 0;

		// Page Setting
		newAsgnDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		newAsgnDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = newAsgnMapper.selectAsgnCount(newAsgnDto);
			if (rowCount > 0) {
				// List
				asgnList = newAsgnMapper.selectAsgnList(newAsgnDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업지시 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<NewWrkinTeamMgtDto>();
		}
		return new PageInfo<NewWrkinTeamMgtDto>(asgnList, pageRequestVo, rowCount);
	}

	// 작업지시 팝업 조회
		public List<NewWrkinTeamMgtDto> getAsgnPop(NewWrkinTeamMgtDto newAsgnDto) {
			List<NewWrkinTeamMgtDto> asgnList = null;
			try {
				asgnList = newAsgnMapper.selectAsgnPop(newAsgnDto);
			} catch (Exception e) {
				throw new BusinessException("작업지시 조회 에러입니다.(Pop) : " + e.getMessage());
			}
			if (asgnList == null) {
				asgnList = new ArrayList<NewWrkinTeamMgtDto>();
			}
			return asgnList;
		}

		
	// 작업지시 입력/수정
	@Transactional
	public String setAsgnSave(NewWrkinTeamMgtDto newAsgnDto) {
		String returnKey = "";
		try {
			newAsgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (newAsgnDto.getAction().equals("C")) {// 작업지시 등록
				//작업지시일 세팅
				newAsgnDto.setProdAsmDate(newAsgnDto.getProdPlanYear()+"-"+newAsgnDto.getProdPlanMonth()+"-"+newAsgnDto.getProdPlanDay());
				// 작업지시 입력
				newAsgnMapper.insertAsgn(newAsgnDto);
				returnKey = newAsgnDto.getProdAsmId();
			} else if (newAsgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				newAsgnMapper.updateAsgn(newAsgnDto);
				returnKey = newAsgnDto.getProdAsmId();
			}
			//작업정보
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("작업지시  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 작업지시 삭제
	@Transactional
	public int setAsgnDelete(List<NewWrkinTeamMgtDto> asgnList) {
		int resultInt = -1;
		try {
			// 작업지시 삭제
			for (NewWrkinTeamMgtDto newAsgnDto : asgnList) {
				newAsgnMapper.deleteAsgn(newAsgnDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("작업지시  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

}
