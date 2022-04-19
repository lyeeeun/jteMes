package jin.mes.form.facilMgt.facilMountTool;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.facilMgt.facilMountTool.FacilMountToolDto;
import jin.mes.form.facilMgt.facilMountTool.EqipToolDto;
import jin.mes.form.facilMgt.facilMountTool.FacilMountToolMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;

@Service
@Transactional(transactionManager="transactionManager")

public class FacilMountToolService {

	@Resource
    protected FacilMountToolMapper facilMountToolMapper;
		
	//설비 조회
	public PageInfo<FacilMountToolDto> getEqmtToolRtlList(FacilMountToolDto facilMountToolDto, PageRequestVo pageRequestVo){
		List<FacilMountToolDto> itemToolList = null;
		int rowCount = 0;

		// Page Setting
		facilMountToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		facilMountToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = facilMountToolMapper.selectEqmtToolListCount(facilMountToolDto);
			if (rowCount > 0) {
				//List
				itemToolList = facilMountToolMapper.selectEqmtToolList(facilMountToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (itemToolList == null) {
			itemToolList = new ArrayList<FacilMountToolDto>();
		}
		return new PageInfo<FacilMountToolDto>(itemToolList, pageRequestVo, rowCount);
	}
	
	//설비-공구 매핑
	public FacilMountToolDto getEqmtToolPop(FacilMountToolDto facilMountToolDto) {
		FacilMountToolDto eqmtToolPop = null;
		try {
			eqmtToolPop = facilMountToolMapper.selectEqmtToolinfo(facilMountToolDto);
			
			if(!eqmtToolPop.getEqmtMgtId().equals(null)) {
				EqipToolDto eqipToolDto = new EqipToolDto();
				eqipToolDto.setEqmtMgtId(eqmtToolPop.getEqmtMgtId());
				eqmtToolPop.setChildToolList(facilMountToolMapper.selectEqmtToolChild(eqipToolDto));//에러발생
			}
			
		}catch(Exception e){
			throw new BusinessException("부품 업체관리팝업 조회 에러입니다. : " + e.getMessage());
		}
		return eqmtToolPop;
	}
	
	//설비-공구 관련 매핑
	@Transactional
	public String setEqmtTool(FacilMountToolDto facilMountToolDto) {
		String returnKey = "";
		try {
			facilMountToolDto.setCreatorId(JteUtils.getUserId());
			facilMountToolDto.setUpdatorId(JteUtils.getUserId());
			
			
			if(facilMountToolDto.getAction().equals("U")){//품목 변경
			
				facilMountToolMapper.updateEqmtTool(facilMountToolDto);
				
				returnKey =facilMountToolDto.getEqmtMgtId();
				
				setEqmtToolRtlSave(facilMountToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
		return returnKey;
	}
	
	//설비-공구 등록&삭제
	@Transactional
	public String setEqmtToolRtlSave(FacilMountToolDto facilMountToolDto){
		String returnKey = "";
		
		try {
			for(EqipToolDto eqipToolDto : facilMountToolDto.getChildToolList()) {
				eqipToolDto.setCreatorId(JteUtils.getUserId());
				eqipToolDto.setUpdatorId(JteUtils.getUserId());
				
				if(eqipToolDto.getAction().equals("C")) {//
					//공구입력
					eqipToolDto.setEqmtMgtId(facilMountToolDto.getEqmtMgtId());
					facilMountToolMapper.insertRtlTool(eqipToolDto);
					returnKey = eqipToolDto.getToolId();
				}else if(eqipToolDto.getAction().equals("D")) {
					facilMountToolMapper.deleteRtlTool(eqipToolDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구구매 업체 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}

	//설비-공구에 매핑된 상세공구 조회
	public PageInfo<EqipToolDto> getToolEqipList(EqipToolDto eqipToolDto, PageRequestVo pageRequestVo){
		List<EqipToolDto> toolMgtRtlList = null;
		int rowCount = 0;

		// Page Setting
		eqipToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		eqipToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = facilMountToolMapper.selectToolEqipCount(eqipToolDto);
			if (rowCount > 0) {
				//List
				toolMgtRtlList = facilMountToolMapper.selectToolEqipList(eqipToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (toolMgtRtlList == null) {
			toolMgtRtlList = new ArrayList<EqipToolDto>();
		}
		return new PageInfo<EqipToolDto>(toolMgtRtlList, pageRequestVo, rowCount);
	}
	
	//상세공구 조회
	public PageInfo<EqipToolDto> getToolMgtMountList(EqipToolDto eqipToolDto, PageRequestVo pageRequestVo) {
		List<EqipToolDto> toolMgtList = null;
		int rowCount = 0;

		// Page Setting
		eqipToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		eqipToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			// Count
			rowCount = facilMountToolMapper.selectToolMgtMountCount(eqipToolDto);
			if (rowCount > 0) {
				// List
				toolMgtList = facilMountToolMapper.selectToolMgtMountList(eqipToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("공구상세 조회 에러입니다.(List) : " + e.getMessage());
		}
		if (toolMgtList == null) {
			toolMgtList = new ArrayList<EqipToolDto>();
		}
		return new PageInfo<EqipToolDto>(toolMgtList, pageRequestVo, rowCount);
	}
	
	//설비-공구에 매핑된 상세공구 조회
	@Transactional
	public String setToolMgtRtl(EqipToolDto eqipToolDto) {
		String returnKey = "";
		try {
			eqipToolDto.setCreatorId(JteUtils.getUserId());
			eqipToolDto.setUpdatorId(JteUtils.getUserId());
			
			
			if(eqipToolDto.getAction().equals("C")){//품목 변경
			
				facilMountToolMapper.insertToolEqip(eqipToolDto);
				
				returnKey =eqipToolDto.getToolMgtId();
				
				facilMountToolMapper.updateDupl(eqipToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
		return returnKey;
	}
		
	public int delUpdateTool(List<EqipToolDto> toolMgtList){
		int resultInt = -1;
		try {
			//공구삭제
			for(EqipToolDto eqipToolDto : toolMgtList){
				facilMountToolMapper.deleteToolEqip(eqipToolDto);
				
				facilMountToolMapper.updateDuplZero(eqipToolDto);
			}
		} catch (Exception e) {
			resultInt = -1;
			throw new BusinessException("공구 삭제 에러  : " + e.getMessage());
		}
		return resultInt;
	}
}
