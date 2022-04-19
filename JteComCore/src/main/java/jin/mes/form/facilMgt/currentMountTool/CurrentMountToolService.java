package jin.mes.form.facilMgt.currentMountTool;


import java.util.ArrayList;

import java.util.List;

import javax.annotation.Resource;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jin.mes.form.facilMgt.currentMountTool.CurrentMountToolDto;
import jin.mes.form.facilMgt.currentMountTool.CurrentMountToolMapper;
import kr.co.itcall.jte.common.mvc.PageInfo;
import kr.co.itcall.jte.common.mvc.PageRequestVo;
import kr.co.itcall.jte.common.util.JteUtils;
import kr.co.itcall.jte.spring.config.exception.BusinessException;


@Service
@Transactional(transactionManager="transactionManager")

public class CurrentMountToolService {

	@Resource
    protected CurrentMountToolMapper currentMountToolMapper;
	
	//품목별 공구정보 조회
	public PageInfo<CurrentMountToolDto> getEqmtToolRtlList(CurrentMountToolDto currentMountToolDto, PageRequestVo pageRequestVo){
		List<CurrentMountToolDto> itemToolList = null;
		int rowCount = 0;

		// Page Setting
		currentMountToolDto.setFirstIndex(pageRequestVo.getBlockFirstPage());
		currentMountToolDto.setLastIndex(pageRequestVo.getBlockLastPage());

		try {
			//Count
			rowCount = currentMountToolMapper.selectEqmtToolListCount(currentMountToolDto);
			if (rowCount > 0) {
				//List
				itemToolList = currentMountToolMapper.selectEqmtToolList(currentMountToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Lot 조회 에러입니다. : " + e.getMessage());
		}
		if (itemToolList == null) {
			itemToolList = new ArrayList<CurrentMountToolDto>();
		}
		return new PageInfo<CurrentMountToolDto>(itemToolList, pageRequestVo, rowCount);
	}
	
    public CurrentMountToolDto getEqmtToolPop(CurrentMountToolDto currentMountToolDto) {
    	CurrentMountToolDto eqmtToolPop = null;
    	try {
    		eqmtToolPop = currentMountToolMapper.selectEqmtToolinfo(currentMountToolDto);
    		
    		if(!eqmtToolPop.getEqmtMgtId().equals(null)) {
    			MountDto mountDto = new MountDto();
    			mountDto.setEqmtMgtId(eqmtToolPop.getEqmtMgtId());
    			eqmtToolPop.setChildToolList(currentMountToolMapper.selectEqmtToolChild(mountDto));//에러발생
    		}
    		
    	}catch(Exception e){
    		throw new BusinessException("부품 업체관리팝업 조회 에러입니다. : " + e.getMessage());
    	}
    	return eqmtToolPop;
    }

	@Transactional
	public String setEqmtTool(CurrentMountToolDto currentMountToolDto) {
		String returnKey = "";
		try {
			currentMountToolDto.setCreatorId(JteUtils.getUserId());
			currentMountToolDto.setUpdatorId(JteUtils.getUserId());
			
			
			if(currentMountToolDto.getAction().equals("U")){//품목 변경
			
				currentMountToolMapper.updateEqmtTool(currentMountToolDto);
				
				returnKey =currentMountToolDto.getEqmtMgtId();
				
				setEqmtToolRtlSave(currentMountToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: setItem Error: " + e.getMessage());
		}
		return returnKey;
	}
	
	public List<CurrentMountToolDto> getRtlToolList(CurrentMountToolDto currentMountToolDto) {
		List<CurrentMountToolDto> rtlToolList = null;
		int rowCount = 0;
		
		try {
			rowCount = currentMountToolMapper.selectRtlToolCount(currentMountToolDto);
			if (rowCount > 0) {
				rtlToolList = currentMountToolMapper.selectRtlToolList(currentMountToolDto);
			}
		} catch (Exception e) {
			throw new BusinessException("Service: getAllCompList Error " + e.getMessage());
		}
		if (rtlToolList == null) {
			rtlToolList = new ArrayList<CurrentMountToolDto>();
		}
		
		return rtlToolList;
	}

	@Transactional
	public String setEqmtToolRtlSave(CurrentMountToolDto currentMountToolDto){
		String returnKey = "";
		
		try {
			for(MountDto mountDto : currentMountToolDto.getChildToolList()) {
				mountDto.setCreatorId(JteUtils.getUserId());
				mountDto.setUpdatorId(JteUtils.getUserId());
				
				if(mountDto.getAction().equals("C")) {//
					//공구입력
					mountDto.setEqmtMgtId(currentMountToolDto.getEqmtMgtId());
					currentMountToolMapper.insertRtlTool(mountDto);
					returnKey = mountDto.getToolId();
				}else if(mountDto.getAction().equals("D")) {
					currentMountToolMapper.deleteRtlTool(mountDto);
				}
			}
		} catch (Exception e) {
			returnKey = "";
			throw new BusinessException("공구구매 업체 저장 에러  : " + e.getMessage());
		}
		return returnKey;
	}
	
	
}
