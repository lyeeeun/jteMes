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
public class ZinixWrkinTeamMgtService {
	@Resource
	ZinixWrkinTeamMgtMapper zinixAsgnMapper;
	
	// 작업지시 조회
	public PageInfo<ZinixWrkinTeamMgtDto> getAsgnList(ZinixWrkinTeamMgtDto asgnDto, PageRequestVo pageRequestVo) {
		List<ZinixWrkinTeamMgtDto> asgnList = null;
		int rowCount = 0;

		// Page Setting
		asgnDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		asgnDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = zinixAsgnMapper.selectAsgnCount(asgnDto);
			if (rowCount > 0) {
				// List
				asgnList = zinixAsgnMapper.selectAsgnList(asgnDto);
			}
		} catch (Exception e) {
			throw new BusinessException("작업지시 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (asgnList == null) {
			asgnList = new ArrayList<ZinixWrkinTeamMgtDto>();
		}
		return new PageInfo<ZinixWrkinTeamMgtDto>(asgnList, pageRequestVo, rowCount);
	}

	// 작업지시 팝업 조회
		public List<ZinixWrkinTeamMgtDto> getAsgnPop(ZinixWrkinTeamMgtDto asgnDto) {
			List<ZinixWrkinTeamMgtDto> asgnList = null;
			try {
				asgnList = zinixAsgnMapper.selectAsgnPop(asgnDto);
			} catch (Exception e) {
				throw new BusinessException("작업지시 조회 에러입니다.(Pop) : " + e.getMessage());
			}
			if (asgnList == null) {
				asgnList = new ArrayList<ZinixWrkinTeamMgtDto>();
			}
			return asgnList;
		}

		
	// 작업지시 입력/수정
	@Transactional
	public String setAsgnSave(ZinixWrkinTeamMgtDto asgnDto) {
		String returnKey = "";
		try {
			asgnDto.setCreatorId(JteUtils.getUserId());
			//생산지시
			if (asgnDto.getAction().equals("C")) {// 작업지시 등록
				//작업지시일 세팅
				asgnDto.setProdAsmDate(asgnDto.getProdPlanYear()+"-"+asgnDto.getProdPlanMonth()+"-"+asgnDto.getProdPlanDay());
				// 작업지시 입력
				zinixAsgnMapper.insertAsgn(asgnDto);
				returnKey = asgnDto.getProdAsmId();
			} else if (asgnDto.getAction().equals("U")) {// 작업지시 수정
				// 작업지시 수정
				zinixAsgnMapper.updateAsgn(asgnDto);
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
	public int setAsgnDelete(List<ZinixWrkinTeamMgtDto> asgnList) {
		int resultInt = -1;
		try {
			// 작업지시 삭제
			for (ZinixWrkinTeamMgtDto asgnDto : asgnList) {
				zinixAsgnMapper.deleteAsgn(asgnDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("작업지시  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}

}
