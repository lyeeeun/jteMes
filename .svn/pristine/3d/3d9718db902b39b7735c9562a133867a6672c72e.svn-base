package jin.mes.form.mfgMgt.wrkinTeamMgt;

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
public class WrkinTeamMgtService {
	@Resource
	WrkinTeamMgtMapper asgnMapper;
	
	// 작업지시 조회
	public PageInfo<WrkinTeamMgtDto> getAsgnList(WrkinTeamMgtDto asgnDto, PageRequestVo pageRequestVo) {
		List<WrkinTeamMgtDto> asgnList = null;
		int rowCount = 0;

		// Page Setting
		asgnDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		asgnDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = asgnMapper.selectAsgnCount(asgnDto);
			if (rowCount > 0) {
				// List
				asgnList = asgnMapper.selectAsgnList(asgnDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업지시 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<WrkinTeamMgtDto>();
		}
		return new PageInfo<WrkinTeamMgtDto>(asgnList, pageRequestVo, rowCount);
	}

	// 작업지시 팝업 조회
		public List<WrkinTeamMgtDto> getAsgnPop(WrkinTeamMgtDto asgnDto) {
			List<WrkinTeamMgtDto> asgnList = null;
			try {
				asgnList = asgnMapper.selectAsgnPop(asgnDto);
			} catch (Exception e) {
				throw new BusinessException("작업지시 조회 에러입니다.(Pop) : " + e.getMessage());
			}
			if (asgnList == null) {
				asgnList = new ArrayList<WrkinTeamMgtDto>();
			}
			return asgnList;
		}

		
	// 작업지시 입력/수정
	@Transactional
	public String setAsgnSave(WrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업지시 등록
				//작업지시일 세팅
				asgnDto.setProdAsmDate(asgnDto.getProdPlanYear()+"-"+asgnDto.getProdPlanMonth()+"-"+asgnDto.getProdPlanDay());
				// 작업지시 입력
				asgnMapper.insertAsgn(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				asgnMapper.updateAsgn(asgnDto);
				returnKey = asgnDto.getProdAsmId();
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
	public int setAsgnDelete(List<WrkinTeamMgtDto> asgnList) {
		int resultInt = -1;
		try {
			// 작업지시 삭제
			for (WrkinTeamMgtDto asgnDto : asgnList) {
				asgnMapper.deleteAsgn(asgnDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("작업지시  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

}
