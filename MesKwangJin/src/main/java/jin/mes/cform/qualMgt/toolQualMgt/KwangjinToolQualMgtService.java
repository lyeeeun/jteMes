package jin.mes.cform.qualMgt.toolQualMgt;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.cform.qualMgt.toolQualMgt.KwangjinToolQualMgtDto;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Service
public class KwangjinToolQualMgtService {

	@Resource
	protected KwangjinToolQualMgtMapper kwangjinToolQualMgtMapper;
	
	public PageInfo<KwangjinToolQualMgtDto> getToolMgtList(KwangjinToolQualMgtDto kwangjinToolQualMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinToolQualMgtDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinToolQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinToolQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinToolQualMgtMapper.selectToolMgtCount(kwangjinToolQualMgtDto);
			if (rowCount > 0) {
				//List
				toolMgtList = kwangjinToolQualMgtMapper.selectToolMgtList(kwangjinToolQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구관리 조회 에러입니다. : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<KwangjinToolQualMgtDto>();
		}
		return new PageInfo<KwangjinToolQualMgtDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	public PageInfo<KwangjinToolQualMgtDto> getToolInfoList(KwangjinToolQualMgtDto kwangjinToolQualMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinToolQualMgtDto> toolInfoList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinToolQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinToolQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinToolQualMgtMapper.selectToolInfoCount(kwangjinToolQualMgtDto);
			if (rowCount > 0) {
				//List
				toolInfoList = kwangjinToolQualMgtMapper.selectToolInfoList(kwangjinToolQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolInfoList == null) {
			toolInfoList = new ArrayList<KwangjinToolQualMgtDto>();
		}
		return new PageInfo<KwangjinToolQualMgtDto>(toolInfoList, pageRequestVo, rowCount);
	}
	
	public PageInfo<KwangjinToolQualMgtDto> getToolQualList(KwangjinToolQualMgtDto kwangjinToolQualMgtDto, PageRequestVo pageRequestVo){
		List<KwangjinToolQualMgtDto> toolQualList = null;
		int rowCount = 0;

		// Page Setting
		kwangjinToolQualMgtDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		kwangjinToolQualMgtDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = kwangjinToolQualMgtMapper.selectToolQualCount(kwangjinToolQualMgtDto);
			if (rowCount > 0) {
				//List
				toolQualList = kwangjinToolQualMgtMapper.selectToolQualList(kwangjinToolQualMgtDto);
			}
		} catch (Exception e) {
			throw new BusinessException("발주주문정보 조회 에러입니다. : " + e.getMessage());
		}
		if (toolQualList == null) {
			toolQualList = new ArrayList<KwangjinToolQualMgtDto>();
		}
		return new PageInfo<KwangjinToolQualMgtDto>(toolQualList, pageRequestVo, rowCount);
	}
	
	// 공구 상세 입력/수정
	@Transactional
	public String setToolQualSave(KwangjinToolQualMgtDto kwangjinToolQualMgtDto) {
		String returnKey = "";
		try {
			if (kwangjinToolQualMgtDto.getAction().equals("C")) {
				
				kwangjinToolQualMgtMapper.insertToolQual(kwangjinToolQualMgtDto);
				returnKey = kwangjinToolQualMgtDto.getInspectId();

			} else if (kwangjinToolQualMgtDto.getAction().equals("U")) {
				
				kwangjinToolQualMgtMapper.updateToolQual(kwangjinToolQualMgtDto);
				returnKey = kwangjinToolQualMgtDto.getInspectId();
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("검사정보  입력 에러 : " + e.getMessage());
		}

		return returnKey;
	}

	// 공구상세 삭제
	@Transactional
	public int setToolQualDelete(List<KwangjinToolQualMgtDto> toolQualList) {
		int resultInt = -1;
		try {
			// 공구상세 삭제
			for (KwangjinToolQualMgtDto kwangjinToolQualMgtDto : toolQualList) {
				kwangjinToolQualMgtMapper.deleteToolQual(kwangjinToolQualMgtDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("검사정보  삭제 에러 : " + e.getMessage());
		}

		return resultInt;
	}
}
